import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: ref.read(authProvider),
      google: ref.read(googleSignInProvider),
      firestore: ref.read(firestoreProvider),
    ));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _google;
  final FirebaseFirestore _firestore;

  CollectionReference get _usersRef => _firestore.collection("users");

  AuthRepository({required auth, required google, required firestore})
      : _auth = auth,
        _google = google,
        _firestore = firestore;

  Future<Either<String, UserModel>> signInGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _google.signIn();

      // if user didn't select any google profile
      if (googleUser == null) {
        return const Left("no_selection");
      }

      // create credential with tokens
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // sign in with google
      final userCredential = await _auth.signInWithCredential(credential);

      // create new user in database if user doesn't exist
      late UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        final userData = userCredential.user!;

        // create new user model
        userModel = UserModel(
          uid: userData.uid,
          username: userData.displayName!,
          email: userData.email!,
          registerType: "google",
        );

        // save user model to database
        await _usersRef.doc(userData.uid).set(userModel.toMap());
      } else {
        // get user model form database
        userModel = await _getUserModel(userCredential.user!.uid).first;
      }

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return const Left("firebase_error");
    } catch (e) {
      // if an unknown error occurred
      return const Left("error");
    }
  }

  // get user model form database
  Stream<UserModel> _getUserModel(String uid) {
    return _usersRef.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}

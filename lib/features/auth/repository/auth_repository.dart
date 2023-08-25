import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future<Either<String, UserModel>> signInWithGoogle() async {
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

      debugPrint(userModel.toString());

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return const Left("firebase_error");
    } catch (e) {
      // if an unknown error occurred
      return const Left("error");
    }
  }

  Future<Either<String, UserModel>> signInWithEmail(
      String email, String password) async {
    try {
      // get user credential with email and password
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // get user model
      final userModel = await _getUserModel(userCredential.user!.uid).first;

      debugPrint(userModel.toString());

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return const Left("firebase_error");
    } catch (e) {
      // if an unknown error occurred
      return const Left("error");
    }
  }

  Future<String> registerWithEmail(
      String username, String email, String password) async {
    try {
      // get user credential with email and password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create user model
      final userModel = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        registerType: "email",
      );

      // save user model to database
      await _usersRef.doc(userCredential.user!.uid).set(userModel.toMap());

      return "success";
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return "firebase_error";
    } catch (e) {
      // if an unknown error occurred
      return "error";
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      // send mail to reset password
      await _auth.sendPasswordResetEmail(email: email);

      return "success";
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return "firebase_error";
    } catch (e) {
      // if an unknown error occurred
      return "error";
    }
  }

  // get user model form database
  Stream<UserModel> _getUserModel(String uid) {
    return _usersRef.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}

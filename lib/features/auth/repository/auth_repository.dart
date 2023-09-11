import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/constants/keys.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/core/providers/storage_provider.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: ref.read(authProvider),
      google: ref.read(googleSignInProvider),
      firestore: ref.read(firestoreProvider),
      storage: ref.read(storageProvider),
      ref: ref,
    ));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _google;
  final FirebaseFirestore _firestore;
  final Storage _storage;
  final Ref _ref;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  AuthRepository({
    required auth,
    required google,
    required firestore,
    required storage,
    required ref,
  })  : _auth = auth,
        _google = google,
        _firestore = firestore,
        _storage = storage,
        _ref = ref;

  Future<Either<String, UserModel>> signInWithGoogle() async {
    try {
      final googleUser = await _google.signIn();

      // if user didn't select any google profile
      if (googleUser == null) {
        return const Left("cancel");
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

        // get date of now
        final date = getDateDMY();

        // get default profile and background picture
        final profilePic = await _storage.getFileURL(
          FirebaseConstants.defaultPath,
          "profile_pic.jpeg",
        );
        final backgroundPick = await _storage.getFileURL(
          FirebaseConstants.defaultPath,
          "background_pic.jpg",
        );

        // create new user model
        userModel = UserModel(
          uid: userData.uid,
          username: userData.displayName ?? "User",
          animeName: "",
          email: userData.email!,
          registerType: "google",
          profilePicURL: profilePic,
          backgroundPicURL: backgroundPick,
          joinDate: date,
        );

        // save user model to database
        await _setUserModel(userCredential.user!.uid, userModel);

        // create default lists
        await _createDefaultLists(userModel.uid, date);
      } else {
        // get user model form database
        userModel = await _getUserModel(userCredential.user!.uid);
      }

      debugPrint(userModel.toString());

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return Left(e.toString());
    } catch (e) {
      // if an unknown error occurred
      return const Left("error");
    }
  }

  Future<Either<String, UserModel>> signInWithTwitter() async {
    try {
      final twitterUser = TwitterLogin(
        apiKey: Keys.twitterApiKey,
        apiSecretKey: Keys.twitterApiSecret,
        redirectURI: Keys.redirectURI,
      );

      // get auth result
      final twitterAuth = await twitterUser.login();
      final twitterStatus = twitterAuth.status;

      if (twitterStatus == TwitterLoginStatus.loggedIn) {
        // create credential with tokens
        final credential = TwitterAuthProvider.credential(
          accessToken: twitterAuth.authToken!,
          secret: twitterAuth.authTokenSecret!,
        );

        // sign in with twitter
        final userCredential = await _auth.signInWithCredential(credential);

        // create new user in database if user doesn't exist
        late UserModel userModel;
        if (userCredential.additionalUserInfo!.isNewUser) {
          final userData = userCredential.user!;

          // get date of now
          final date = getDateDMY();

          // get default profile and background picture
          final profilePic = await _storage.getFileURL(
            FirebaseConstants.defaultPath,
            "profile_pic.jpeg",
          );
          final backgroundPick = await _storage.getFileURL(
            FirebaseConstants.defaultPath,
            "background_pic.jpg",
          );

          // create new user model
          userModel = UserModel(
            uid: userData.uid,
            username: userData.displayName ?? "User",
            animeName: "",
            email: userData.email!,
            registerType: "twitter",
            profilePicURL: profilePic,
            backgroundPicURL: backgroundPick,
            joinDate: date,
          );

          // save user model to database
          await _setUserModel(userCredential.user!.uid, userModel);

          // create default lists
          await _createDefaultLists(userModel.uid, date);
        } else {
          // get user model from database
          userModel = await _getUserModel(userCredential.user!.uid);
        }

        return Right(userModel);
      } else if (twitterStatus == TwitterLoginStatus.cancelledByUser) {
        return const Left("cancel");
      } else {
        return const Left("error");
      }
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return Left(e.code);
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
      final userModel = await _getUserModel(userCredential.user!.uid);

      debugPrint(userModel.toString());

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return Left(e.code);
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

      // get date of now
      final date = getDateDMY();

      // get default profile and background picture
      final profilePic = await _storage.getFileURL(
        FirebaseConstants.defaultPath,
        "profile_pic.jpeg",
      );
      final backgroundPick = await _storage.getFileURL(
        FirebaseConstants.defaultPath,
        "background_pic.jpg",
      );

      // create user model
      final userModel = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        animeName: "",
        email: email,
        registerType: "email",
        profilePicURL: profilePic,
        backgroundPicURL: backgroundPick,
        joinDate: date,
      );

      debugPrint(userModel.toString());

      // save user model to database
      await _setUserModel(userCredential.user!.uid, userModel);

      // create default lists
      await _createDefaultLists(userModel.uid, date);

      return "success";
    } on FirebaseAuthException catch (e) {
      // if a firebase error occurred
      return e.code;
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
      return e.code;
    } catch (e) {
      // if an unknown error occurred
      return "error";
    }
  }

  Future<String> signOut() async {
    try {
      final userModel = _ref.read(userProvider)!;

      if (userModel.registerType == Constants.googleRegister) {
        await _google.signOut();
      }
      await _auth.signOut();

      _ref.read(userProvider.notifier).update((state) => null);
      return "success";
    } catch (e) {
      return "error";
    }
  }

  // -------------------------------------------------------------------------------------------------------

  // get user model form database
  Future<UserModel> _getUserModel(String uid) {
    return _usersCollection
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>))
        .first;
  }

  // save user model to database
  Future<void> _setUserModel(String uid, UserModel userModel) async {
    await _usersCollection.doc(uid).set(userModel.toMap());
  }

  // create default lists for user creation
  Future<void> _createDefaultLists(String uid, String date) async {
    final userListCollection =
        _usersCollection.doc(uid).collection(FirebaseConstants.animeListRef);

    final favoritesList = AnimeList(
      name: Constants.favoriteListName,
      animes: [],
      createdDate: date,
    );

    await userListCollection
        .doc(Constants.favoriteListName)
        .set(favoritesList.toMap());

    final watchingList = AnimeList(
      name: Constants.watchingListName,
      animes: [],
      createdDate: date,
    );

    await userListCollection
        .doc(Constants.watchingListName)
        .set(watchingList.toMap());
  }
}

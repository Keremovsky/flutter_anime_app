import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/core/providers/storage_provider.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileRepositoryProvider = Provider((ref) => UserProfileRepository(
      storage: ref.read(storageProvider),
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class UserProfileRepository {
  final Storage _storage;
  final FirebaseFirestore _firestore;
  final Ref _ref;

  UserProfileRepository({required storage, required firestore, required ref})
      : _storage = storage,
        _firestore = firestore,
        _ref = ref;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  Future<bool> updateUserProfile(
    String? username,
    String? animeName,
    String? profileFilePath,
    String? bannerFilePath,
  ) async {
    try {
      UserModel userModel = _ref.read(userProvider)!;

      if (username != null) {
        userModel = userModel.copyWith(
          username: username,
        );
      }

      if (animeName != null) {
        userModel = userModel.copyWith(
          animeName: animeName,
        );
      }

      final path = "users/${userModel.uid}/";
      if (profileFilePath != null) {
        await _storage.storeFile(path, "profile", File(profileFilePath));

        final profilePicURL = await _storage.getFileURL(
          path,
          "profile",
        );

        userModel = userModel.copyWith(
          profilePicURL: profilePicURL,
        );
      }

      if (bannerFilePath != null) {
        await _storage.storeFile(path, "banner", File(bannerFilePath));

        final backgroundPicURL = await _storage.getFileURL(
          path,
          "banner",
        );

        userModel = userModel.copyWith(
          backgroundPicURl: backgroundPicURL,
        );
      }

      await _usersCollection.doc(userModel.uid).set(userModel.toMap());

      _ref.read(userProvider.notifier).update((state) => userModel);

      return true;
    } catch (e) {
      return false;
    }
  }
}

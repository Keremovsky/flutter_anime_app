import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socialRepositoryProvider = Provider((ref) => SocialRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class SocialRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  SocialRepository({required firestore, required ref})
      : _firestore = firestore,
        _ref = ref;

  Future<UserModel> getUserData(String uid) async {
    final userModel = await _getUserModel(uid);

    return userModel;
  }

  Future<String> setFollow(UserModel userModel) async {
    try {
      final currentUser = _ref.read(userProvider)!;

      await _setFollow(
        currentUser.uid,
        userModel.uid,
        FirebaseConstants.followingRef,
      );
      await _setFollow(
        userModel.uid,
        currentUser.uid,
        FirebaseConstants.followedRef,
      );

      await _setUserModel(
        userModel.copyWith(
          followedCount: userModel.followingCount + 1,
        ),
      );
      await _setUserModel(
        currentUser.copyWith(
          followedCount: userModel.followingCount + 1,
          followingUsers: userModel.followingUsers + [userModel.uid],
        ),
      );

      _ref.read(userProvider.notifier).update(
            (state) => currentUser.copyWith(
              followedCount: userModel.followedCount + 1,
              followingUsers: userModel.followingUsers + [userModel.uid],
            ),
          );

      return "success";
    } catch (e) {
      return "error";
    }
  }

  // -------------------------------------------------------------------------------------------------------

  // get user model form database
  Future<UserModel> _getUserModel(String uid) async {
    final result = await _usersCollection
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>))
        .first;

    return result;
  }

  // save user model to database
  Future<void> _setUserModel(UserModel userModel) async {
    await _usersCollection.doc(userModel.uid).set(userModel.toMap());
  }

  Future<void> _setFollow(String uid, String set, String type) async {
    await _usersCollection.doc(uid).collection(type).doc(set).set({"id": set});
  }
}

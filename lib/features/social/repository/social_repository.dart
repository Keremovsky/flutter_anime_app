import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/core/providers/storage_provider.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/action_model.dart';
import 'package:flutter_anime_app/models/post_model.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socialRepositoryProvider = Provider((ref) => SocialRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
      storage: ref.read(storageProvider),
    ));

class SocialRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;
  final Storage _storage;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  SocialRepository({required firestore, required ref, required storage})
      : _firestore = firestore,
        _ref = ref,
        _storage = storage;

  Future<UserModel> getUserData(String uid) async {
    final userModel = await _getUserModel(uid);

    return userModel;
  }

  Stream<UserModel> getUserDataStream(String uid) {
    final userModel = _getUserModelStream(uid);

    return userModel;
  }

  Future<String> setFollow(String uid) async {
    try {
      final currentUser = _ref.read(userProvider)!;
      final userModel = await _getUserModel(uid);

      if (currentUser.followingUsers.contains(userModel.uid)) {
        await _deleteFollow(
          currentUser.uid,
          userModel.uid,
          FirebaseConstants.followingRef,
        );
        await _deleteFollow(
          userModel.uid,
          currentUser.uid,
          FirebaseConstants.followedRef,
        );

        await _setUserModel(
          userModel.copyWith(
            followedCount: (userModel.followedCount - 1),
          ),
        );
        List<dynamic> followList = currentUser.followingUsers;
        followList.remove(userModel.uid);
        await _setUserModel(
          currentUser.copyWith(
            followingCount: (currentUser.followingCount - 1),
            followingUsers: followList,
          ),
        );

        _ref.read(userProvider.notifier).update(
              (state) => currentUser.copyWith(
                followingCount: (currentUser.followingCount - 1),
                followingUsers: followList,
              ),
            );
      } else {
        await _addFollow(
          currentUser.uid,
          userModel.uid,
          FirebaseConstants.followingRef,
        );
        await _addFollow(
          userModel.uid,
          currentUser.uid,
          FirebaseConstants.followedRef,
        );

        await _setUserModel(
          userModel.copyWith(
            followedCount: (userModel.followedCount + 1),
          ),
        );
        await _setUserModel(
          currentUser.copyWith(
            followingCount: (currentUser.followingCount + 1),
            followingUsers: currentUser.followingUsers + [userModel.uid],
          ),
        );

        _ref.read(userProvider.notifier).update(
              (state) => currentUser.copyWith(
                followingCount: (currentUser.followingCount + 1),
                followingUsers: currentUser.followingUsers + [userModel.uid],
              ),
            );
      }

      return "success";
    } catch (e) {
      return "error";
    }
  }

  Future<List<UserModel>> getUserList(String uid, String type) async {
    final idList = await _getFollowIDs(type, uid);

    final result = await _getUserList(idList);

    return result;
  }

  Future<void> saveLastAction(
    String uid,
    String type,
    String content,
    String animeID,
  ) async {
    final now = DateTime.now();

    final actionModel = ActionModel(
      type: type,
      content: content,
      animeID: animeID,
      date: Timestamp.fromDate(now),
    );

    _saveLastAction(uid, now.toString(), actionModel);
  }

  Stream<List<ActionModel>> getLastActionStream(String uid) {
    final result = _getLastActionStream(uid);

    return result;
  }

  Future<List<UserModel>> searchUser(String searchText) async {
    try {
      final userList = await _usersCollection
          .orderBy("username", descending: false)
          .startAt([searchText])
          .endAt([searchText + '\uf8ff'])
          .get()
          .then((value) {
            List<UserModel> userList = [];
            for (int i = 0; i < value.docs.length; i++) {
              final UserModel user = UserModel.fromMap(
                value.docs[i].data() as Map<String, dynamic>,
              );

              userList.add(user);
            }

            return userList;
          });

      return userList;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createPost(String postContent, String postImagePath) async {
    try {
      final currentUser = _ref.read(userProvider)!;

      final now = DateTime.now();
      final postId = currentUser.uid + now.toString();

      // upload image to firebase storage
      if (postImagePath != "") {
        final path = "users/${currentUser.uid}/posts/";
        await _storage.storeFile(path, postId, File(postImagePath));
        postImagePath = await _storage.getFileURL(path, postId);
      }

      final PostModel postModel = PostModel(
        postId: postId,
        postContent: postContent,
        postImage: postImagePath,
        postOwnerUid: currentUser.uid,
        postTime: Timestamp.fromDate(now),
        postLikeCount: 0,
        postCommentCount: 0,
        postLikeList: [],
      );

      await _usersCollection
          .doc(currentUser.uid)
          .collection("posts")
          .doc(postId)
          .set(postModel.toMap());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
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

  Stream<UserModel> _getUserModelStream(String uid) {
    final result = _usersCollection.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));

    return result;
  }

  Future<List<UserModel>> _getUserList(List<String> userIDs) async {
    List<UserModel> userList = [];

    for (final userID in userIDs) {
      final result = await _getUserModel(userID);
      userList.add(result);
    }

    return userList;
  }

  Future<List<String>> _getFollowIDs(String type, String uid) async {
    final querySnapshot =
        await _usersCollection.doc(uid).collection(type).get();

    final idMapList = querySnapshot.docs.map((doc) => doc.data()).toList();

    final List<String> idList = [];
    for (final element in idMapList) {
      idList.add(element["id"]);
    }

    return idList;
  }

  // save user model to database
  Future<void> _setUserModel(UserModel userModel) async {
    await _usersCollection.doc(userModel.uid).set(userModel.toMap());
  }

  Future<void> _addFollow(String uid, String add, String type) async {
    await _usersCollection.doc(uid).collection(type).doc(add).set({"id": add});
  }

  Future<void> _deleteFollow(String uid, String delete, String type) async {
    await _usersCollection.doc(uid).collection(type).doc(delete).delete();
  }

  Future<void> _saveLastAction(
      String uid, String now, ActionModel actionModel) async {
    await _usersCollection
        .doc(uid)
        .collection(FirebaseConstants.lastActionsRef)
        .doc(now)
        .set(actionModel.toMap());
  }

  Stream<List<ActionModel>> _getLastActionStream(String uid) {
    final result = _usersCollection
        .doc(uid)
        .collection(FirebaseConstants.lastActionsRef)
        .orderBy("date", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => ActionModel.fromMap(doc.data())).toList());

    return result;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socialRepositoryProvider = Provider((ref) => SocialRepository(
      firestore: ref.read(firestoreProvider),
    ));

class SocialRepository {
  final FirebaseFirestore _firestore;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  SocialRepository({required firestore}) : _firestore = firestore;

  Future<UserModel> getUserData(String uid) async {
    final userModel = await _usersCollection
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>))
        .first;

    return userModel;
  }
}

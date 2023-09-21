import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/social/repository/social_repository.dart';
import 'package:flutter_anime_app/models/action_model.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socialControllerProvider =
    StateNotifierProvider((ref) => SocialController(
          socialRepository: ref.read(socialRepositoryProvider),
        ));

class SocialController extends StateNotifier {
  final SocialRepository _socialRepository;

  SocialController({required socialRepository})
      : _socialRepository = socialRepository,
        super(false);

  Future<UserModel> getUserData(String uid) async {
    final result = await _socialRepository.getUserData(uid);

    return result;
  }

  Stream<UserModel> getUserDataStream(String uid) {
    final result = _socialRepository.getUserDataStream(uid);

    return result;
  }

  Future<void> setFollow(String uid) async {
    final control = await _socialRepository.setFollow(uid);

    if (mounted) {
      debugPrint(control);
    }
  }

  Future<List<UserModel>> getUserList(String uid, String type) async {
    final result = await _socialRepository.getUserList(uid, type);

    return result;
  }

  Future<void> saveLastAction(
      String uid, String type, String content, String animeID) async {
    await _socialRepository.saveLastAction(uid, type, content, animeID);
  }

  Stream<List<ActionModel>> getLastActionStream(String uid) {
    final result = _socialRepository.getLastActionStream(uid);

    return result;
  }
}

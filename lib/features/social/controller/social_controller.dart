import 'package:flutter_anime_app/features/social/repository/social_repository.dart';
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
}

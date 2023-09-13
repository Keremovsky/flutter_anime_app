import 'package:flutter/widgets.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/user_profile/repository/user_profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userProfileControllerProvider =
    StateNotifierProvider((ref) => UserProfileController(
          userProfileRepository: ref.read(userProfileRepositoryProvider),
        ));

class UserProfileController extends StateNotifier {
  final UserProfileRepository _userProfileRepository;

  UserProfileController({required userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(false);

  Future<void> updateUserProfile(
    BuildContext context,
    String? username,
    String? animeName,
    String? profileFilePath,
    String? bannerFilePath,
  ) async {
    final control = await _userProfileRepository.updateUserProfile(
      username,
      animeName,
      profileFilePath,
      bannerFilePath,
    );

    if (mounted) {
      if (control == true) {
        giveFeedback(
          context,
          "Profile successfully updated.",
          const Duration(seconds: 1),
        );
        context.pop();
      } else {
        giveFeedback(
          context,
          "Unknown error occured.",
          const Duration(seconds: 1),
        );
        context.pop();
      }
    }
  }
}

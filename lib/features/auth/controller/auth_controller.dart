import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_anime_app/features/home/screens/home_screen.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider((ref) => AuthController(
      authRepository: ref.read(authRepositoryProvider),
      ref: ref,
    ));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required authRepository, required ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    final control = await _authRepository.signInWithGoogle();

    control.fold(
      (left) {
        if (left == "cancel") {
          giveFeedback(context, "Google account is not selected.");
        } else if (left == "account-exists-with-different-credential") {
          giveFeedback(context, "Account exist with another provider.");
        } else if (left == "user-disabled") {
          giveFeedback(context, "Account is disabled.");
        } else if (left == "error") {
          giveFeedback(context, "Unknown error occurred.");
        } else {
          giveFeedback(context, "Unknown server-side error occurred.");
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);

        Navigator.of(context).pop();
        Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
      },
    );
  }

  void signInWithTwitter(BuildContext context) async {
    final control = await _authRepository.signInWithTwitter();

    control.fold(
      (left) {
        if (left == "cancel") {
          giveFeedback(context, "Twitter account is not selected.");
        } else if (left == "account-exists-with-different-credential") {
          giveFeedback(context, "Account exist with another provider.");
        } else if (left == "user-disabled") {
          giveFeedback(context, "Account is disabled.");
        } else if (left == "error") {
          giveFeedback(context, "Unknown error occurred.");
        } else {
          giveFeedback(context, "Unknown server-side error occurred.");
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);

        Navigator.of(context).pop();
        Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
      },
    );
  }

  void signInWithEmail(
      BuildContext context, String email, String password) async {
    final control = await _authRepository.signInWithEmail(email, password);

    control.fold(
      (left) {
        if (left == "wrong-password") {
          giveFeedback(context, "Password is not correct.");
        } else if (left == "invalid-email") {
          giveFeedback(context, "Email address is not valid.");
        } else if (left == "user-disabled") {
          giveFeedback(context, "Account is disabled.");
        } else if (left == "user-not-found") {
          giveFeedback(context, "There is no user with given email.");
        } else {
          giveFeedback(context, "Unknown error occurred.");
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);

        Navigator.of(context).pop();
        Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
      },
    );
  }

  void registerWithEmail(BuildContext context, String username, String email,
      String password) async {
    if (!passwordValidator(password)) {
      giveFeedback(context, "Password requirements are not met.");
      return;
    }

    final control =
        await _authRepository.registerWithEmail(username, email, password);

    if (mounted) {
      if (control == "success") {
        giveFeedback(context, "Registration is successful.");
      } else if (control == "email-already-in-use") {
        giveFeedback(
            context, "There already exist an account with given email.");
      } else if (control == "invalid-email") {
        giveFeedback(context, "Email address is not valid.");
      } else if (control == "weak-password") {
        giveFeedback(context, "Given password is weak.");
      } else {
        giveFeedback(context, "Unknown error occurred.");
      }
    }
  }

  void resetPassword(BuildContext context, String email) async {
    final control = await _authRepository.resetPassword(email);

    if (mounted) {
      if (control == "success") {
        giveFeedback(context, "An email sent to your mail address.");
      } else if (control == "invalid-email") {
        giveFeedback(context, "Email address is not valid.");
      } else if (control == "user-not-found") {
        giveFeedback(context, "There is no user with given email.");
      } else {
        giveFeedback(context, "Unknown error occurred.");
      }
    }
  }
}

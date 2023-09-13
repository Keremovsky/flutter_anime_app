import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> signInWithGoogle(BuildContext context) async {
    final control = await _authRepository.signInWithGoogle();

    control.fold(
      (left) {
        if (left == "cancel") {
          giveFeedback(
            context,
            "Google account is not selected.",
            const Duration(seconds: 2),
          );
        } else if (left == "account-exists-with-different-credential") {
          giveFeedback(
            context,
            "Account exist with another provider.",
            const Duration(seconds: 2),
          );
        } else if (left == "user-disabled") {
          giveFeedback(
            context,
            "Account is disabled.",
            const Duration(seconds: 2),
          );
        } else if (left == "error") {
          giveFeedback(
            context,
            "Unknown error occurred.",
            const Duration(seconds: 2),
          );
        } else {
          giveFeedback(
            context,
            "Unknown server-side error occurred.",
            const Duration(seconds: 2),
          );
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);

        context.pushReplacementNamed(RouteConstants.splashScreenName);
      },
    );
  }

  Future<void> signInWithTwitter(BuildContext context) async {
    final control = await _authRepository.signInWithTwitter();

    control.fold(
      (left) {
        if (left == "cancel") {
          giveFeedback(
            context,
            "Twitter account is not selected.",
            const Duration(seconds: 2),
          );
        } else if (left == "account-exists-with-different-credential") {
          giveFeedback(
            context,
            "Account exist with another provider.",
            const Duration(seconds: 2),
          );
        } else if (left == "user-disabled") {
          giveFeedback(
            context,
            "Account is disabled.",
            const Duration(seconds: 2),
          );
        } else if (left == "error") {
          giveFeedback(
            context,
            "Unknown error occurred.",
            const Duration(seconds: 2),
          );
        } else {
          giveFeedback(
            context,
            "Unknown server-side error occurred.",
            const Duration(seconds: 2),
          );
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);

        context.pushReplacementNamed(RouteConstants.splashScreenName);
      },
    );
  }

  Future<void> signInWithEmail(
      BuildContext context, String email, String password) async {
    final control = await _authRepository.signInWithEmail(email, password);

    control.fold(
      (left) {
        if (left == "wrong-password") {
          giveFeedback(
            context,
            "Password is not correct.",
            const Duration(seconds: 2),
          );
        } else if (left == "invalid-email") {
          giveFeedback(
            context,
            "Email address is not valid.",
            const Duration(seconds: 2),
          );
        } else if (left == "user-disabled") {
          giveFeedback(
            context,
            "Account is disabled.",
            const Duration(seconds: 2),
          );
        } else if (left == "user-not-found") {
          giveFeedback(
            context,
            "There is no user with given email.",
            const Duration(seconds: 2),
          );
        } else {
          giveFeedback(
            context,
            "Unknown error occurred.",
            const Duration(seconds: 2),
          );
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);

        context.pop();
        context.pushReplacementNamed(RouteConstants.splashScreenName);
      },
    );
  }

  Future<void> registerWithEmail(BuildContext context, String username,
      String email, String password) async {
    final control =
        await _authRepository.registerWithEmail(username, email, password);

    if (mounted) {
      if (control == "success") {
        giveFeedback(
          context,
          "Registration is successful.",
          const Duration(seconds: 2),
        );
      } else if (control == "email-already-in-use") {
        giveFeedback(
          context,
          "There already exist an account with given email.",
          const Duration(seconds: 2),
        );
      } else if (control == "invalid-email") {
        giveFeedback(
          context,
          "Email address is not valid.",
          const Duration(seconds: 2),
        );
      } else if (control == "weak-password") {
        giveFeedback(
          context,
          "Given password is weak.",
          const Duration(seconds: 2),
        );
      } else {
        giveFeedback(
          context,
          "Unknown error occurred.",
          const Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    final control = await _authRepository.resetPassword(email);

    if (mounted) {
      if (control == "success") {
        giveFeedback(
          context,
          "An email sent to your mail address.",
          const Duration(seconds: 2),
        );
      } else if (control == "invalid-email") {
        giveFeedback(
          context,
          "Email address is not valid.",
          const Duration(seconds: 2),
        );
      } else if (control == "user-not-found") {
        giveFeedback(
          context,
          "There is no user with given email.",
          const Duration(seconds: 2),
        );
      } else {
        giveFeedback(
          context,
          "Unknown error occurred.",
          const Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    final control = await _authRepository.signOut();

    if (mounted) {
      if (control == "success") {
        context.pushReplacementNamed(RouteConstants.authScreenName);
      } else {
        giveFeedback(
          context,
          "Unknown error occurred.",
          const Duration(seconds: 2),
        );
      }
    }
  }
}

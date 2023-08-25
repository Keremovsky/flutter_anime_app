import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_anime_app/features/auth/repository/auth_repository.dart';
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
        if (left == "no_selection") {
          _giveFeedback(context, "Google account is not selected.");
        } else if (left == "firebase_error") {
          _giveFeedback(context, "Server-side error occurred.");
        } else {
          _giveFeedback(context, "Unknown error occurred.");
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);
      },
    );
  }

  void signInWithTwitter(BuildContext context) async {
    final control = await _authRepository.signInWithTwitter();

    control.fold(
      (left) {
        if (left == "cancel") {
          _giveFeedback(context, "Twitter account is not selected.");
        } else if (left == "firebase_error") {
          _giveFeedback(context, "Server-side error occurred.");
        } else {
          _giveFeedback(context, "Unknown error occurred.");
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);
      },
    );
  }

  void signInWithEmail(
      BuildContext context, String email, String password) async {
    final control = await _authRepository.signInWithEmail(email, password);

    control.fold(
      (left) {
        if (left == "firebase_error") {
          _giveFeedback(context, "Server-side error occurred.");
        } else {
          _giveFeedback(context, "Unknown error occurred.");
        }
      },
      (right) {
        _ref.read(userProvider.notifier).update((state) => right);
      },
    );
  }

  void registerWithEmail(BuildContext context, String username, String email,
      String password) async {
    final control =
        await _authRepository.registerWithEmail(username, email, password);

    if (mounted) {
      if (control == "success") {
        _giveFeedback(context, "Registration is successful.");
      } else if (control == "firebase_error") {
        _giveFeedback(context, "Server-side error occurred.");
      } else {
        _giveFeedback(context, "Unknown error occurred.");
      }
    }
  }

  void resetPassword(BuildContext context, String email) async {
    final control = await _authRepository.resetPassword(email);

    if (mounted) {
      if (control == "success") {
        _giveFeedback(context, "An email sent to your mail address.");
      } else if (control == "firebase_error") {
        _giveFeedback(context, "Server-side error occurred.");
      } else {
        _giveFeedback(context, "Unknown error occurred.");
      }
    }
  }

  void _giveFeedback(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

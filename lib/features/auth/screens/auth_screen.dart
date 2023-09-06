import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/auth/widgets/create_bottom_sheet.dart';
import 'package:flutter_anime_app/features/auth/widgets/login_bottom_sheet.dart';
import 'package:flutter_anime_app/features/auth/widgets/social_auth_button.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  static const List<Color> _googleColors = [
    Color.fromRGBO(219, 68, 55, 1),
    Color.fromRGBO(244, 180, 0, 1),
    Color.fromRGBO(15, 157, 88, 1),
    Color.fromRGBO(66, 133, 244, 1),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(Constants.backgroundImage),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Palette.background.withOpacity(1),
                BlendMode.modulate,
              ),
            ),
          ),
          child: Column(
            children: [
              const Spacer(flex: 6),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(Constants.logoImage),
              ),
              const Spacer(flex: 8),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const CreateBottomSheet();
                    },
                  );
                },
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll<Size>(Size(320, 45)),
                ),
                child: Text(
                  "Create New Account",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const Spacer(flex: 3),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const LoginBottomSheet();
                    },
                  );
                },
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll<Size>(Size(320, 45)),
                ),
                child: Text(
                  "Login with Account",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const Spacer(flex: 2),
              Text(
                "or Login with",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Palette.grey,
                    ),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialAuthButton(
                    logoImage: Constants.facebookLogo,
                    background: Palette.facebookBackground,
                    authProcess: () async {
                      await Future.delayed(const Duration(seconds: 5));
                    },
                    loadingIndicator: const CustomCircularProgressIndicator(
                      size: 15,
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SocialAuthButton(
                    logoImage: Constants.twitterLogo,
                    background: Palette.twitterBackground,
                    authProcess: () async {
                      await ref
                          .read(authControllerProvider.notifier)
                          .signInWithTwitter(context);
                    },
                    loadingIndicator: const CustomCircularProgressIndicator(
                      size: 15,
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SocialAuthButton(
                    logoImage: Constants.googleLogo,
                    background: Palette.googleBackground,
                    authProcess: () async {
                      await ref
                          .read(authControllerProvider.notifier)
                          .signInWithGoogle(context);
                    },
                    loadingIndicator: const CustomCircularProgressIndicator(
                      size: 15,
                      strokeWidth: 3,
                      animationColors: _googleColors,
                      animationTime: Duration(seconds: 2),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
}

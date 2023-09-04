import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/auth/widgets/create_bottom_sheet.dart';
import 'package:flutter_anime_app/features/auth/widgets/login_bottom_sheet.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

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
                child: Hero(
                  tag: "authLogo",
                  child: Image.asset(Constants.logoImage),
                ),
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
                  InkWell(
                    onTap: () {
                      debugPrint("facebook");
                    },
                    child: SizedBox(
                      height: 30,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          Constants.facebookLogo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signInWithTwitter(context);
                    },
                    child: SizedBox(
                      height: 30,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          Constants.twitterLogo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signInWithGoogle(context);
                    },
                    child: SizedBox(
                      height: 30,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          Constants.googleLogo,
                          fit: BoxFit.cover,
                        ),
                      ),
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

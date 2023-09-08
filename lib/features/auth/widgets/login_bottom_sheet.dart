import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/auth/widgets/auth_button.dart';
import 'package:flutter_anime_app/features/auth/widgets/create_bottom_sheet.dart';
import 'package:flutter_anime_app/features/auth/widgets/reset_password_bottom_sheet.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginBottomSheet extends ConsumerStatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  ConsumerState<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends ConsumerState<LoginBottomSheet> {
  late String email;
  late String password;

  bool hidePassword = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: height * 0.55,
        width: double.infinity,
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: "Welcome to "),
                  TextSpan(
                    text: "AnimeApp",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Palette.mainColor),
                  ),
                ],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please fill the field";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Palette.grey),
                        hintText: "Email",
                      ),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please fill the field";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Palette.grey),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            hidePassword = !hidePassword;
                            setState(() {});
                          },
                          icon: hidePassword
                              ? const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Palette.mainColor,
                                )
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: Palette.mainColor,
                                ),
                        ),
                      ),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return const ResetPasswordBottomSheet();
                              },
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Palette.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            AuthButton(
              authProcess: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  await ref
                      .read(authControllerProvider.notifier)
                      .signInWithEmail(
                        context,
                        email,
                        password,
                      );
                }
              },
              height: 45,
              width: 320,
              shrinkOnLoading: true,
              shrinkWidth: 45,
              shrinkAnimationDuration: const Duration(milliseconds: 250),
              loadingIndicator: const CustomCircularProgressIndicator(size: 20),
              background: Palette.mainColor,
              child: Text(
                "LOGIN",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: "Don’t have account? "),
                  TextSpan(
                    text: "Create right now!",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Palette.mainColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Navigator.pop(context);

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const CreateBottomSheet();
                          },
                        );
                      },
                  ),
                ],
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

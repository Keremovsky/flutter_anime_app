import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/auth/widgets/login_bottom_sheet.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateBottomSheet extends ConsumerStatefulWidget {
  const CreateBottomSheet({super.key});

  @override
  ConsumerState<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends ConsumerState<CreateBottomSheet> {
  late String username;
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
                  const TextSpan(text: "Register & Watch "),
                  TextSpan(
                    text: "Anime",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please fill the field";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Palette.grey),
                        hintText: "Username",
                      ),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 15),
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
                        Tooltip(
                          showDuration: const Duration(seconds: 5),
                          triggerMode: TooltipTriggerMode.tap,
                          decoration: BoxDecoration(
                            color: Palette.background.withOpacity(0.95),
                          ),
                          richMessage: WidgetSpan(
                            child: SizedBox(
                              width: 220,
                              child: Text(
                                "-Between 8 and 12 characters\n\n-At least one number (0-9)\n\n-At least one uppercase letter(A-Z)\n\n-At least one lowercase letter (a-z)",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                          child: Text(
                            "Password requirements.",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Palette.grey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  ref.read(authControllerProvider.notifier).registerWithEmail(
                        context,
                        username,
                        email,
                        password,
                      );
                }
              },
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll<Size>(Size(320, 45)),
              ),
              child: Text(
                "REGISTER",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: "Already have account? "),
                  TextSpan(
                    text: "Login right now!",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Palette.mainColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const LoginBottomSheet();
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/auth/widgets/create_bottom_sheet.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordBottomSheet extends ConsumerStatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  ConsumerState<ResetPasswordBottomSheet> createState() =>
      _LoginBottomSheetState();
}

class _LoginBottomSheetState extends ConsumerState<ResetPasswordBottomSheet> {
  late String email;
  late String password;

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
                  const TextSpan(text: "Reset Your "),
                  TextSpan(
                    text: "Password",
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    ref
                        .read(authControllerProvider.notifier)
                        .resetPassword(context, email);
                  }
                },
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll<Size>(Size(320, 45)),
                ),
                child: Text(
                  "RESET PASSWORD",
                  style: Theme.of(context).textTheme.displayLarge,
                )),
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

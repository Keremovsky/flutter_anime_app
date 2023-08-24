import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/auth/widgets/login_bottom_sheet.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

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
                  const TextSpan(text: "Register and Watch "),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Palette.grey),
                        hintText: "Username",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Palette.grey),
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Palette.grey),
                        hintText: "Password",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll<Size>(Size(320, 45)),
                ),
                child: Text(
                  "REGISTER",
                  style: Theme.of(context).textTheme.displayLarge,
                )),
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

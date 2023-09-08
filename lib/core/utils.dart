import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

bool passwordValidator(String password) {
  RegExp regex =
      RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,12}$');

  return !regex.hasMatch(password);
}

void giveFeedback(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget circularLoading({
  required double size,
  Animation<Color>? valueColor,
  Color color = Palette.white,
  double strokeWidth = 4,
}) {
  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: valueColor == null ? color : null,
        valueColor: valueColor,
        strokeWidth: strokeWidth,
        strokeCap: StrokeCap.round,
      ),
    ),
  );
}

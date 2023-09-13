import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool passwordValidator(String password) {
  RegExp regex =
      RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,12}$');

  return !regex.hasMatch(password);
}

void giveFeedback(BuildContext context, String text, Duration duration) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: duration,
    ),
  );
}

String getDateDMY() {
  final now = DateTime.now();
  final date = DateFormat("d MMMM yyyy").format(now);

  return date;
}

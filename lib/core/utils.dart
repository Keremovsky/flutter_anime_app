import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

String getDateDMY() {
  final now = DateTime.now();
  final date = DateFormat("d MMMM yyyy").format(now);

  return date;
}

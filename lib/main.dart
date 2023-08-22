import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/auth/screens/auth_screen.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.mainColor,

          // background
          background: Palette.background,
        ),

        // text
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Palette.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Palette.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: TextStyle(
            color: Palette.white,
            fontSize: 18,
          ),
          displayMedium: TextStyle(
            color: Palette.white,
            fontSize: 14,
          ),
          displaySmall: TextStyle(
            color: Palette.grey,
            fontSize: 12,
          ),
        ),

        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

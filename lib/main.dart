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
      debugShowCheckedModeBanner: false,
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
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            color: Palette.white,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
          displayLarge: TextStyle(
            color: Palette.white,
            fontSize: 20,
          ),
          displayMedium: TextStyle(
            color: Palette.white,
            fontSize: 16,
          ),
          displaySmall: TextStyle(
            color: Palette.grey,
            fontSize: 14,
          ),
        ),

        // elevated button
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Palette.mainColor),
          ),
        ),

        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Palette.background,
          dragHandleColor: Palette.mainColor,
          showDragHandle: true,
          dragHandleSize: Size(50, 5),
        ),

        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

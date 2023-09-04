import 'package:flutter/material.dart';
import 'package:flutter_anime_app/router.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            color: Palette.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
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
            color: Palette.white,
            fontSize: 10,
          ),
        ),

        // elevated button
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Palette.mainColor),
          ),
        ),

        // icon
        iconTheme: const IconThemeData(
          color: Palette.white,
        ),

        // bottom sheet
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Palette.background,
          dragHandleColor: Palette.mainColor,
          showDragHandle: true,
          dragHandleSize: Size(50, 5),
          modalElevation: 0,
        ),

        // snackbar
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Palette.background,
        ),

        // app bar
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.background,
          scrolledUnderElevation: 0,
        ),

        // drawer
        drawerTheme: const DrawerThemeData(
          backgroundColor: Palette.background,
          elevation: 0,
        ),

        // floating action
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.mainColor,
        ),

        // bottom app bar
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Palette.background,
          elevation: 0,
        ),

        useMaterial3: true,
      ),
      routerConfig: AppRouter().router,
    );
  }
}

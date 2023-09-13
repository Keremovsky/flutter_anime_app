import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/features/anime/screens/anime_screen.dart';
import 'package:flutter_anime_app/features/anime/screens/anime_list_screen.dart';
import 'package:flutter_anime_app/features/auth/screens/auth_screen.dart';
import 'package:flutter_anime_app/features/home/screens/main_screen.dart';
import 'package:flutter_anime_app/features/auth/screens/splash_screen.dart';
import 'package:flutter_anime_app/features/user_profile/screens/edit_user_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouteConstants.authScreenName,
        path: RouteConstants.authScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AuthScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.splashScreenName,
        path: RouteConstants.splashScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.mainScreenName,
        path: RouteConstants.mainScreenPath,
        pageBuilder: (context, state) {
          final arg = state.extra as List<dynamic>;

          return MaterialPage(
            child: MainScreen(
              popular: arg[0],
              seasonal: arg[1],
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.animeScreenName,
        path: "${RouteConstants.animeScreenPath}/:id",
        pageBuilder: (context, state) {
          final name = state.extra as String;

          return MaterialPage(
            child: AnimeScreen(
              id: state.pathParameters["id"]!,
              name: name,
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.animeListsScreenName,
        path: RouteConstants.animeListsScreenPath,
        pageBuilder: (context, state) {
          final args = state.extra as List<dynamic>;

          return MaterialPage(
            child: AnimeListScreen(
              animeList: args[0],
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.editUserScreenName,
        path: RouteConstants.editUserScreenPath,
        pageBuilder: (context, state) {
          final args = state.extra as List<String>;

          return MaterialPage(
            child: EditUserScreen(
              username: args[0],
              animeName: args[1],
              profilePicURL: args[2],
              backgroundPicURL: args[3],
            ),
          );
        },
      )
    ],
  );
}

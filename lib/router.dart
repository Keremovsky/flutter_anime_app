import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/features/anime/screens/anime_screen.dart';
import 'package:flutter_anime_app/features/anime/screens/anime_list_screen.dart';
import 'package:flutter_anime_app/features/auth/screens/auth_screen.dart';
import 'package:flutter_anime_app/features/home/screens/main_screen.dart';
import 'package:flutter_anime_app/features/auth/screens/splash_screen.dart';
import 'package:flutter_anime_app/features/social/screens/user_screen.dart';
import 'package:flutter_anime_app/features/user_profile/screens/edit_user_screen.dart';
import 'package:flutter_anime_app/features/user_profile/screens/user_list_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouterConstants.authScreenName,
        path: RouterConstants.authScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AuthScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.splashScreenName,
        path: RouterConstants.splashScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.mainScreenName,
        path: RouterConstants.mainScreenPath,
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
        name: RouterConstants.animeScreenName,
        path: "${RouterConstants.animeScreenPath}/:id",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: AnimeScreen(
              id: state.pathParameters["id"]!,
            ),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.animeListsScreenName,
        path: RouterConstants.animeListsScreenPath,
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
        name: RouterConstants.editUserScreenName,
        path: RouterConstants.editUserScreenPath,
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
      ),
      GoRoute(
        name: RouterConstants.userScreenName,
        path: RouterConstants.userScreenPath,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: UserScreen(uid: state.extra as String),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.userListScreenName,
        path: RouterConstants.userListScreenPath,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: UserListScreen(type: state.extra as String),
          );
        },
      )
    ],
  );
}

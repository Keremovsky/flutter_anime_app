import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/home/screens/main_screen.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = "splashScreen";

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late Future<List<PreAnime>> popular;
  late Future<List<PreAnime>> seasonal;

  Future<List<PreAnime>> _getAnimeList(String collectionRef) async {
    await Future.delayed(Duration(seconds: 2));

    final result = await ref
        .read(animeControllerProvider.notifier)
        .getAnimeListWithColl(collectionRef);

    return result;
  }

  @override
  void initState() {
    super.initState();
    popular = _getAnimeList(FirebaseConstants.popularAnimesRef);
    seasonal = _getAnimeList(FirebaseConstants.seasonalAnimesRef);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([popular, seasonal]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Hero(
                      tag: "authLogo",
                      child: Image.asset(Constants.logoImage),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: circularLoading(
                    size: 160,
                    color: Palette.mainColor,
                  ),
                )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Future.microtask(
              () => Navigator.of(context).popAndPushNamed(
                MainScreen.routeName,
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}

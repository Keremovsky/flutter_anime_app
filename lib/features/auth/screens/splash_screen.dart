import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/favorites_state_notifier.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/watching_state_notifier.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = "splashScreen";

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  late Future<List<PreAnime>> popular;
  late Future<List<PreAnime>> seasonal;

  Future<List<PreAnime>> _getAnimeList(String collectionRef) async {
    await Future.delayed(const Duration(seconds: 2));

    final result = await ref
        .read(animeControllerProvider.notifier)
        .getPreAnimeListWithColl(collectionRef);

    return result;
  }

  Future<void> _fetchListData() async {
    await ref.read(favoriteStateNotifierProvider.notifier).updateState();
    await ref.read(watchingStateNotifierProvider.notifier).updateState();
    await ref.read(animeListsStateNotifierProvider.notifier).updateState();
  }

  @override
  void initState() {
    super.initState();

    popular = _getAnimeList(FirebaseConstants.popularAnimesRef);
    seasonal = _getAnimeList(FirebaseConstants.seasonalAnimesRef);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([popular, seasonal, _fetchListData()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ScaleTransition(
                      scale: scaleAnimation,
                      child: Image.asset(Constants.logoImage),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: const CustomCircularProgressIndicator(
                      size: 140,
                      color: Palette.mainColor,
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (mounted) {
              Future.microtask(
                () => context.pushReplacementNamed(
                  RouterConstants.mainScreenName,
                  extra: [
                    snapshot.data![0],
                    snapshot.data![1],
                  ],
                ),
              );
            }
          }

          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_episode_box.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_main/anime_main.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_tab_bar.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_review_box.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/models/anime_review.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeScreen extends ConsumerStatefulWidget {
  final String id;
  final String name;

  const AnimeScreen({super.key, required this.id, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends ConsumerState<AnimeScreen>
    with TickerProviderStateMixin {
  ValueNotifier<bool> isFirstFetch = ValueNotifier<bool>(true);
  ValueNotifier<String> animeID = ValueNotifier<String>("");
  ValueNotifier<List<AnimeReview>> animeReviews =
      ValueNotifier<List<AnimeReview>>([]);

  final List<String> tabs = ["Episodes", "Reviews"];
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  late Future<Anime> anime;

  Future<Anime> getAnime(String id) async {
    final result =
        await ref.read(animeControllerProvider.notifier).getAnime(id);

    return result;
  }

  void getAnimeReviews(String id) async {
    final result = await ref
        .read(animeControllerProvider.notifier)
        .getAnimeReviewsFromAnime(
          id,
          isFirstFetch.value,
        );

    if (isFirstFetch.value) {
      animeReviews.value = result;
      isFirstFetch.value = false;
    } else {
      animeReviews.value = animeReviews.value + result;
    }
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        tabController.index == 1) {
      getAnimeReviews(animeID.value);
    }
  }

  @override
  void initState() {
    anime = getAnime(widget.id);

    scrollController.addListener(scrollListener);
    tabController = TabController(length: tabs.length, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
    animeReviews.dispose();
    isFirstFetch.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: anime,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomCircularProgressIndicator(size: 50);
          }

          final animeData = snapshot.data!;

          animeID.value = animeData.id;
          getAnimeReviews(animeID.value);

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: NestedScrollView(
                controller: scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    const SliverAppBar(
                      floating: true,
                      leading: AppBarBackButton(),
                      backgroundColor: Palette.background,
                    ),
                    AnimeMain(anime: animeData),
                  ];
                },
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AnimeTabBar(tabController: tabController),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            key: PageStorageKey(tabs[0]),
                            itemCount: animeData.episodes,
                            itemBuilder: (context, index) {
                              return AnimeEpisodeButton(
                                height: 50,
                                width: 200,
                                backgroundColor: Palette.boxColor,
                                onTap: () {},
                                episode: animeData.episodes - index,
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: animeReviews,
                            builder: (context, value, child) {
                              return ListView.builder(
                                key: PageStorageKey(tabs[1]),
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return AnimeReviewBox(
                                    animeReview: value[index],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

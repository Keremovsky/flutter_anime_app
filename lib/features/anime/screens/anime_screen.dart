import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/core/utils/icon_label_button.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_episode_box.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_handle_row.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_main_info.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_review_button.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/expandable_anime_details.dart';
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
  late Future<Anime> anime;

  late ValueNotifier<List<AnimeReview>> animeReviews;
  ValueNotifier<bool> isFirstFetch = ValueNotifier<bool>(true);

  final List<String> tabs = ["Episodes", "Reviews"];
  late TabController tabController;

  Future<Anime> getAnime(String id) async {
    final result =
        await ref.read(animeControllerProvider.notifier).getAnime(id);

    return result;
  }

  void getAnimeReviews(String id) async {
    if (isFirstFetch.value == true) {
      final result = await ref
          .read(animeControllerProvider.notifier)
          .getAnimeReviewsFromAnime(
            id,
            true,
          );

      animeReviews.value = result;

      isFirstFetch.value = false;
    }
  }

  @override
  void initState() {
    anime = getAnime(widget.id);

    animeReviews = ValueNotifier<List<AnimeReview>>([]);
    tabController = TabController(length: tabs.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: anime,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomCircularProgressIndicator(size: 50);
          }

          final animeData = snapshot.data!;

          getAnimeReviews(animeData.id);

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: animeData.imageURL,
                                child: Container(
                                  height: 180,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(animeData.imageURL),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              AnimeMainInfo(
                                width: width,
                                animeData: animeData,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          AnimeHandleRow(
                            id: animeData.id,
                            name: animeData.name,
                            imageURL: animeData.imageURL,
                          ),
                          const SizedBox(height: 20),
                          ExpandableAnimeDetails(
                            anime: animeData,
                            normalHeight: 140,
                            expandedHeight: 300,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    SliverAppBar(
                      pinned: true,
                      leading: null,
                      automaticallyImplyLeading: false,
                      backgroundColor: Palette.background,
                      forceElevated: innerBoxIsScrolled,
                      toolbarHeight: 70,
                      flexibleSpace: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconLabelButton(
                            onTap: () {
                              tabController.animateTo(0);
                            },
                            height: 60,
                            width: 100,
                            icon: const Icon(Icons.video_collection_outlined),
                            label: const Text(
                              "Episodes",
                              style: TextStyle(color: Palette.white),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            backgroundColor: Palette.boxColor,
                          ),
                          IconLabelButton(
                            onTap: () {
                              tabController.animateTo(1);
                            },
                            height: 60,
                            width: 100,
                            icon: const Icon(Icons.reviews),
                            label: const Text(
                              "Reviews",
                              style: TextStyle(color: Palette.white),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            backgroundColor: Palette.boxColor,
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
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
                          episode: index + 1,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: animeReviews,
                      builder: (context, value, child) {
                        return ListView.builder(
                          key: PageStorageKey(tabs[1]),
                          itemCount: value.length + 1,
                          itemBuilder: (context, index) {
                            if (index == value.length) {
                              return const SizedBox(height: 20);
                            }
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
            ),
          );
        },
      ),
    );
  }
}

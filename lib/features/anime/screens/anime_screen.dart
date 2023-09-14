import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_handle_row.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_main_info.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_review_list.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/expandable_anime_details.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeScreen extends ConsumerStatefulWidget {
  final String id;
  final String name;

  const AnimeScreen({super.key, required this.id, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends ConsumerState<AnimeScreen> {
  bool expanded = false;

  late Future<Anime> anime;

  Future<Anime> getAnime(String id) async {
    final result =
        await ref.read(animeControllerProvider.notifier).getAnime(id);

    return result;
  }

  @override
  void initState() {
    anime = getAnime(widget.id);
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

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
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
                  const AnimeReviewList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

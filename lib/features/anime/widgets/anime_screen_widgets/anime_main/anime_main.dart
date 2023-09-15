import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_main/anime_handle_row.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_main/anime_main_info.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime_main/expandable_anime_details.dart';
import 'package:flutter_anime_app/models/anime.dart';

class AnimeMain extends StatelessWidget {
  final Anime anime;

  const AnimeMain({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: anime.imageURL,
                child: Container(
                  height: 180,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(anime.imageURL),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              AnimeMainInfo(
                width: width,
                animeData: anime,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AnimeHandleRow(
            id: anime.id,
            name: anime.name,
            imageURL: anime.imageURL,
          ),
          const SizedBox(height: 20),
          ExpandableAnimeDetails(
            anime: anime,
            normalHeight: 140,
            expandedHeight: 300,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

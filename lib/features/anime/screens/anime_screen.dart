import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeScreen extends ConsumerWidget {
  final Anime anime;

  const AnimeScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          anime.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Palette.mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Palette.mainColor,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 240,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(anime.imageURL),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 240,
                    width: width - 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Type: ${anime.type}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Year: ${anime.year}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Episodes: ${anime.episodes}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Status: ${anime.status}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Broadcast Day: ${anime.broadcastDay}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Genres: ${anime.genres.join(", ")}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Score: ${anime.score}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Favorites: ${anime.favorites}",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Name: ${anime.name}",
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Japanese Name: ${anime.japName}",
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(animeControllerProvider.notifier)
                      .likeAnime(context, anime.id);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Palette.mainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

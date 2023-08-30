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
              Container(
                height: 240,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(anime.imageURL),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(animeControllerProvider.notifier)
                          .setAnimeToList(anime.id, "Favorites");
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Palette.mainColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Name: ${anime.name}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Japanese Name: ${anime.japName}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Type: ${anime.type}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Genres: ${anime.genres}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Score: ${anime.score}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Score: ${anime.favorites}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Episodes: ${anime.episodes}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Status: ${anime.status}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Year: ${anime.year}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Broadcast Day: ${anime.broadcastDay}",
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

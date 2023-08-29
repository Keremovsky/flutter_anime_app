import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/screens/anime_screen.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeBox extends ConsumerWidget {
  final Anime anime;

  const AnimeBox({super.key, required this.anime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AnimeScreen(anime: anime),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 180,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(anime.imageURL),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  anime.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  "${anime.genres[0]}, ${anime.genres[1]}",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Palette.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

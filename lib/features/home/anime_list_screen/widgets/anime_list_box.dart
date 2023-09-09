import 'package:flutter/material.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeListBox extends StatelessWidget {
  final String listName;
  final List<PreAnime> preAnimes;

  const AnimeListBox({
    super.key,
    required this.listName,
    required this.preAnimes,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        for (final preAnime in preAnimes) {
          debugPrint(preAnime.toString());
        }
      },
      child: Container(
        color: Palette.mainColor,
        child: Row(
          children: [
            Text(
              listName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              preAnimes[0].name,
              style: Theme.of(context).textTheme.displaySmall,
            )
          ],
        ),
      ),
    );
  }
}

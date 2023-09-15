import 'package:flutter/material.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeMainInfo extends StatelessWidget {
  final double width;
  final Anime animeData;

  const AnimeMainInfo({
    super.key,
    required this.width,
    required this.animeData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: width - 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              animeData.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Studio Name",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Palette.grey),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.watch_later_outlined,
                color: Palette.grey,
                size: 18,
              ),
              const SizedBox(width: 3),
              Text(
                animeData.status,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Palette.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

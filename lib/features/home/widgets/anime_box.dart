import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeBox extends StatelessWidget {
  const AnimeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 180,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    "https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/98034e78c5ab24fab83db14c22ebf91f.jpe"),
              ),
            ),
          ),
          Text(
            "Jobless Reincarnation",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            "Isekai, Fantasy",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Palette.grey),
          ),
        ],
      ),
    );
  }
}

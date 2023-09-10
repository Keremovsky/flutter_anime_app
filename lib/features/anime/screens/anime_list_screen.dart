import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_tile.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeListScreen extends StatelessWidget {
  final String title;
  final List<PreAnime> preAnimes;

  const AnimeListScreen({
    super.key,
    required this.title,
    required this.preAnimes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Palette.mainColor),
        ),
        centerTitle: true,
        leading: const AppBarBackButton(),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: preAnimes.length,
                  itemBuilder: (context, index) {
                    return AnimeTile(anime: preAnimes[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

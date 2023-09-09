import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/home_screen/widgets/anime_box.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeListView extends ConsumerStatefulWidget {
  final String title;
  final List<PreAnime> preAnime;

  const AnimeListView({super.key, required this.title, required this.preAnime});

  @override
  ConsumerState<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends ConsumerState<AnimeListView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 195,
            width: width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.preAnime.length,
              itemBuilder: (context, index) {
                return AnimeBox(
                  anime: widget.preAnime[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

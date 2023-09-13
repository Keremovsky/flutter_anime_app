import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_tile.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeListView extends ConsumerStatefulWidget {
  final AnimeList animeList;

  const AnimeListView({super.key, required this.animeList});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends ConsumerState<AnimeListView> {
  late Future<List<PreAnime>> preAnimes;

  Future<List<PreAnime>> _getPreAnimes(List<String> ids) async {
    final result = await ref
        .read(animeControllerProvider.notifier)
        .getPreAnimeListWithID(ids);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    preAnimes = _getPreAnimes(widget.animeList.animesIDs);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder(
        future: preAnimes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final data = snapshot.data!;

          return Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return AnimeTile(anime: data[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_tile.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAnimeList extends ConsumerStatefulWidget {
  final String searchText;

  const SearchAnimeList({super.key, required this.searchText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchAnimeListState();
}

class SearchAnimeListState extends ConsumerState<SearchAnimeList> {
  late Future<List<PreAnime>> preAnimes;

  Future<List<PreAnime>> searchAnime(String searchText) async {
    final result =
        ref.read(animeControllerProvider.notifier).searchAnime(searchText);

    return result;
  }

  @override
  void initState() {
    preAnimes = searchAnime(widget.searchText);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchAnimeList oldWidget) {
    preAnimes = searchAnime(widget.searchText);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchText == ""
        ? const SizedBox()
        : FutureBuilder(
            future: preAnimes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressIndicator(
                  size: 50,
                  color: Palette.mainColor,
                );
              }

              if (snapshot.data == null) {
                return const SizedBox();
              }
              final data = snapshot.data!;

              if (data.isEmpty) {
                return Text(
                  "Error!",
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return AnimeTile(anime: data[index]);
                },
              );
            },
          );
  }
}

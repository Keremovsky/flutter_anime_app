import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_tile.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPageView extends ConsumerStatefulWidget {
  const FavoritesPageView({super.key});

  @override
  ConsumerState<FavoritesPageView> createState() => _FavoritesPageViewState();
}

class _FavoritesPageViewState extends ConsumerState<FavoritesPageView>
    with AutomaticKeepAliveClientMixin<FavoritesPageView> {
  late Stream<AnimeList> animeList;
  late Future<List<PreAnime>> preAnimes;

  Stream<AnimeList> _getAnimeListStream(String listName) {
    final result =
        ref.read(animeControllerProvider.notifier).getAnimeListStream(listName);

    return result;
  }

  Future<List<PreAnime>> _getPreAnime(List<String> ids) async {
    final result = await ref
        .read(animeControllerProvider.notifier)
        .getPreAnimeListWithID(ids);

    return result;
  }

  // to save state
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    animeList = _getAnimeListStream(Constants.favoriteListName);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: animeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCircularProgressIndicator(
            size: 50,
            color: Palette.mainColor,
          );
        }

        final animeListData = snapshot.data!;

        if (animeListData.name == "error") {
          return Text(
            "Error",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Palette.mainColor),
          );
        }

        if (animeListData.animesIDs.isEmpty) {
          return ListView(
            children: [
              const Icon(
                Icons.sentiment_neutral_outlined,
                size: 120,
                color: Palette.mainColor,
              ),
              Center(
                child: Text(
                  "No Anime",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Palette.mainColor),
                ),
              ),
            ],
          );
        }

        preAnimes = _getPreAnime(animeListData.animesIDs);

        return FutureBuilder(
          future: preAnimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            final data = snapshot.data!;

            return Expanded(
              child: ListView.builder(
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    return const SizedBox(height: 10);
                  }
                  return AnimeTile(anime: data[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}

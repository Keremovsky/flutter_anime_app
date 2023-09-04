import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/favorite_list_tile.dart';
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
  late Future<List<PreAnime>> favoriteAnimes;

  Future<List<PreAnime>> _getPreAnimeList(String listName) async {
    final ids = await ref
        .read(animeControllerProvider.notifier)
        .getAnimeIDList(listName);

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
    favoriteAnimes = _getPreAnimeList("Favorites");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: favoriteAnimes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return circularLoading(size: 50, color: Palette.mainColor);
        }

        final animes = snapshot.data!;

        if (animes.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                favoriteAnimes = _getPreAnimeList("Favorites");
              });
            },
            displacement: 10,
            color: Palette.mainColor,
            child: ListView(
              children: [
                Icon(
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
            ),
          );
        }

        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                favoriteAnimes = _getPreAnimeList("Favorites");
              });
            },
            displacement: 10,
            color: Palette.mainColor,
            child: ListView.builder(
              itemCount: animes.length + 1,
              itemBuilder: (context, index) {
                if (index == animes.length) {
                  return SizedBox(height: 10);
                }
                return FavoriteAnimeListTile(anime: animes[index]);
              },
            ),
          ),
        );
      },
    );
  }
}

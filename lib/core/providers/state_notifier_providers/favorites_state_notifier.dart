import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteStateNotifierProvider =
    StateNotifierProvider<FavoriteStateNotifier, AnimeList>(
        (ref) => FavoriteStateNotifier(
              ref: ref,
            ));

class FavoriteStateNotifier extends StateNotifier<AnimeList> {
  final Ref _ref;

  FavoriteStateNotifier({required ref})
      : _ref = ref,
        super(
          AnimeList(
              name: "",
              animesIDs: [],
              animeNames: [],
              animeImageURLs: [],
              createdDate: ""),
        );

  Future<void> updateState() async {
    final newState = await _ref
        .read(animeControllerProvider.notifier)
        .getAnimeList(Constants.favoriteListName);

    state = newState;
  }
}

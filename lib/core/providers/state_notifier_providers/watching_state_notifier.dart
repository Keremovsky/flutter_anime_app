import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchingStateNotifierProvider =
    StateNotifierProvider<WatchingStateNotifier, AnimeList>(
        (ref) => WatchingStateNotifier(
              ref: ref,
            ));

class WatchingStateNotifier extends StateNotifier<AnimeList> {
  final Ref _ref;

  WatchingStateNotifier({required ref})
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
    final userModel = _ref.read(userProvider)!;

    final newState = await _ref
        .read(animeControllerProvider.notifier)
        .getAnimeList(Constants.watchingListName, userModel.uid);

    state = newState;
  }

  bool controlAnime(String id) {
    return state.animesIDs.contains(id);
  }
}

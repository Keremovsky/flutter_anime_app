import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeListsStateNotifierProvider =
    StateNotifierProvider<AnimeListsStateNotifier, List<AnimeList>>(
        (ref) => AnimeListsStateNotifier(
              ref: ref,
            ));

class AnimeListsStateNotifier extends StateNotifier<List<AnimeList>> {
  final Ref _ref;

  AnimeListsStateNotifier({required ref})
      : _ref = ref,
        super([]);

  Future<void> updateState() async {
    final newState =
        await _ref.read(animeControllerProvider.notifier).getAllAnimeList();

    state = newState;
  }
}

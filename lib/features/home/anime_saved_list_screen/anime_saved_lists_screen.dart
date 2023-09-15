import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/favorites_state_notifier.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/watching_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_screen_widgets/anime_list_tile.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeSavedListsScreen extends ConsumerStatefulWidget {
  const AnimeSavedListsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimeListScreenState();
}

class _AnimeListScreenState extends ConsumerState<AnimeSavedListsScreen>
    with AutomaticKeepAliveClientMixin<AnimeSavedListsScreen> {
  late Stream<List<AnimeList>> animeAllLists;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final fav = ref.watch(favoriteStateNotifierProvider);
    final watching = ref.watch(watchingStateNotifierProvider);
    final animeLists = ref.watch(animeListsStateNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: animeLists.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return AnimeListTile(
              animeList: fav,
            );
          }
          if (index == 1) {
            return AnimeListTile(
              animeList: watching,
            );
          }
          return AnimeListTile(
            animeList: animeLists[index - 2],
          );
        },
      ),
    );
  }
}

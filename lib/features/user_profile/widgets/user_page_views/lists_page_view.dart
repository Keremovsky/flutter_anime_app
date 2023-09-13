import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_screen_widgets/anime_list_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListsPageView extends ConsumerStatefulWidget {
  const ListsPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPageViewState();
}

class _ListPageViewState extends ConsumerState<ListsPageView>
    with AutomaticKeepAliveClientMixin<ListsPageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final animeLists = ref.watch(animeListsStateNotifierProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: animeLists.length,
        itemBuilder: (context, index) {
          return AnimeListTile(
            animeList: animeLists[index],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/watching_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchingListPageView extends ConsumerStatefulWidget {
  const WatchingListPageView({super.key});

  @override
  ConsumerState<WatchingListPageView> createState() => _WatchingListPageView();
}

class _WatchingListPageView extends ConsumerState<WatchingListPageView>
    with AutomaticKeepAliveClientMixin<WatchingListPageView> {
  // to save state
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final watching = ref.watch(watchingStateNotifierProvider);

    return AnimeListView(animeList: watching);
  }
}

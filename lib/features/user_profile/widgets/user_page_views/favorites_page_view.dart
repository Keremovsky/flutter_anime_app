import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/favorites_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPageView extends ConsumerStatefulWidget {
  const FavoritesPageView({super.key});

  @override
  ConsumerState<FavoritesPageView> createState() => _FavoritesPageViewState();
}

class _FavoritesPageViewState extends ConsumerState<FavoritesPageView>
    with AutomaticKeepAliveClientMixin<FavoritesPageView> {
  // to save state
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final fav = ref.watch(favoriteStateNotifierProvider);

    return AnimeListView(animeList: fav);
  }
}

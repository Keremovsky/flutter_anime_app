import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/favorites_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesTabView extends ConsumerStatefulWidget {
  const FavoritesTabView({super.key});

  @override
  ConsumerState<FavoritesTabView> createState() => _FavoritesTabViewState();
}

class _FavoritesTabViewState extends ConsumerState<FavoritesTabView>
    with AutomaticKeepAliveClientMixin<FavoritesTabView> {
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

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/favorites_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesTabView extends ConsumerStatefulWidget {
  final UserModel userModel;

  const FavoritesTabView({super.key, required this.userModel});

  @override
  ConsumerState<FavoritesTabView> createState() => _FavoritesTabViewState();
}

class _FavoritesTabViewState extends ConsumerState<FavoritesTabView>
    with AutomaticKeepAliveClientMixin<FavoritesTabView> {
  @override
  bool get wantKeepAlive => true;

  Future<AnimeList> fetchFav() async {
    final result =
        await ref.read(animeControllerProvider.notifier).getAnimeList(
              Constants.favoriteListName,
              widget.userModel.uid,
            );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final currentUser = ref.read(userProvider)!;

    if (currentUser.uid == widget.userModel.uid) {
      final currentFav = ref.watch(favoriteStateNotifierProvider);

      return AnimeListView(animeList: currentFav);
    } else {
      return FutureBuilder(
        future: fetchFav(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final data = snapshot.data;

          if (data == null) {
            return const SizedBox();
          }

          return AnimeListView(animeList: data);
        },
      );
    }
  }
}

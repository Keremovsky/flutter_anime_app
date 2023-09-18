import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/watching_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchingListTabView extends ConsumerStatefulWidget {
  final UserModel userModel;

  const WatchingListTabView({super.key, required this.userModel});

  @override
  ConsumerState<WatchingListTabView> createState() =>
      _WatchingListTabViewState();
}

class _WatchingListTabViewState extends ConsumerState<WatchingListTabView>
    with AutomaticKeepAliveClientMixin<WatchingListTabView> {
  @override
  bool get wantKeepAlive => true;

  Future<AnimeList> fetchWatch() async {
    final result =
        await ref.read(animeControllerProvider.notifier).getAnimeList(
              Constants.watchingListName,
              widget.userModel.uid,
            );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final currentUser = ref.read(userProvider)!;

    if (currentUser.uid == widget.userModel.uid) {
      final currentFav = ref.watch(watchingStateNotifierProvider);

      return AnimeListView(animeList: currentFav);
    } else {
      return FutureBuilder(
        future: fetchWatch(),
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

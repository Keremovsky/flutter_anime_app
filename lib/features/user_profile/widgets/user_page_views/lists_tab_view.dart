import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_screen_widgets/anime_list_tile.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListsTabView extends ConsumerStatefulWidget {
  final UserModel userModel;

  const ListsTabView({super.key, required this.userModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTabViewState();
}

class _ListTabViewState extends ConsumerState<ListsTabView>
    with AutomaticKeepAliveClientMixin<ListsTabView> {
  @override
  bool get wantKeepAlive => true;

  Future<List<AnimeList>> fetchAllLists() async {
    final result = ref
        .read(animeControllerProvider.notifier)
        .getAllAnimeList(widget.userModel.uid);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final currentUser = ref.read(userProvider)!;

    if (currentUser.uid == widget.userModel.uid) {
      final animeLists = ref.watch(animeListsStateNotifierProvider);

      return ListView.builder(
        itemCount: animeLists.length,
        itemBuilder: (context, index) {
          return AnimeListTile(
            animeList: animeLists[index],
            userModel: widget.userModel,
          );
        },
      );
    } else {
      return FutureBuilder(
        future: fetchAllLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final data = snapshot.data;

          if (data == null) {
            return const SizedBox();
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AnimeListTile(
                animeList: data[index],
                userModel: widget.userModel,
              );
            },
          );
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_screen_widgets/anime_list_tile.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/themes/palette.dart';
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
  void initState() {
    super.initState();
    animeAllLists =
        ref.read(animeControllerProvider.notifier).getAllAnimeListStream();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: animeAllLists,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularProgressIndicator(
                size: 100,
                color: Palette.mainColor,
              );
            }

            final data = snapshot.data;

            if (data == null) {
              return const Text("error");
            } else if (data.isEmpty) {
              return const Text("error");
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AnimeListTile(
                      animeList: data[index],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

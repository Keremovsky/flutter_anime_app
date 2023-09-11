import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_tile.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
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
  List<String> listNames = [];
  late Future<List<List<PreAnime>>> preAnimes;

  Future<List<List<PreAnime>>> _getPreAnimes() async {
    final animeListNames =
        await ref.read(animeControllerProvider.notifier).getAnimeListNames();

    List<AnimeList> animesLists = [];
    for (final animeListName in animeListNames) {
      listNames.add(animeListName);
      final animeIDs = await ref
          .read(animeControllerProvider.notifier)
          .getAnimeListData(animeListName);
      animesLists.add(animeIDs);
    }

    List<List<PreAnime>> preAnimes = [];
    for (final animeIDs in animesLists) {
      final preAnime = await ref
          .read(animeControllerProvider.notifier)
          .getPreAnimeListWithID(animeIDs.animes);
      preAnimes.add(preAnime);
    }

    return preAnimes;
  }

  @override
  void initState() {
    super.initState();

    preAnimes = _getPreAnimes();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: preAnimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularProgressIndicator(
                size: 100,
                color: Palette.mainColor,
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;

              if (data == null) {
                return const Text("error");
              } else if (data.isEmpty) {
                return const Text("error");
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      preAnimes = _getPreAnimes();
                    });
                  },
                  displacement: 20,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return AnimeListTile(
                        listName: listNames[index],
                        preAnimes: data[index],
                      );
                    },
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

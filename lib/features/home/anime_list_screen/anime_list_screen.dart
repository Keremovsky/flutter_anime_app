import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/home/anime_list_screen/widgets/anime_list_box.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeListScreen extends ConsumerStatefulWidget {
  const AnimeListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimeListScreenState();
}

class _AnimeListScreenState extends ConsumerState<AnimeListScreen> {
  List<String> listNames = [];
  late Future<List<List<PreAnime>>> preAnimes;

  Future<List<List<PreAnime>>> _getPreAnimes() async {
    final animeListData =
        await ref.read(animeControllerProvider.notifier).getAnimeListData();

    List<List<PreAnime>> animes = [];
    for (final data in animeListData) {
      listNames.add(data["listName"]);
      final anime = await ref
          .read(animeControllerProvider.notifier)
          .getPreAnimeListWithID(data["animes"]);
      animes.add(anime);
    }

    return animes;
  }

  @override
  void initState() {
    super.initState();

    preAnimes = _getPreAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: preAnimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomCircularProgressIndicator(size: 100);
            } else if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;

              if (data == null) {
                return const Text("error");
              } else if (data.isEmpty) {
                return const Text("error");
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AnimeListBox(
                      listName: listNames[index],
                      preAnimes: data[index],
                    );
                  },
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}

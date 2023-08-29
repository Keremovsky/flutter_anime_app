import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/home/widgets/anime_box.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeListView extends ConsumerStatefulWidget {
  final String title;
  final String collectionRef;

  const AnimeListView({
    super.key,
    required this.title,
    required this.collectionRef,
  });

  @override
  ConsumerState<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends ConsumerState<AnimeListView> {
  // variable to store animes
  late Future<List<Anime>> animeList;

  Future<List<Anime>> _getAnimeList() async {
    final result = await ref
        .read(animeControllerProvider.notifier)
        .getAnimeList(widget.collectionRef);

    return result;
  }

  @override
  void initState() {
    animeList = _getAnimeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: animeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 205,
                width: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AnimeBox(
                      anime: data[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

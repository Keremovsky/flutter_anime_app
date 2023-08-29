import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeBox extends ConsumerStatefulWidget {
  final String animeId;

  const AnimeBox({super.key, required this.animeId});

  @override
  ConsumerState<AnimeBox> createState() => _AnimeBoxState();
}

class _AnimeBoxState extends ConsumerState<AnimeBox> {
  late Future<Anime> anime;

  Future<Anime> _getAnimeData() async {
    final result = await ref
        .read(animeControllerProvider.notifier)
        .getAnimeData(widget.animeId);

    return result;
  }

  @override
  void initState() {
    super.initState();
    anime = _getAnimeData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: anime,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!;
        debugPrint(data.name);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: 180,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(data.imageURL),
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    data.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    "${data.genres[0]}, ${data.genres[1]}",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Palette.grey),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

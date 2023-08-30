import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeScreen extends ConsumerStatefulWidget {
  final String id;

  const AnimeScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends ConsumerState<AnimeScreen> {
  late Future<Anime> anime;

  Future<Anime> getAnime(String id) async {
    final result =
        await ref.read(animeControllerProvider.notifier).getAnime(id);

    return result;
  }

  @override
  void initState() {
    anime = getAnime(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: anime,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final animeData = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              animeData.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Palette.mainColor),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Palette.mainColor,
                size: 30,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 240,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(animeData.imageURL),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 240,
                        width: width - 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Type: ${animeData.type}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Year: ${animeData.year}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Episodes: ${animeData.episodes}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Status: ${animeData.status}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Broadcast Day: ${animeData.broadcastDay}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Genres: ${animeData.genres.join(", ")}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Score: ${animeData.score}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Favorites: ${animeData.favorites}",
                                overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Name: ${animeData.name}",
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    "Japanese Name: ${animeData.japName}",
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(animeControllerProvider.notifier)
                          .likeAnime(context, animeData.id);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Palette.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

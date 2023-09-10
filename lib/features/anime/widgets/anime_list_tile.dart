import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_box_leading.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class AnimeListTile extends StatelessWidget {
  final String listName;
  final List<PreAnime> preAnimes;

  const AnimeListTile({
    super.key,
    required this.listName,
    required this.preAnimes,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        context.pushNamed(RouteConstants.animeListsScreenName, extra: [
          listName,
          preAnimes,
        ]);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Builder(
              builder: (context) {
                if (preAnimes.isEmpty) {
                  return const AnimeListBoxLeading(imageURLs: []);
                } else {
                  if (preAnimes.length < 4) {
                    return AnimeListBoxLeading(imageURLs: [
                      preAnimes[0].imageURL,
                    ]);
                  } else {
                    return AnimeListBoxLeading(imageURLs: [
                      preAnimes[0].imageURL,
                      preAnimes[1].imageURL,
                      preAnimes[2].imageURL,
                      preAnimes[3].imageURL,
                    ]);
                  }
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      listName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 20,
                      width: width - 125,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: preAnimes.length,
                        itemBuilder: (context, index) {
                          return Text(
                            "${preAnimes[index].name}   ",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Palette.grey),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

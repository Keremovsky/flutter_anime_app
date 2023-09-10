import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/anime_list_screen/widgets/anime_list_box_leading.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeListBox extends StatelessWidget {
  final String listName;
  final List<PreAnime> preAnimes;

  const AnimeListBox({
    super.key,
    required this.listName,
    required this.preAnimes,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        for (final preAnime in preAnimes) {
          debugPrint(preAnime.toString());
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Builder(
              builder: (context) {
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
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Palette.mainColor),
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

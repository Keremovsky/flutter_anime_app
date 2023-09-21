import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_screen_widgets/anime_list_tile_leading.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class AnimeListTile extends StatelessWidget {
  final AnimeList animeList;
  final UserModel userModel;

  const AnimeListTile({
    super.key,
    required this.animeList,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          context.pushNamed(RouterConstants.animeListsScreenName, extra: [
            animeList,
            userModel,
          ]);
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.transparent,
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Builder(builder: (context) {
                return AnimeListTileLeading(
                    imageURLs: animeList.animeImageURLs);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 100,
                  width: width - 133,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          animeList.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "${animeList.animesIDs.length}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          animeList.createdDate,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Palette.grey),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 20,
                          width: width - 125,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: animeList.animesIDs.length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${animeList.animeNames[index]}   ",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_screen_widgets/anime_list_tile_leading.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveAnimeListTile extends ConsumerWidget {
  final String currentAnimeID;
  final String animeName;
  final String animeImageURL;
  final AnimeList animeList;

  const SaveAnimeListTile({
    super.key,
    required this.currentAnimeID,
    required this.animeName,
    required this.animeImageURL,
    required this.animeList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () async {
        await ref.read(animeControllerProvider.notifier).setAnimeToList(
              context,
              currentAnimeID,
              animeName,
              animeImageURL,
              animeList.name,
            );
        await ref.read(animeListsStateNotifierProvider.notifier).updateState();
      },
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.transparent,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Builder(builder: (context) {
              return AnimeListTileLeading(imageURLs: animeList.animeImageURLs);
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 100,
                width: width - 125,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        animeList.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: animeList.animesIDs
                                          .contains(currentAnimeID) ==
                                      true
                                  ? Palette.mainColor
                                  : Palette.white,
                            ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "${animeList.animesIDs.length}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: animeList.animesIDs
                                          .contains(currentAnimeID) ==
                                      true
                                  ? Palette.mainColor
                                  : Palette.white,
                            ),
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
    );
  }
}

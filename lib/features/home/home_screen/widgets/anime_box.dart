import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AnimeBox extends ConsumerWidget {
  final PreAnime anime;

  const AnimeBox({super.key, required this.anime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            RouteConstants.animeScreenName,
            pathParameters: {"id": anime.id},
            extra: anime.name,
          );
        },
        child: Column(
          children: [
            Hero(
              tag: anime.imageURL,
              child: Container(
                height: 170,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(anime.imageURL),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  anime.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  anime.genres.join(", "),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Palette.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

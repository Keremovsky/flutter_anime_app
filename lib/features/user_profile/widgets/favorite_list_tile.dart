import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class FavoriteAnimeListTile extends StatelessWidget {
  final PreAnime anime;

  const FavoriteAnimeListTile({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          context.pushNamed(
            RouteConstants.animeScreenName,
            pathParameters: {"id": anime.id},
            extra: anime.name,
          );
        },
        leading: Image.network(
          anime.imageURL,
        ),
        title: Text(
          anime.name,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        subtitle: Text(
          anime.genres.join(", "),
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Palette.grey),
        ),
      ),
    );
  }
}

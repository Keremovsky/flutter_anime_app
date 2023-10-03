import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class GenreBox extends StatelessWidget {
  final String genre;

  const GenreBox({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        color: Palette.boxColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            context.pushNamed(
              RouterConstants.genreListScreenName,
              pathParameters: {
                "genre": genre,
              },
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                genre,
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/models/anime_review.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeReviewBox extends ConsumerWidget {
  final AnimeReview animeReview;

  const AnimeReviewBox({super.key, required this.animeReview});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.boxColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Constants.backgroundImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "user name",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  animeReview.score,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  animeReview.reviewContent,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  animeReview.createdDate.toDate().toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

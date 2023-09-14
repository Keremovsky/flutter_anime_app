import 'package:flutter/material.dart';
import 'package:flutter_anime_app/models/anime_review.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeReviewBox extends StatelessWidget {
  final AnimeReview animeReview;

  const AnimeReviewBox({super.key, required this.animeReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Palette.mainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Text(animeReview.animeID),
    );
  }
}

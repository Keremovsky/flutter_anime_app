import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeReviewList extends StatelessWidget {
  const AnimeReviewList({super.key});

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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeBoxLoad extends StatelessWidget {
  const AnimeBoxLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 170,
            width: 120,
            decoration: BoxDecoration(
              color: Palette.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              color: Palette.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            width: 90,
            decoration: BoxDecoration(
              color: Palette.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

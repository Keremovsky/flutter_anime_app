import 'package:flutter/material.dart';
import 'package:flutter_anime_app/models/anime.dart';

class AnimeScreen extends StatelessWidget {
  final Anime anime;

  const AnimeScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                anime.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

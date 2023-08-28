import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/widgets/anime_box.dart';

class AnimeListView extends StatelessWidget {
  final String title;

  const AnimeListView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 205,
            width: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const AnimeBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

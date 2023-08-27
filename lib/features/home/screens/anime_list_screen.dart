import 'package:flutter/material.dart';

class AnimeListScreen extends StatelessWidget {
  const AnimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }
}

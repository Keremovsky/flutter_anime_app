import 'package:flutter/material.dart';

class AnimeListBoxLeading extends StatelessWidget {
  final List<String> imageURLs;

  const AnimeListBoxLeading({super.key, required this.imageURLs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 65,
      child: imageURLs.isEmpty
          ? const SizedBox()
          : imageURLs.length < 4
              ? Image.network(imageURLs[0])
              : Stack(
                  children: [
                    _returnImage(imageURLs[0], Alignment.topLeft),
                    _returnImage(imageURLs[1], Alignment.topRight),
                    _returnImage(imageURLs[2], Alignment.bottomLeft),
                    _returnImage(imageURLs[3], Alignment.bottomRight),
                  ],
                ),
    );
  }
}

Widget _returnImage(String imageURL, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: SizedBox(
      width: 65 / 2,
      child: Image.network(imageURL),
    ),
  );
}

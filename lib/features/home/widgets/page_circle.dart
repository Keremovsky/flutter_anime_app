import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class PageCircle extends StatelessWidget {
  final bool isSelected;

  const PageCircle({required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: isSelected ? Palette.mainColor : Palette.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

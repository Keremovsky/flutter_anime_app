import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class NavigationButton extends StatelessWidget {
  final IconData buttonIcon;
  final bool isSelected;

  const NavigationButton({
    required this.buttonIcon,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 80,
        ),
        child: Icon(
          buttonIcon,
          color: isSelected ? Palette.mainColor : null,
          size: 30,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class NavigationButton extends StatelessWidget {
  final IconData buttonIcon;
  final bool isSelected;
  final Function navigateToScreen;
  final int index;

  const NavigationButton({
    required this.buttonIcon,
    required this.isSelected,
    required this.navigateToScreen,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        navigateToScreen(index);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width / 6,
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

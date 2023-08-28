import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class ProfileNavigationBarButton extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final Function navigateToIndex;

  const ProfileNavigationBarButton({
    super.key,
    required this.text,
    required this.index,
    required this.isSelected,
    required this.navigateToIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToIndex(index);
      },
      child: SizedBox(
        height: 30,
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: isSelected ? Palette.mainColor : Palette.white,
                  ),
            ),
            const SizedBox(height: 2),
            Container(
              height: 2,
              width: text.length * 9,
              decoration: BoxDecoration(
                color: isSelected ? Palette.mainColor : Palette.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

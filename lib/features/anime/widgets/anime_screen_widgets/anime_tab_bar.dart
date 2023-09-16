import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/icon_label_button.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeTabBar extends StatefulWidget {
  final TabController tabController;

  const AnimeTabBar({super.key, required this.tabController});

  @override
  State<AnimeTabBar> createState() => _AnimeTabBarState();
}

class _AnimeTabBarState extends State<AnimeTabBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.background,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconLabelButton(
                onTap: () {
                  widget.tabController.animateTo(0);
                  setState(() {});
                },
                height: 60,
                width: 100,
                icon: Icon(
                  Icons.video_collection_outlined,
                  color: widget.tabController.index == 0
                      ? Palette.mainColor
                      : Palette.white,
                ),
                label: Text(
                  "Episodes",
                  style: TextStyle(
                    color: widget.tabController.index == 0
                        ? Palette.mainColor
                        : Palette.white,
                  ),
                ),
                borderRadius: BorderRadius.circular(15),
                backgroundColor: Palette.boxColor,
              ),
              IconLabelButton(
                onTap: () {
                  widget.tabController.animateTo(1);
                  setState(() {});
                },
                height: 60,
                width: 100,
                icon: Icon(
                  Icons.reviews,
                  color: widget.tabController.index == 1
                      ? Palette.mainColor
                      : Palette.white,
                ),
                label: Text(
                  "Reviews",
                  style: TextStyle(
                    color: widget.tabController.index == 1
                        ? Palette.mainColor
                        : Palette.white,
                  ),
                ),
                borderRadius: BorderRadius.circular(15),
                backgroundColor: Palette.boxColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

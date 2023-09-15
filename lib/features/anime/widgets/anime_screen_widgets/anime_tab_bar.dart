import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/icon_label_button.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeTabBar extends StatefulWidget {
  final TabController tabController;
  final bool innerBoxIsScrolled;

  const AnimeTabBar({
    super.key,
    required this.tabController,
    required this.innerBoxIsScrolled,
  });

  @override
  State<AnimeTabBar> createState() => _AnimeTabBarState();
}

class _AnimeTabBarState extends State<AnimeTabBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: null,
      automaticallyImplyLeading: false,
      backgroundColor: Palette.background,
      forceElevated: widget.innerBoxIsScrolled,
      toolbarHeight: 70,
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconLabelButton(
            onTap: () {
              widget.tabController.animateTo(0);
              setState(() {
                currentIndex = 0;
              });
            },
            height: 60,
            width: 100,
            icon: Icon(
              Icons.video_collection_outlined,
              color: currentIndex == 0 ? Palette.mainColor : Palette.white,
            ),
            label: Text(
              "Episodes",
              style: TextStyle(
                color: currentIndex == 0 ? Palette.mainColor : Palette.white,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
            backgroundColor: Palette.boxColor,
          ),
          IconLabelButton(
            onTap: () {
              widget.tabController.animateTo(1);
              setState(() {
                currentIndex = 1;
              });
            },
            height: 60,
            width: 100,
            icon: Icon(
              Icons.reviews,
              color: currentIndex == 1 ? Palette.mainColor : Palette.white,
            ),
            label: Text(
              "Reviews",
              style: TextStyle(
                color: currentIndex == 1 ? Palette.mainColor : Palette.white,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
            backgroundColor: Palette.boxColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/icon_label_button.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/set_anime_review_bottom_sheet.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class AnimeTabBar extends StatefulWidget {
  final TabController tabController;
  final Anime anime;

  const AnimeTabBar(
      {super.key, required this.tabController, required this.anime});

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
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SetAnimeReviewBottomSheet(
                        anime: widget.anime,
                      );
                    },
                  );
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

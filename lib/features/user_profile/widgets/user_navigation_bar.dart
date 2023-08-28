// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_anime_app/features/user_profile/widgets/profile_navigation_bar_button.dart';

class UserNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ScrollController scrollController;
  final Function navigateToListIndex;

  const UserNavigationBar({
    super.key,
    required this.currentIndex,
    required this.scrollController,
    required this.navigateToListIndex,
  });

  @override
  State<UserNavigationBar> createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  final List<String> actions = [
    "Last Actions",
    "Favorites",
    "Watching",
    "Lists",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 4,
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ProfileNavigationBarButton(
                text: actions[index],
                index: index,
                isSelected: widget.currentIndex == index,
                navigateToIndex: widget.navigateToListIndex,
              ),
            );
          } else if (index == 3) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ProfileNavigationBarButton(
                text: actions[index],
                index: index,
                isSelected: widget.currentIndex == index,
                navigateToIndex: widget.navigateToListIndex,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ProfileNavigationBarButton(
                text: actions[index],
                index: index,
                isSelected: widget.currentIndex == index,
                navigateToIndex: widget.navigateToListIndex,
              ),
            );
          }
        },
      ),
    );
  }
}

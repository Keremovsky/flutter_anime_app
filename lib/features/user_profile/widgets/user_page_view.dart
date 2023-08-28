import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/favorites_page_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/last_actions_page_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/lists_page_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/watching_list_page_view.dart';

class UserPageView extends StatelessWidget {
  final PageController pageController;
  final Function navigateToPageIndex;

  const UserPageView({
    super.key,
    required this.pageController,
    required this.navigateToPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: PageView(
        controller: pageController,
        onPageChanged: (value) {
          navigateToPageIndex(value);
        },
        children: const [
          LastActionsPageView(),
          FavoritesPageView(),
          WatchingListPageView(),
          ListsPageView(),
        ],
      ),
    );
  }
}

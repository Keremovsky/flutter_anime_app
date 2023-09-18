import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_navigation_bar.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_view.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerStatefulWidget {
  final UserModel userData;

  const UserScreen({super.key, required this.userData});

  @override
  ConsumerState<UserScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<UserScreen> {
  // controllers
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  // current index of page view
  int currentIndex = 0;

  // navigate to page
  void _navigateToListIndex(int index) {
    pageController.jumpToPage(
      index,
    );
  }

  // navigate to list item
  void _navigateToPageIndex(int index) {
    setState(() {
      currentIndex = index;
      scrollController.jumpTo(
        index * 12,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
      ),
      body: SizedBox(
        height: height,
        child: ListView(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(height: height * 0.15 + 50),
                    Container(
                      height: height * 0.15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.userData.backgroundPicURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.userData.profilePicURL),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Palette.background,
                            width: 6,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 0,
                      child: Material(
                        color: Palette.mainColor,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 40,
                            width: 120,
                            child: Center(
                              child: Text(
                                "Follow",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.userData.animeName == ""
                                ? widget.userData.username
                                : "${widget.userData.username} / ${widget.userData.animeName}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Palette.grey,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.userData.joinDate,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Palette.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      UserNavigationBar(
                        currentIndex: currentIndex,
                        scrollController: scrollController,
                        navigateToListIndex: _navigateToListIndex,
                      ),
                      const SizedBox(height: 10),
                      UserPageView(
                        pageController: pageController,
                        navigateToPageIndex: _navigateToPageIndex,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

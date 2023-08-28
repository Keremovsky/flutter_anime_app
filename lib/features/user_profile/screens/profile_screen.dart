import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_navigation_bar.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_view.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  int currentIndex = 0;

  void _navigateToListIndex(int index) {
    pageController.jumpToPage(
      index,
    );
  }

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
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(height: height * 0.15 + 50),
                  Container(
                    height: height * 0.15,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/premium-photo/flat-chinese-new-year-festival-celebration-background-china-city-old-houses-chinese_625492-24164.jpg?w=2000"),
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
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://i.redd.it/o8n33z9luwp51.jpg"),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Palette.background,
                          width: 8,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 14,
                    bottom: 0,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Edit Profile",
                        style: Theme.of(context).textTheme.displayLarge,
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
                          "username / anime character",
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
                          "Joined August 2023",
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
                    const SizedBox(height: 20),
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
    );
  }
}

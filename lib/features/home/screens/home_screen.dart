import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/widgets/blog_box.dart';
import 'package:flutter_anime_app/features/home/widgets/navigation_button.dart';
import 'package:flutter_anime_app/features/home/widgets/popular_anime_list_view.dart';
import 'package:flutter_anime_app/features/home/widgets/seasonal_anime_list_view.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SafeArea(
        child: Drawer(
          child: Column(),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "AnimeApp",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Palette.mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Palette.mainColor,
            size: 35,
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NavigationButton(
                  buttonIcon: Icons.home,
                  isSelected: true,
                ),
                NavigationButton(
                  buttonIcon: Icons.search,
                  isSelected: false,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NavigationButton(
                  buttonIcon: Icons.save,
                  isSelected: false,
                ),
                NavigationButton(
                  buttonIcon: Icons.account_circle,
                  isSelected: false,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Palette.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: PageView(
                  controller: pageController,
                  children: const [
                    BlogBox(
                      blogImageURL:
                          "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
                    ),
                    BlogBox(
                      blogImageURL:
                          "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
                    ),
                    BlogBox(
                      blogImageURL:
                          "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
                    ),
                    BlogBox(
                      blogImageURL:
                          "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
                    ),
                  ],
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: const SwapEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 6,
                    dotColor: Palette.white,
                    activeDotColor: Palette.mainColor,
                  ),
                ),
              ),
              const PopularAnimeListView(),
              const SeasonalAnimeListView(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

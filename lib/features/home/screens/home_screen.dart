import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/widgets/blog_box.dart';
import 'package:flutter_anime_app/features/home/widgets/page_circle.dart';
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
      body: SafeArea(
        child: Column(
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
            SmoothPageIndicator(
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
          ],
        ),
      ),
    );
  }
}

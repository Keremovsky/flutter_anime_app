import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/widgets/blog_box_list.dart';
import 'package:flutter_anime_app/features/home/widgets/popular_anime_list_view.dart';
import 'package:flutter_anime_app/features/home/widgets/seasonal_anime_list_view.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              BlogBoxList(pageController: pageController),
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

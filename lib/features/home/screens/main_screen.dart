import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/screens/anime_list_screen.dart';
import 'package:flutter_anime_app/features/home/screens/home_screen.dart';
import 'package:flutter_anime_app/features/home/widgets/home_drawer.dart';
import 'package:flutter_anime_app/features/user_profile/screens/profile_screen.dart';
import 'package:flutter_anime_app/features/home/screens/search_screen.dart';
import 'package:flutter_anime_app/features/home/widgets/navigation_button.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class MainScreen extends StatefulWidget {
  final List<PreAnime> popular;
  final List<PreAnime> seasonal;

  const MainScreen({super.key, required this.popular, required this.seasonal});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // scaffold key to open drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // page controller to control page view
  final PageController pageController = PageController();

  // hold current index
  int currentIndex = 0;

  // navigate to screen with given index
  void _navigateToScreen(int index) {
    pageController.jumpToPage(index);
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "AnimeApp",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
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
            size: 30,
          ),
        ),
      ),
      drawer: const HomeDrawer(),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(
            popular: widget.popular,
            seasonal: widget.seasonal,
          ),
          const SearchScreen(),
          const AnimeListScreen(),
          const ProfileScreen(),
        ],
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.2,
              color: Palette.grey,
            ),
          ),
        ),
        child: BottomAppBar(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NavigationButton(
                    buttonIcon: Icons.home,
                    isSelected: currentIndex == 0,
                    index: 0,
                    navigateToScreen: _navigateToScreen,
                  ),
                  NavigationButton(
                    buttonIcon: Icons.search,
                    isSelected: currentIndex == 1,
                    index: 1,
                    navigateToScreen: _navigateToScreen,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NavigationButton(
                    buttonIcon: Icons.save,
                    isSelected: currentIndex == 2,
                    index: 2,
                    navigateToScreen: _navigateToScreen,
                  ),
                  NavigationButton(
                    buttonIcon: Icons.account_circle,
                    isSelected: currentIndex == 3,
                    index: 3,
                    navigateToScreen: _navigateToScreen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

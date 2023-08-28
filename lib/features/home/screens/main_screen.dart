import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/screens/anime_list_screen.dart';
import 'package:flutter_anime_app/features/home/screens/home_screen.dart';
import 'package:flutter_anime_app/features/home/screens/profile_screen.dart';
import 'package:flutter_anime_app/features/home/screens/search_screen.dart';
import 'package:flutter_anime_app/features/home/widgets/navigation_button.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "mainScreen";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // scaffold key to open drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // page bucket
  final PageStorageBucket bucket = PageStorageBucket();

  // all screens
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AnimeListScreen(),
    const ProfileScreen(),
  ];

  // hold current screen and current index
  Widget currentScreen = const HomeScreen();
  int currentIndex = 0;

  // navigate to screen with given index
  void _navigateToScreen(int index) {
    setState(() {
      currentScreen = screens[index];
      currentIndex = index;
    });
  }

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
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
    );
  }
}

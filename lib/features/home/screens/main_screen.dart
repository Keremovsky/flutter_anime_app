import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/anime_saved_list_screen/anime_saved_lists_screen.dart';
import 'package:flutter_anime_app/features/home/home_screen/home_screen.dart';
import 'package:flutter_anime_app/features/home/widgets/create_post_bottom_sheet.dart';
import 'package:flutter_anime_app/features/home/widgets/home_drawer.dart';
import 'package:flutter_anime_app/features/user_profile/screens/profile_screen.dart';
import 'package:flutter_anime_app/features/home/search_screen/search_screen.dart';
import 'package:flutter_anime_app/features/home/widgets/navigation_button.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  final List<PreAnime> popular;
  final List<PreAnime> seasonal;

  const MainScreen({super.key, required this.popular, required this.seasonal});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
          const AnimeSavedListsScreen(),
          const ProfileScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const CreatePostBottomSheet();
            },
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Palette.white,
        ),
      ),
      resizeToAvoidBottomInset: false,
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
            children: [
              const Spacer(flex: 1),
              NavigationButton(
                buttonIcon: Icons.home,
                isSelected: currentIndex == 0,
                index: 0,
                navigateToScreen: _navigateToScreen,
              ),
              const Spacer(flex: 1),
              NavigationButton(
                buttonIcon: Icons.search,
                isSelected: currentIndex == 1,
                index: 1,
                navigateToScreen: _navigateToScreen,
              ),
              const Spacer(flex: 20),
              NavigationButton(
                buttonIcon: Icons.save,
                isSelected: currentIndex == 2,
                index: 2,
                navigateToScreen: _navigateToScreen,
              ),
              const Spacer(flex: 1),
              NavigationButton(
                buttonIcon: Icons.account_circle,
                isSelected: currentIndex == 3,
                index: 3,
                navigateToScreen: _navigateToScreen,
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

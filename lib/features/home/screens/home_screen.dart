import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/features/home/widgets/anime_list_view.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  // to save state
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: const [
              AnimeListView(
                title: "Popular Animes",
                collectionRef: FirebaseConstants.popularAnimesRef,
              ),
              AnimeListView(
                title: "Seasonal Animes",
                collectionRef: FirebaseConstants.seasonalAnimesRef,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

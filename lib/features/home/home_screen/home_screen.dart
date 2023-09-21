import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/home_screen/widgets/anime_box_list_view.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';

class HomeScreen extends StatefulWidget {
  final List<PreAnime> popular;
  final List<PreAnime> seasonal;

  const HomeScreen({super.key, required this.popular, required this.seasonal});

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
            children: [
              AnimeBoxListView(
                title: "Popular Animes",
                preAnime: widget.popular,
              ),
              AnimeBoxListView(
                title: "Seasonal Animes",
                preAnime: widget.seasonal,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

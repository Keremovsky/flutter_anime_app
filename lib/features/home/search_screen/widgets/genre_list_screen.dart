import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_tile.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreListScreen extends ConsumerStatefulWidget {
  final String genre;

  const GenreListScreen({super.key, required this.genre});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GenreListScreenState();
}

class _GenreListScreenState extends ConsumerState<GenreListScreen> {
  late Future<List<PreAnime>> preAnimes;

  Future<List<PreAnime>> _getPreAnimes(String genre) async {
    final result =
        await ref.read(animeControllerProvider.notifier).getGenreAnimes(genre);

    return result;
  }

  @override
  void initState() {
    super.initState();
    preAnimes = _getPreAnimes(widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(
          widget.genre,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Palette.mainColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: preAnimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularProgressIndicator(
                size: 50,
                color: Palette.mainColor,
              );
            }

            if (snapshot.data == null) {
              return const SizedBox();
            }
            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimeTile(anime: data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

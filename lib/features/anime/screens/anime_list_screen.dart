import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeListScreen extends ConsumerStatefulWidget {
  final AnimeList animeList;

  const AnimeListScreen({
    super.key,
    required this.animeList,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimeListScreenState();
}

class _AnimeListScreenState extends ConsumerState<AnimeListScreen> {
  late Future<List<PreAnime>> preAnimes;

  Future<List<PreAnime>> _getPreAnimes(List<String> ids) async {
    final result = await ref
        .read(animeControllerProvider.notifier)
        .getPreAnimeListWithID(ids);

    return result;
  }

  @override
  void initState() {
    super.initState();
    preAnimes = _getPreAnimes(widget.animeList.animesIDs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.animeList.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Palette.mainColor),
        ),
        centerTitle: true,
        leading: const AppBarBackButton(),
      ),
      body: AnimeListView(animeList: widget.animeList),
    );
  }
}

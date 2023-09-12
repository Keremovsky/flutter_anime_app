import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/create_anime_list_button.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/save_anime_list_tile.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveAnimeBottomSheet extends ConsumerStatefulWidget {
  final String id;
  final String animeName;
  final String animeImageURL;

  const SaveAnimeBottomSheet({
    super.key,
    required this.id,
    required this.animeName,
    required this.animeImageURL,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveAnimeBottomSheetState();
}

class _SaveAnimeBottomSheetState extends ConsumerState<SaveAnimeBottomSheet> {
  late TextEditingController textController;
  late Stream<List<AnimeList>> animeLists;

  Stream<List<AnimeList>> _getAnimeLists() {
    final result =
        ref.read(animeControllerProvider.notifier).getAllAnimeListStream();

    return result;
  }

  @override
  void initState() {
    textController = TextEditingController();
    animeLists = _getAnimeLists();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: height * 0.55,
        width: double.infinity,
        child: Column(
          children: [
            StreamBuilder(
              stream: animeLists,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                final data = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data[index].name == Constants.favoriteListName ||
                          data[index].name == Constants.watchingListName) {
                        return const SizedBox();
                      }

                      return SaveAnimeListTile(
                        currentAnimeID: widget.id,
                        animeName: widget.animeName,
                        animeImageURL: widget.animeImageURL,
                        animeList: data[index],
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CreateAnimeListButton(
                    id: widget.id,
                    animeName: widget.animeName,
                    animeImageURL: widget.animeImageURL,
                    textController: textController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

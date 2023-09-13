import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/create_anime_list_button.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/save_anime_list_tile.dart';
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

  @override
  void initState() {
    textController = TextEditingController();
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

    final animeLists = ref.watch(animeListsStateNotifierProvider);

    return Padding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: height * 0.55,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: animeLists.length,
                itemBuilder: (context, index) {
                  return SaveAnimeListTile(
                    currentAnimeID: widget.id,
                    animeName: widget.animeName,
                    animeImageURL: widget.animeImageURL,
                    animeList: animeLists[index],
                  );
                },
              ),
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

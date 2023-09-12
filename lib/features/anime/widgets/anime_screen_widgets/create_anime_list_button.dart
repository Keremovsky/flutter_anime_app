import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAnimeListButton extends ConsumerWidget {
  final String id;
  final String animeName;
  final String animeImageURL;
  final TextEditingController textController;

  const CreateAnimeListButton({
    super.key,
    required this.id,
    required this.animeName,
    required this.animeImageURL,
    required this.textController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Palette.mainColor,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () async {
          if (textController.text.isEmpty) {
            giveFeedback(context, "Please fill the text field.");
            return;
          }
          await ref.read(animeControllerProvider.notifier).setAnimeToList(
              context, id, animeName, animeImageURL, textController.text);
        },
        borderRadius: BorderRadius.circular(15),
        child: const SizedBox(
          height: 50,
          width: 50,
          child: Icon(Icons.create),
        ),
      ),
    );
  }
}

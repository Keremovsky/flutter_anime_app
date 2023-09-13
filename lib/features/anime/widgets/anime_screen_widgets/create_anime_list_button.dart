import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
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
            giveFeedback(
              context,
              "Please fill the text field.",
              const Duration(seconds: 1),
            );
            return;
          }
          await ref.read(animeControllerProvider.notifier).setAnimeToList(
                context,
                id,
                animeName,
                animeImageURL,
                textController.text,
              );
          await ref
              .read(animeListsStateNotifierProvider.notifier)
              .updateState();
        },
        borderRadius: BorderRadius.circular(15),
        child: const SizedBox(
          height: 55,
          width: 55,
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}

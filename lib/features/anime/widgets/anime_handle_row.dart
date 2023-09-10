import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime%20handle_button.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeHandleRow extends ConsumerWidget {
  final String id;
  final String name;

  const AnimeHandleRow({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimeHandleButton(
          height: 45,
          width: 80,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ref.read(animeControllerProvider.notifier).likeAnime(context, id);
          },
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Palette.mainColor,
          ),
          label: Text(
            "Like",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Palette.mainColor),
          ),
        ),
        AnimeHandleButton(
          height: 45,
          width: 80,
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          icon: const Icon(
            Icons.bookmark_border_outlined,
            color: Palette.mainColor,
          ),
          label: Text(
            "Save",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Palette.mainColor),
          ),
        ),
        AnimeHandleButton(
          height: 45,
          width: 80,
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await Clipboard.setData(
              ClipboardData(text: name),
            );
          },
          icon: const Icon(
            Icons.copy,
            color: Palette.mainColor,
          ),
          label: Text(
            "Copy Name",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Palette.mainColor),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/favorites_state_notifier.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/watching_state_notifier.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/anime%20handle_button.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_screen_widgets/save_anime_bottom_sheet.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeHandleRow extends ConsumerStatefulWidget {
  final String id;
  final String name;
  final String imageURL;

  const AnimeHandleRow({
    super.key,
    required this.id,
    required this.name,
    required this.imageURL,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeHandleRowState();
}

class _AnimeHandleRowState extends ConsumerState<AnimeHandleRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimeHandleButton(
          height: 45,
          width: 80,
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await ref.read(animeControllerProvider.notifier).setAnimeToList(
                  context,
                  widget.id,
                  widget.name,
                  widget.imageURL,
                  Constants.favoriteListName,
                );
            await ref
                .read(favoriteStateNotifierProvider.notifier)
                .updateState();

            setState(() {});
          },
          icon: Icon(
            ref
                    .read(favoriteStateNotifierProvider.notifier)
                    .controlAnime(widget.id)
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            color: Palette.mainColor,
          ),
          label: Text(
            Constants.favoriteListName,
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
            await ref.read(animeControllerProvider.notifier).setAnimeToList(
                  context,
                  widget.id,
                  widget.name,
                  widget.imageURL,
                  Constants.watchingListName,
                );

            await ref
                .read(watchingStateNotifierProvider.notifier)
                .updateState();

            setState(() {});
          },
          icon: Icon(
            ref
                    .read(watchingStateNotifierProvider.notifier)
                    .controlAnime(widget.id)
                ? Icons.connected_tv
                : Icons.tv,
            color: Palette.mainColor,
          ),
          label: Text(
            Constants.watchingListName,
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
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SaveAnimeBottomSheet(
                  id: widget.id,
                  animeName: widget.name,
                  animeImageURL: widget.imageURL,
                );
              },
            );
          },
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
              ClipboardData(text: widget.name),
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

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SetAnimeReviewBottomSheet extends ConsumerStatefulWidget {
  final Anime anime;

  const SetAnimeReviewBottomSheet({super.key, required this.anime});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetAnimeReviewBottomSheetState();
}

class _SetAnimeReviewBottomSheetState
    extends ConsumerState<SetAnimeReviewBottomSheet> {
  final TextEditingController textController = TextEditingController();
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 0.55 * height,
        child: Column(
          children: [
            TextField(
              controller: textController,
              maxLines: 5,
              maxLength: 120,
              style: Theme.of(context).textTheme.displayLarge,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: RotatedBox(
                quarterTurns: -1,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  controller: scrollController,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 1000,
                  onSelectedItemChanged: (value) {
                    setState(() {});
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 10,
                    builder: (context, index) {
                      return RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              color: scrollController.selectedItem == index
                                  ? Palette.mainColor
                                  : Palette.white,
                              fontSize: scrollController.selectedItem == index
                                  ? 25
                                  : 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (textController.text.isNotEmpty) {
                  await ref
                      .read(animeControllerProvider.notifier)
                      .setAnimeReview(
                        context,
                        textController.text,
                        (scrollController.selectedItem + 1).toString(),
                        widget.anime,
                      );

                  if (mounted) {
                    context.pop();
                  }
                }
              },
              child: const Text("Save Review"),
            ),
          ],
        ),
      ),
    );
  }
}

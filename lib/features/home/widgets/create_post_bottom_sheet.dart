import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostBottomSheet extends ConsumerStatefulWidget {
  const CreatePostBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends ConsumerState<CreatePostBottomSheet> {
  String content = "";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: height * 0.55,
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.displayLarge,
              maxLines: 5,
              maxLength: 150,
              decoration: InputDecoration(
                hintText: "Share your thoughts...",
                hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Palette.grey,
                    ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.file_upload,
                    color: Palette.white,
                  ),
                  label: Text(
                    "Upload Image",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (content == "") {
                      giveFeedback(
                        context,
                        "Please write your thoughts.",
                        const Duration(seconds: 2),
                      );
                      return;
                    }

                    await ref
                        .read(socialControllerProvider.notifier)
                        .createPost(
                          context,
                          content,
                          "",
                        );

                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Add Post",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

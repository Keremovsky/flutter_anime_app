import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/providers/state_notifier_providers/anime_lists_state_notifier.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/anime/controller/anime_controller.dart';
import 'package:flutter_anime_app/features/anime/widgets/anime_list_view.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AnimeListScreen extends ConsumerStatefulWidget {
  final AnimeList animeList;
  final UserModel userModel;

  const AnimeListScreen({
    super.key,
    required this.animeList,
    required this.userModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimeListScreenState();
}

class _AnimeListScreenState extends ConsumerState<AnimeListScreen> {
  bool _controlDelete() {
    final currentUser = ref.read(userProvider)!;

    return widget.userModel.uid == currentUser.uid &&
        widget.animeList.name != Constants.favoriteListName &&
        widget.animeList.name != Constants.watchingListName;
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
        actions: [
          _controlDelete()
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 0,
                          content: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                Text(
                                  "Are you sure?",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "This will delete list permanetly.",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await ref
                                            .read(animeControllerProvider
                                                .notifier)
                                            .deleteAnimeList(
                                                context, widget.animeList.name);

                                        await ref
                                            .read(
                                                animeListsStateNotifierProvider
                                                    .notifier)
                                            .updateState();

                                        if (mounted) {
                                          context.pop();
                                          context.pop();
                                        }
                                      },
                                      child: Text(
                                        "Yes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text(
                                        "No",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Palette.mainColor,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: AnimeListView(animeList: widget.animeList),
    );
  }
}

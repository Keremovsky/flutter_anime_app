import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_list_tile.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUserList extends ConsumerStatefulWidget {
  final String searchText;

  const SearchUserList({super.key, required this.searchText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchAnimeListState();
}

class SearchAnimeListState extends ConsumerState<SearchUserList> {
  late Future<List<UserModel>> users;

  Future<List<UserModel>> searchUser(String searchText) async {
    final result =
        ref.read(socialControllerProvider.notifier).searchUser(searchText);

    return result;
  }

  @override
  void initState() {
    users = searchUser(widget.searchText);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchUserList oldWidget) {
    users = searchUser(widget.searchText);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchText == ""
        ? const SizedBox()
        : FutureBuilder(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressIndicator(
                  size: 50,
                  color: Palette.mainColor,
                );
              }

              if (snapshot.data == null) {
                return const SizedBox();
              }
              final data = snapshot.data!;

              if (data.isEmpty) {
                return Text(
                  "Error!",
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return UserListTile(userModel: data[index]);
                },
              );
            },
          );
  }
}

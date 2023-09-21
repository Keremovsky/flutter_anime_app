import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_list_tile.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListScreen extends ConsumerStatefulWidget {
  final String uid;
  final String type;

  const UserListScreen({super.key, required this.uid, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  late Future<List<UserModel>> userList;

  Future<List<UserModel>> getUserList() async {
    final result = await ref
        .read(socialControllerProvider.notifier)
        .getUserList(widget.uid, widget.type);

    return result;
  }

  @override
  void initState() {
    userList = getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AppBarBackButton()),
      body: FutureBuilder(
        future: userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final data = snapshot.data;

          if (data == null) {
            return const SizedBox();
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return UserListTile(userModel: data[index]);
            },
          );
        },
      ),
    );
  }
}

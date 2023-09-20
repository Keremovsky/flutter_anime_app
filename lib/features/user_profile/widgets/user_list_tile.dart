import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserListTile extends ConsumerWidget {
  final UserModel userModel;

  const UserListTile({super.key, required this.userModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;

    return GestureDetector(
      onTap: () {
        context.pushNamed(RouterConstants.userScreenName, extra: userModel.uid);
      },
      child: ListTile(
        title: Text(
          userModel.username,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userModel.profilePicURL),
        ),
        trailing: Material(
          color: Palette.mainColor,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () async {
              await ref
                  .read(socialControllerProvider.notifier)
                  .setFollow(userModel.uid);
            },
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 30,
              width: 110,
              child: Center(
                child: Text(
                  currentUser.followingUsers.contains(userModel.uid)
                      ? "Following"
                      : "Follow",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

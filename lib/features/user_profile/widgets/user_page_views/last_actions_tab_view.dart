import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/last_action_box.dart';
import 'package:flutter_anime_app/models/action_model.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastActionsTabView extends ConsumerStatefulWidget {
  final UserModel userModel;

  const LastActionsTabView({super.key, required this.userModel});

  @override
  ConsumerState<LastActionsTabView> createState() => _LastActionsTabViewState();
}

class _LastActionsTabViewState extends ConsumerState<LastActionsTabView> {
  late Stream<List<ActionModel>> actionList;

  Stream<List<ActionModel>> _getLastActionStream(String uid) {
    final result =
        ref.read(socialControllerProvider.notifier).getLastActionStream(uid);

    return result;
  }

  @override
  void initState() {
    actionList = _getLastActionStream(widget.userModel.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: actionList,
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
            return LastActionBox(
              actionModel: data[index],
              userModel: widget.userModel,
            );
          },
        );
      },
    );
  }
}

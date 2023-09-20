import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/last_action_box.dart';
import 'package:flutter_anime_app/models/user_model.dart';

class LastActionsTabView extends StatelessWidget {
  final UserModel userModel;

  const LastActionsTabView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        final data = snapshot.data;

        if (data == null) {
          return const SizedBox();
        }

        return ListView.builder(
          itemCount: null,
          itemBuilder: (context, index) {
            return LastActionBox(actionModel: data);
          },
        );
      },
    );
  }
}

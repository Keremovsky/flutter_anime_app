import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/action_type_constants.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/models/action_model.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class LastActionBox extends StatelessWidget {
  final ActionModel actionModel;
  final UserModel userModel;

  const LastActionBox({
    super.key,
    required this.actionModel,
    required this.userModel,
  });

  String _returnContent() {
    if (actionModel.type == ActionTypeConstants.likeAnime) {
      return "${userModel.username} liked ${actionModel.content}.";
    } else if (actionModel.type == ActionTypeConstants.watchAnime) {
      return "${userModel.username} added ${actionModel.content} to watching list.";
    } else if (actionModel.type == ActionTypeConstants.saveAnime) {
      return "${userModel.username} saved ${actionModel.content}.";
    } else if (actionModel.type == ActionTypeConstants.animeReview) {
      return "${userModel.username} reviewed ${actionModel.content}.";
    } else {
      return "${userModel.username} posted ${actionModel.content}.";
    }
  }

  Widget _manageContent(BuildContext context) {
    if (actionModel.type == ActionTypeConstants.post) {
      return const Text("post");
    } else {
      return RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.displayMedium,
          children: [
            TextSpan(text: _returnString()),
            TextSpan(
              text: actionModel.content,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Palette.mainColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushNamed(
                    RouterConstants.animeScreenName,
                    pathParameters: {"id": actionModel.animeID},
                  );
                },
            ),
          ],
        ),
      );
    }
  }

  String _returnString() {
    if (actionModel.type == ActionTypeConstants.likeAnime) {
      return "${userModel.username} liked ";
    } else if (actionModel.type == ActionTypeConstants.watchAnime) {
      return "${userModel.username} started to watch ";
    } else if (actionModel.type == ActionTypeConstants.saveAnime) {
      return "${userModel.username} saved ";
    } else {
      return "${userModel.username} reviewed ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Palette.boxColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: _manageContent(context),
      ),
    );
  }
}

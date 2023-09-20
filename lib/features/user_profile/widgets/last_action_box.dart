import 'package:flutter/material.dart';
import 'package:flutter_anime_app/models/action_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class LastActionBox extends StatelessWidget {
  final ActionModel actionModel;

  const LastActionBox({super.key, required this.actionModel});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Palette.boxColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(actionModel.type),
      ),
    );
  }
}

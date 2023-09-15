import 'package:flutter/material.dart';

class IconLabelButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Icon icon;
  final Text label;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Function()? onTap;
  final Function()? onLongPress;

  const IconLabelButton({
    super.key,
    this.height,
    this.width,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: borderRadius,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              label,
            ],
          ),
        ),
      ),
    );
  }
}

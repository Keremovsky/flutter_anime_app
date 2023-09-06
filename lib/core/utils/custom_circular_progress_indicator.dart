import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final double size;
  final List<Color>? animationColors;
  final Duration animationTime;
  final Color? color;
  final double strokeWidth;

  const CustomCircularProgressIndicator({
    super.key,
    required this.size,
    this.animationColors,
    this.animationTime = const Duration(seconds: 2),
    this.color = Palette.white,
    this.strokeWidth = 4,
  });

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  Animatable<Color?>? animatableColors;

  @override
  void initState() {
    super.initState();

    if (widget.animationColors != null) {
      animatableColors = _uniteColors(widget.animationColors ?? []);
    }

    animationController = AnimationController(
      vsync: this,
      duration: widget.animationTime,
    );
    animationController
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: CircularProgressIndicator(
          color: widget.animationColors == null ? widget.color : null,
          valueColor: animatableColors?.animate(animationController),
          strokeWidth: widget.strokeWidth,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}

TweenSequence<Color?> _uniteColors(List<Color> colors) {
  List<TweenSequenceItem<Color?>> tweenSequenceItems = [];

  for (int i = 0; i < colors.length - 1; i++) {
    final tweenItem = TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: colors[i], end: colors[i + 1]),
    );
    tweenSequenceItems.add(tweenItem);
  }

  tweenSequenceItems.add(
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: colors[colors.length - 1], end: colors[0]),
    ),
  );

  return TweenSequence<Color?>(tweenSequenceItems);
}

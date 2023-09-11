import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  ///Child widget that will be shown when no loading.
  final Widget child;

  ///Auth process.
  final Future Function() authProcess;

  ///The loading indicator that will be shown while loading process.
  final Widget? loadingIndicator;

  /// Height of button.
  final double height;

  /// Width of button.
  final double width;

  /// Boolean value to decide if button will shrink while loading process.
  final bool shrinkOnLoading;

  /// A double value to decide width of button when it shrunk.
  final double shrinkWidth;

  /// Duration variable to decide how much time shrinking will take
  final Duration shrinkAnimationDuration;

  /// Background color of button.
  final Color background;

  const AuthButton({
    super.key,
    required this.child,
    required this.authProcess,
    required this.height,
    required this.width,
    this.shrinkOnLoading = false,
    this.shrinkWidth = 0,
    this.shrinkAnimationDuration = const Duration(seconds: 0),
    this.loadingIndicator,
    this.background = Colors.transparent,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isLoading = false;

  late double height;
  late double width;

  @override
  void initState() {
    height = widget.height;
    width = widget.width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.background,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          setState(() {
            widget.shrinkOnLoading ? width = widget.shrinkWidth : null;
          });
          await Future.delayed(widget.shrinkAnimationDuration);
          setState(() {
            _isLoading = true;
          });
          await widget.authProcess();
          setState(() {
            _isLoading = false;
            widget.shrinkOnLoading ? width = widget.width : null;
          });
        },
        child: AnimatedContainer(
            duration: widget.shrinkAnimationDuration,
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: _isLoading && widget.loadingIndicator != null
                ? Center(child: widget.loadingIndicator)
                : Center(child: widget.child)),
      ),
    );
  }
}

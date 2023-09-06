import 'package:flutter/material.dart';

class SocialAuthButton extends StatefulWidget {
  final String logoImage;
  final Color background;
  final Future<void> Function() authProcess;
  final Widget loadingIndicator;

  const SocialAuthButton({
    super.key,
    required this.logoImage,
    required this.background,
    required this.authProcess,
    required this.loadingIndicator,
  });

  @override
  State<SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<SocialAuthButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });
        await widget.authProcess();
        setState(() {
          _isLoading = false;
        });
      },
      child: Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SizedBox(
          height: 10,
          width: 10,
          child: _isLoading
              ? widget.loadingIndicator
              : Image.asset(
                  widget.logoImage,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}

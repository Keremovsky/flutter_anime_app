import 'package:flutter/material.dart';

class AnimeEpisodeButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final int episode;
  final Function()? onTap;

  const AnimeEpisodeButton({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    required this.episode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: height,
            width: width,
            child: Center(
              child: Text(
                "Episode $episode",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

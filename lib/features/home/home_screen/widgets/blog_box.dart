import 'package:flutter/material.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class BlogBox extends StatelessWidget {
  final String blogImageURL;

  const BlogBox({
    required this.blogImageURL,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("blog box tapped");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(blogImageURL),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.black54,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "One Piece is mid",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "As we all know One Piece is mid. Only One Piece fans",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Palette.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

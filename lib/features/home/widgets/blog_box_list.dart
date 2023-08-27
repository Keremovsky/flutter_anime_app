import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/home/widgets/blog_box.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BlogBoxList extends StatelessWidget {
  final PageController pageController;

  const BlogBoxList({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: double.infinity,
          child: PageView(
            controller: pageController,
            children: const [
              BlogBox(
                blogImageURL:
                    "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
              ),
              BlogBox(
                blogImageURL:
                    "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
              ),
              BlogBox(
                blogImageURL:
                    "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
              ),
              BlogBox(
                blogImageURL:
                    "https://www.asialogy.com/wp-content/uploads/one-piece.webp",
              ),
            ],
          ),
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: 4,
            effect: const SwapEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
              dotColor: Palette.white,
              activeDotColor: Palette.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}

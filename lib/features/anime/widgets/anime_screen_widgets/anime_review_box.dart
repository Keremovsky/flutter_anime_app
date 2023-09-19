import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/models/anime_review.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AnimeReviewBox extends ConsumerStatefulWidget {
  final AnimeReview animeReview;

  const AnimeReviewBox({super.key, required this.animeReview});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeReviewBoxState();
}

class _AnimeReviewBoxState extends ConsumerState<AnimeReviewBox> {
  late Future<UserModel> userModel;

  Future<UserModel> getUserData(String uid) async {
    final result =
        await ref.read(socialControllerProvider.notifier).getUserData(uid);

    return result;
  }

  @override
  void initState() {
    super.initState();

    userModel = getUserData(widget.animeReview.userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        final userModel = snapshot.data;

        if (userModel == null) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.boxColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        final currentUserID = ref.read(userProvider)!.uid;

                        if (currentUserID != userModel.uid) {
                          context.pushNamed(
                            RouteConstants.userScreenName,
                            extra: userModel.uid,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(userModel.profilePicURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            userModel.username,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.animeReview.score,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.animeReview.reviewContent,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      widget.animeReview.createdDate.toDate().toString(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

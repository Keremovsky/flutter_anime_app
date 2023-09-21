import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/constants/route_constants.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/favorites_tab_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/last_actions_tab_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/lists_tab_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/watching_list_tab_view.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserScreen extends ConsumerStatefulWidget {
  final String uid;

  const UserScreen({super.key, required this.uid});

  @override
  ConsumerState<UserScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<UserScreen> {
  late UserModel currentUser;
  late Stream<UserModel> userDataStrem;

  Stream<UserModel> _getUserDataStream(String uid) {
    return ref.read(socialControllerProvider.notifier).getUserDataStream(uid);
  }

  @override
  void initState() {
    userDataStrem = _getUserDataStream(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    currentUser = ref.watch(userProvider)!;

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: userDataStrem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            final userData = snapshot.data;

            if (userData == null) {
              return const SizedBox();
            } else {
              return DefaultTabController(
                length: 4,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      const SliverAppBar(
                        floating: true,
                        leading: AppBarBackButton(),
                        backgroundColor: Palette.background,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Stack(
                              children: [
                                SizedBox(height: height * 0.15 + 50),
                                Container(
                                  height: height * 0.15,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          userData.backgroundPicURL),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  bottom: 0,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            userData.profilePicURL),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Palette.background,
                                        width: 6,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 14,
                                  bottom: 0,
                                  child: Material(
                                    color: Palette.mainColor,
                                    borderRadius: BorderRadius.circular(15),
                                    child: InkWell(
                                      onTap: () async {
                                        await ref
                                            .read(socialControllerProvider
                                                .notifier)
                                            .setFollow(userData.uid);
                                      },
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            currentUser.followingUsers
                                                    .contains(userData.uid)
                                                ? "Following"
                                                : "Follow",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData.animeName == ""
                                            ? userData.username
                                            : "${userData.username} / ${userData.animeName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Palette.grey,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        userData.joinDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: Palette.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                            RouterConstants.userListScreenName,
                                            extra: [
                                              userData.uid,
                                              FirebaseConstants.followingRef,
                                            ],
                                          );
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${userData.followingCount} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: "Following",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        color: Palette.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                            RouterConstants.userListScreenName,
                                            extra: [
                                              userData.uid,
                                              FirebaseConstants.followedRef,
                                            ],
                                          );
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${userData.followedCount} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: "Follower",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        color: Palette.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Palette.white,
                        labelColor: Palette.mainColor,
                        labelStyle: Theme.of(context).textTheme.displayLarge,
                        indicatorColor: Palette.mainColor,
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text("Last Actions"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text("Favorites"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text("Watching List"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text("Lists"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            LastActionsTabView(userModel: userData),
                            FavoritesTabView(userModel: userData),
                            WatchingListTabView(userModel: userData),
                            ListsTabView(userModel: userData),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

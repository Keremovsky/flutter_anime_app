import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/favorites_tab_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/last_actions_tab_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/lists_tab_view.dart';
import 'package:flutter_anime_app/features/user_profile/widgets/user_page_views/watching_list_tab_view.dart';
import 'package:flutter_anime_app/models/user_model.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerStatefulWidget {
  final UserModel userData;

  const UserScreen({super.key, required this.userData});

  @override
  ConsumerState<UserScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(leading: const AppBarBackButton()),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
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
                                  widget.userData.backgroundPicURL),
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
                                image:
                                    NetworkImage(widget.userData.profilePicURL),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Palette.background,
                                width: 6,
                                strokeAlign: BorderSide.strokeAlignOutside,
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
                              onTap: () {},
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: 40,
                                width: 120,
                                child: Center(
                                  child: Text(
                                    "Follow",
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.userData.animeName == ""
                                    ? widget.userData.username
                                    : "${widget.userData.username} / ${widget.userData.animeName}",
                                style: Theme.of(context).textTheme.displayLarge,
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
                                widget.userData.joinDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Palette.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                    const LastActionsTabView(),
                    FavoritesTabView(userModel: widget.userData),
                    WatchingListTabView(userModel: widget.userData),
                    ListsTabView(userModel: widget.userData),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

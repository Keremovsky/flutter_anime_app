import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/features/home/search_screen/widgets/genre_box.dart';
import 'package:flutter_anime_app/features/home/search_screen/widgets/search_anime_list.dart';
import 'package:flutter_anime_app/features/home/search_screen/widgets/search_user_list.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen>, TickerProviderStateMixin {
  ValueNotifier<bool> searchState = ValueNotifier<bool>(false);

  FocusNode focusNode = FocusNode();
  late TextEditingController textController;
  String searchText = "";

  late TabController tabController;

  void textFieldListener() {
    if (textController.value.text.isNotEmpty) {
    } else {
      searchState.value = !searchState.value;
    }
  }

  @override
  void initState() {
    textController = TextEditingController();
    tabController = TabController(length: 2, vsync: this);

    focusNode.addListener(textFieldListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
    tabController.dispose();
    textController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    focusNode: focusNode,
                    controller: textController,
                    style: Theme.of(context).textTheme.displayLarge,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: searchState,
                builder: (context, value, child) {
                  if (value == false) {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 110,
                          ),
                          itemCount: Constants.genres.length,
                          itemBuilder: (context, index) {
                            return GenreBox(genre: Constants.genres[index]);
                          }),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            controller: tabController,
                            unselectedLabelColor: Palette.white,
                            labelColor: Palette.mainColor,
                            labelStyle:
                                Theme.of(context).textTheme.displayLarge,
                            indicatorColor: Palette.mainColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 2.5,
                            dividerColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            labelPadding:
                                const EdgeInsets.symmetric(vertical: 3),
                            tabs: const [
                              Text("Anime"),
                              Text("Users"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                SearchAnimeList(searchText: searchText),
                                SearchUserList(searchText: searchText),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

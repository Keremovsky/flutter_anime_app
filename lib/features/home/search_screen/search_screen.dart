import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/utils/icon_label_button.dart';
import 'package:flutter_anime_app/features/home/search_screen/widgets/genre_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  ValueNotifier<bool> searchState = ValueNotifier<bool>(false);

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
              IconLabelButton(
                onTap: () {
                  searchState.value = !searchState.value;
                },
                icon: const Icon(Icons.change_circle),
                label: Text(
                  "Change",
                  style: Theme.of(context).textTheme.displayLarge,
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
                        },
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Column(
                        children: [
                          Row(),
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

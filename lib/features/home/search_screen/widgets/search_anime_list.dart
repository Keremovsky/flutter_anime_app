import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAnimeList extends ConsumerStatefulWidget {
  final String searchText;

  const SearchAnimeList({super.key, required this.searchText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchAnimeListState();
}

class SearchAnimeListState extends ConsumerState<SearchAnimeList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return SizedBox();
      },
    );
  }
}

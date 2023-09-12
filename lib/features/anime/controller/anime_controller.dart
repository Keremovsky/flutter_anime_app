import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/anime/repository/anime_repository.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeControllerProvider = StateNotifierProvider((ref) => AnimeController(
      animeRepository: ref.read(animeRepositoryProvider),
    ));

class AnimeController extends StateNotifier {
  final AnimeRepository _animeRepository;

  AnimeController({required animeRepository})
      : _animeRepository = animeRepository,
        super(false);

  Future<Anime> getAnime(String id) async {
    final result = await _animeRepository.getAnime(id);

    return result;
  }

  Future<List<PreAnime>> getPreAnimeListWithID(List<String> ids) async {
    final result = await _animeRepository.getPreAnimeListWithID(ids);

    return result;
  }

  Future<List<PreAnime>> getPreAnimeListWithColl(String collectionName) async {
    final result =
        await _animeRepository.getPreAnimeListWithColl(collectionName);

    return result;
  }

  Stream<AnimeList> getAnimeListStream(String listName) {
    final result = _animeRepository.getAnimeListStream(listName);

    return result;
  }

  Stream<List<AnimeList>> getAllAnimeListStream() {
    final result = _animeRepository.getAllAnimeListStream();

    return result;
  }

  Future<void> setAnimeToList(BuildContext context, String id, String animeName,
      String animeImageURL, String listName) async {
    final control = await _animeRepository.setAnimeToList(
      id,
      animeName,
      animeImageURL,
      listName,
    );

    if (mounted) {
      if (control == "add") {
        switch (listName) {
          case Constants.favoriteListName:
            giveFeedback(context, "Anime added to the favorites.");
            break;
          case Constants.watchingListName:
            giveFeedback(context, "Anime added to the watching list.");
            break;
          default:
            giveFeedback(context, "Anime added to the list.");
            break;
        }
      } else if (control == "delete") {
        switch (listName) {
          case Constants.favoriteListName:
            giveFeedback(context, "Anime deleted from the favorites.");
            break;
          case Constants.watchingListName:
            giveFeedback(context, "Anime deleted from the watching list.");
            break;
          default:
            giveFeedback(context, "Anime deleted from the list.");
            break;
        }
      } else if (control == "create") {
        giveFeedback(context, "$listName successfully created.");
      } else {
        giveFeedback(context, "Unknown error occurred.");
      }
    }
  }

  Future<void> deleteAnimeList(BuildContext context, String listName) async {
    final control = await _animeRepository.deleteAnimeList(listName);

    if (mounted) {
      if (control == "success") {
        giveFeedback(context, "List permanently deleted.");
      } else if (control == "no_list") {
        giveFeedback(context, "There is no list with given name.");
      } else {
        giveFeedback(context, "Unknown error occurred.");
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/anime/repository/anime_repository.dart';
import 'package:flutter_anime_app/models/anime.dart';
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

  Future<List<Anime>> getAnimeListWithID(List<String> ids) async {
    final result = await _animeRepository.getAnimeListWithID(ids);

    return result;
  }

  Future<List<Anime>> getAnimeListWithColl(String collectionName) async {
    final result = await _animeRepository.getAnimeListWithColl(collectionName);

    return result;
  }

  void likeAnime(BuildContext context, String id) async {
    final control = await _animeRepository.likeAnime(id);

    if (mounted) {
      if (control == "add") {
        giveFeedback(context, "Anime added to the favorites.");
      } else if (control == "delete") {
        giveFeedback(context, "Anime deleted form the favorites.");
      } else {
        giveFeedback(context, "Unknown error occurred.");
      }
    }
  }

  void setAnimeToList(BuildContext context, String id, String listName) async {
    final control = await _animeRepository.setAnimeToList(id, listName);

    if (mounted) {
      if (control == "add") {
        giveFeedback(context, "Anime added to the list.");
      } else if (control == "delete") {
        giveFeedback(context, "Anime deleted form the list.");
      } else {
        giveFeedback(context, "Unknown error occurred.");
      }
    }
  }

  void deleteAnimeList(BuildContext context, String listName) async {
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

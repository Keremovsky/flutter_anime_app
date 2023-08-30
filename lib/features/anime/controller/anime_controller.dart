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

  void setAnimeToList(String id, String listName) async {
    await _animeRepository.setAnimeToList(id, listName);
  }
}

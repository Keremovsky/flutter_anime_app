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

  Future<List<Anime>> getAnimeList(String collectionName) async {
    final result = await _animeRepository.getAnimeList(collectionName);

    return result;
  }
}

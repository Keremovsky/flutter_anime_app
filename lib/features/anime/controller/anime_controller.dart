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

  Future<Anime> getAnimeData(String id) async {
    final control = await _animeRepository.getAnimeData(id);

    return control;
  }

  Future<List<String>> getPopularAnimeIdList() async {
    final control = await _animeRepository.getPopularAnimeIdList();

    return control;
  }
}

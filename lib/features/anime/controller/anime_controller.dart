import 'package:flutter/foundation.dart';
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

  Future<Anime> getAnimeData(int id) async {
    final control = await _animeRepository.getAnimeData(id);

    Anime errorAnime = Anime(
      id: 0,
      name: "name",
      japName: "japName",
      genres: [],
      score: -1,
      reviewsCollectionRef: "",
      episodes: 0,
      status: "",
      year: 0,
      broadcastDay: "",
      imageURL: "",
      trailerURL: "",
    );

    control.fold(
      (left) {
        debugPrint(left);

        return errorAnime;
      },
      (right) {
        return right;
      },
    );

    return errorAnime;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeRepositoryProvider = Provider((ref) => AnimeRepository(
      firestore: ref.read(firestoreProvider),
    ));

class AnimeRepository {
  final FirebaseFirestore _firestore;

  CollectionReference get _animesCollection =>
      _firestore.collection(FirebaseConstants.animesRef);

  CollectionReference get _popularAnimesCollection =>
      _firestore.collection(FirebaseConstants.popularAnimesRef);

  CollectionReference get _seasonalAnimesCollection =>
      _firestore.collection(FirebaseConstants.seasonalAnimesRef);

  AnimeRepository({required firestore}) : _firestore = firestore;

  Future<Anime> getAnimeData(String id) async {
    try {
      final anime = await _animesCollection
          .doc(id)
          .snapshots()
          .map((event) => Anime.fromMap(event.data() as Map<String, dynamic>))
          .first;

      return anime;
    } catch (e) {
      final errorAnime = Anime(
        id: "-1",
        name: "error",
        japName: "",
        genres: [],
        type: "",
        score: -1,
        favorites: -1,
        episodes: -1,
        status: "",
        year: -1,
        broadcastDay: "",
        imageURL: "",
        trailerURL: "",
      );
      return errorAnime;
    }
  }

  Future<List<String>> getAnimeIdList(String collectionName) async {
    late QuerySnapshot<Object?> querySnapshot;

    if (collectionName == "Popular Animes") {
      querySnapshot = await _popularAnimesCollection.get();
    } else {
      querySnapshot = await _seasonalAnimesCollection.get();
    }

    final popularAnimeList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    List<String> animeIdList = [];

    for (final anime in popularAnimeList) {
      animeIdList.add(anime["id"]);
    }

    return animeIdList;
  }
}

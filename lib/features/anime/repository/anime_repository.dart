import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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

  // save 40 animes to firebase
  Future<void> saveAnime() async {
    List<String> allAnimes = [
      "39535",
      "5114",
      "28851",
      "19",
      "263",
      "1535",
      "37991",
      "51179",
      "513",
      "523",
      "16662",
      "30276",
      "30831",
      "8687",
      "245",
      "23273",
      "40748",
      "2001",
      "20",
      "1735",
      "35790",
      "9253",
      "11061",
      "9969",
      "16498",
      "10620",
      "269",
      "30",
      "21",
      "14813",
      "14719",
      "20899",
      "31933",
      "45576",
      "226",
      "44511",
      "42249",
      "11771",
      "16894",
      "24415",
      "40748",
      "51009",
      "47160",
      "54112",
      "53998",
    ];

    for (final value in allAnimes) {
      await Future.delayed(const Duration(seconds: 1));

      final link = "https://api.jikan.moe/v4/anime/$value";

      final result = await http.get(Uri.parse(link));
      final data = jsonDecode(result.body)["data"];

      List<String> genres = [];

      for (final genre in data["genres"]) {
        genres.add(genre["name"]);

        final doc =
            await _firestore.collection("genres").doc(genre["name"]).get();

        if (doc.exists) {
          await _firestore
              .collection("genres")
              .doc(genre["name"])
              .update({"$value": "animes/$value"});
        } else {
          await _firestore
              .collection("genres")
              .doc(genre["name"])
              .set({"$value": "animes/$value"});
        }
      }

      final anime = Anime(
        id: value,
        name: data["title"],
        japName: data["title_japanese"],
        genres: genres,
        type: data["type"],
        score: 0,
        favorites: 0,
        episodes: data["episodes"] ?? 0,
        status: data["status"],
        year: data["aired"]["prop"]["from"]["year"],
        broadcastDay: data["broadcast"]["day"] ?? "",
        imageURL: data["images"]["jpg"]["large_image_url"],
        trailerURL: data["trailer"]["url"] ?? "",
      );

      await _animesCollection.doc(value.toString()).set(anime.toMap());
    }
  }
}

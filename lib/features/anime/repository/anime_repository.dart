import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeRepositoryProvider = Provider((ref) => AnimeRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class AnimeRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  CollectionReference get _animesCollection =>
      _firestore.collection(FirebaseConstants.animesRef);

  CollectionReference get _popularAnimesCollection =>
      _firestore.collection(FirebaseConstants.popularAnimesRef);

  CollectionReference get _seasonalAnimesCollection =>
      _firestore.collection(FirebaseConstants.seasonalAnimesRef);

  AnimeRepository({required firestore, required ref})
      : _firestore = firestore,
        _ref = ref;

  Future<List<String>> getAnimeIDList(String listName) async {
    try {
      // get user uid
      final userUid = _ref.read(userProvider)!.uid;

      // collection reference to lists
      final userListCollection = _usersCollection
          .doc(userUid)
          .collection(FirebaseConstants.animeListRef);

      final animeListDoc = await userListCollection.doc(listName).get();

      List<String> ids = [];
      if (animeListDoc.exists) {
        final fields = animeListDoc.data();

        fields!.forEach((key, value) {
          ids.add(value);
        });

        return ids;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Anime> getAnime(String id) async {
    try {
      final anime = await _getAnimeByID(id);

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

  Future<List<PreAnime>> getPreAnimeListWithID(List<String> ids) async {
    try {
      List<PreAnime> preAnimes = [];
      for (final id in ids) {
        final preAnime = await _getPreAnimeByID(id);

        preAnimes.add(preAnime);
      }

      return preAnimes;
    } catch (e) {
      return [];
    }
  }

  Future<List<PreAnime>> getPreAnimeListWithColl(String collectionName) async {
    try {
      late QuerySnapshot<Object?> querySnapshot;

      if (collectionName == FirebaseConstants.popularAnimesRef) {
        querySnapshot = await _popularAnimesCollection.get();
      } else {
        querySnapshot = await _seasonalAnimesCollection.get();
      }

      final popularAnimeList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      List<PreAnime> preAnimes = [];
      for (final preAnimeID in popularAnimeList) {
        final preAnime = await _getPreAnimeByID(preAnimeID["id"]);

        preAnimes.add(preAnime);
      }
      return preAnimes;
    } catch (e) {
      return [];
    }
  }

  Future<String> likeAnime(String id) async {
    try {
      // get user uid
      final userUid = _ref.read(userProvider)!.uid;

      // collection reference to lists
      final userListCollection = _usersCollection
          .doc(userUid)
          .collection(FirebaseConstants.animeListRef);

      // get given list document
      final animeFavDoc = await userListCollection.doc("Favorites").get();

      // get anime
      final anime = await _getAnimeByID(id);

      // if list with given name exists
      if (animeFavDoc.exists) {
        // get the data of document
        final fields = animeFavDoc.data();

        // if given anime exists in list
        if (fields!.containsKey(id)) {
          await userListCollection
              .doc("Favorites")
              .update({id: FieldValue.delete()});

          // update anime
          final newAnime = anime.copyWith(favorites: anime.favorites - 1);
          await _setAnime(newAnime);

          return "delete";
        } else {
          await userListCollection.doc("Favorites").update({id: id});

          // update anime
          final newAnime = anime.copyWith(favorites: anime.favorites + 1);
          await _setAnime(newAnime);

          return "add";
        }
      } else {
        await userListCollection.doc("Favorites").set({id: id});

        // update anime
        final newAnime = anime.copyWith(favorites: anime.favorites + 1);
        await _setAnime(newAnime);

        return "add";
      }
    } catch (e) {
      return "error";
    }
  }

  Future<String> setAnimeToList(String id, String listName) async {
    try {
      // get user uid
      final userUid = _ref.read(userProvider)!.uid;

      // collection reference to lists
      final userListCollection = _firestore
          .collection(FirebaseConstants.usersRef)
          .doc(userUid)
          .collection(FirebaseConstants.animeListRef);

      // get given list document
      final animeListDoc = await userListCollection.doc(listName).get();

      // if list with given name exists
      if (animeListDoc.exists) {
        // get the data of document
        final fields = animeListDoc.data();

        // if given anime exists in list
        if (fields!.containsKey(id)) {
          await userListCollection
              .doc(listName)
              .update({id: FieldValue.delete()});

          return "delete";
        } else {
          await userListCollection.doc(listName).update({id: id});

          return "add";
        }
      } else {
        await userListCollection.doc(listName).set({id: id});

        return "add";
      }
    } catch (e) {
      return "error";
    }
  }

  Future<String> deleteAnimeList(String listName) async {
    try {
      // get user uid
      final userUid = _ref.read(userProvider)!.uid;

      // collection reference to lists
      final userListCollection = _firestore
          .collection(FirebaseConstants.usersRef)
          .doc(userUid)
          .collection(FirebaseConstants.animeListRef);

      final animeListDoc = await userListCollection.doc(listName).get();

      if (animeListDoc.exists) {
        userListCollection.doc(listName).delete();
        return "success";
      } else {
        return "no_list";
      }
    } catch (e) {
      return "error";
    }
  }

  // -------------------------------------------------------------------------------------------------------

  Future<Anime> _getAnimeByID(String id) async {
    final anime = await _animesCollection
        .doc(id)
        .collection(FirebaseConstants.coreAnimeRef)
        .doc(id)
        .snapshots()
        .map((event) => Anime.fromMap(event.data() as Map<String, dynamic>))
        .first;

    return anime;
  }

  Future<PreAnime> _getPreAnimeByID(String id) async {
    final preAnime = await _animesCollection
        .doc(id)
        .snapshots()
        .map((event) => PreAnime.fromMap(event.data() as Map<String, dynamic>))
        .first;

    return preAnime;
  }

  Future<void> _setAnime(Anime anime) async {
    await _animesCollection
        .doc(anime.id)
        .collection(FirebaseConstants.coreAnimeRef)
        .doc(anime.id)
        .set(anime.toMap());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
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

  AnimeRepository({required firestore}) : _firestore = firestore;

  Future<Either<String, Anime>> getAnimeData(int id) async {
    try {
      final anime = await _animesCollection
          .doc(id.toString())
          .snapshots()
          .map((event) => Anime.fromMap(event.data() as Map<String, dynamic>))
          .first;

      return Right(anime);
    } catch (e) {
      return const Left("error");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_anime_app/core/constants/action_type_constants.dart';
import 'package:flutter_anime_app/core/constants/constants.dart';
import 'package:flutter_anime_app/core/constants/firebase_constants.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_anime_app/core/utils.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_anime_app/features/social/controller/social_controller.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/models/anime_list.dart';
import 'package:flutter_anime_app/models/anime_review.dart';
import 'package:flutter_anime_app/models/pre_anime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeRepositoryProvider = Provider((ref) => AnimeRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
      socialController: ref.read(socialControllerProvider.notifier),
    ));

class AnimeRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;
  final SocialController _socialController;

  DocumentSnapshot? lastDocument;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersRef);

  CollectionReference get _animesCollection =>
      _firestore.collection(FirebaseConstants.animesRef);

  CollectionReference get _popularAnimesCollection =>
      _firestore.collection(FirebaseConstants.popularAnimesRef);

  CollectionReference get _seasonalAnimesCollection =>
      _firestore.collection(FirebaseConstants.seasonalAnimesRef);

  AnimeRepository({required firestore, required ref, required socialController})
      : _firestore = firestore,
        _ref = ref,
        _socialController = socialController;

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

      final collectionAnimeList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      List<PreAnime> preAnimes = [];
      for (final preAnimeID in collectionAnimeList) {
        final preAnime = await _getPreAnimeByID(preAnimeID["id"]);

        preAnimes.add(preAnime);
      }
      return preAnimes;
    } catch (e) {
      return [];
    }
  }

  Future<String> setAnimeToList(
    String id,
    String animeName,
    String animeImageURL,
    String listName,
  ) async {
    try {
      // get user uid
      final userModel = _ref.read(userProvider)!;

      // collection reference to lists
      final animeListCollection = _usersCollection
          .doc(userModel.uid)
          .collection(FirebaseConstants.animeListRef);

      // get document of given list
      final animeListDoc = await animeListCollection.doc(listName).get();

      // if list with given name exists
      if (animeListDoc.exists) {
        // get the data of document
        final animeList = await _getAnimeList(listName, animeListCollection);

        // if given anime exists in list
        if (animeList.animesIDs.contains(id)) {
          final newAnimeIDs = animeList.animesIDs.where(
            (element) => element != id,
          );
          final newAnimeNames = animeList.animeNames.where(
            (element) => element != animeName,
          );
          final newAnimeImageURLs = animeList.animeImageURLs.where(
            (element) => element != animeImageURL,
          );

          final newAnimeList = animeList.copyWith(
            animesIDs: newAnimeIDs.toList(),
            animeNames: newAnimeNames.toList(),
            animeImageURLs: newAnimeImageURLs.toList(),
          );

          await _setAnimeList(listName, newAnimeList, animeListCollection);

          if (listName == Constants.favoriteListName) {
            final anime = await _getAnimeByID(id);
            await _setAnime(anime.copyWith(favorites: anime.favorites - 1));
          }

          return "delete";
        } else {
          final newAnimeIDs = animeList.animesIDs + [id];
          final newAnimeNames = animeList.animeNames + [animeName];
          final newAnimeImageURLs = animeList.animeImageURLs + [animeImageURL];

          final newAnimeList = animeList.copyWith(
            animesIDs: newAnimeIDs,
            animeNames: newAnimeNames,
            animeImageURLs: newAnimeImageURLs,
          );

          await _setAnimeList(listName, newAnimeList, animeListCollection);

          if (listName == Constants.favoriteListName) {
            final anime = await _getAnimeByID(id);
            await _setAnime(anime.copyWith(favorites: anime.favorites + 1));
          }

          if (listName == Constants.favoriteListName) {
            await _socialController.saveLastAction(
              userModel.uid,
              ActionTypeConstants.likeAnime,
              animeName,
              id,
            );
          } else if (listName == Constants.watchingListName) {
            await _socialController.saveLastAction(
              userModel.uid,
              ActionTypeConstants.watchAnime,
              animeName,
              id,
            );
          } else {
            await _socialController.saveLastAction(
              userModel.uid,
              ActionTypeConstants.saveAnime,
              animeName,
              id,
            );
          }

          return "add";
        }
      } else {
        final date = getDateDMY();

        final animeList = AnimeList(
          name: listName,
          animesIDs: [id],
          animeNames: [animeName],
          animeImageURLs: [animeImageURL],
          createdDate: date,
        );

        await _setAnimeList(listName, animeList, animeListCollection);

        if (listName == Constants.favoriteListName) {
          await _socialController.saveLastAction(
            userModel.uid,
            ActionTypeConstants.likeAnime,
            animeName,
            id,
          );
        } else if (listName == Constants.watchingListName) {
          await _socialController.saveLastAction(
            userModel.uid,
            ActionTypeConstants.watchAnime,
            animeName,
            id,
          );
        } else {
          await _socialController.saveLastAction(
            userModel.uid,
            ActionTypeConstants.saveAnime,
            animeName,
            id,
          );
        }

        return "create";
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
      final animeListCollection = _usersCollection
          .doc(userUid)
          .collection(FirebaseConstants.animeListRef);

      final animeListDoc = await animeListCollection.doc(listName).get();

      if (animeListDoc.exists) {
        animeListCollection.doc(listName).delete();
        return "success";
      } else {
        return "no_list";
      }
    } catch (e) {
      return "error";
    }
  }

  Future<AnimeList> getAnimeList(String listName, String uid) {
    // collection reference to lists
    final animeListCollection =
        _usersCollection.doc(uid).collection(FirebaseConstants.animeListRef);

    final animeListStream = _getAnimeList(listName, animeListCollection);

    return animeListStream;
  }

  Future<List<AnimeList>> getAllAnimeList(String uid) {
    // collection reference to lists
    final animeListCollection =
        _usersCollection.doc(uid).collection(FirebaseConstants.animeListRef);

    final animeListStream = _getAllAnimeList(animeListCollection);

    return animeListStream;
  }

  Future<List<AnimeReview>> getAnimeReviewsFromAnime(
    String id,
    bool isFirstFetch,
  ) async {
    final reviewCollection = _animesCollection.doc(id).collection("reviews");

    final reviews = await _getAnimeReviews(isFirstFetch, reviewCollection);

    if (reviews == null) {
      return [];
    } else {
      return reviews;
    }
  }

  Future<String> setAnimeReview(
    String content,
    String score,
    Anime anime,
  ) async {
    try {
      final now = DateTime.now();
      final userID = _ref.read(userProvider)!.uid;

      final animeReview = AnimeReview(
        id: anime.name + userID,
        animeID: anime.id,
        animeName: anime.name,
        animeImageURL: anime.imageURL,
        userID: userID,
        createdDate: Timestamp.fromDate(now),
        score: score,
        reviewContent: content,
      );

      final animeReviewCollection =
          _animesCollection.doc(animeReview.animeID).collection("reviews");

      final userReviewCollection =
          _usersCollection.doc(userID).collection("reviews");

      await animeReviewCollection.doc(animeReview.id).set(animeReview.toMap());
      await userReviewCollection.doc(animeReview.id).set(animeReview.toMap());

      await _socialController.saveLastAction(
        userID,
        ActionTypeConstants.animeReview,
        anime.name,
        anime.id,
      );

      return "success";
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

  Future<AnimeList> _getAnimeList(
    String listName,
    CollectionReference<Map<String, dynamic>> animeListCollection,
  ) async {
    final animeList =
        await animeListCollection.doc(listName).snapshots().map((event) {
      final data = event.data()!;
      return AnimeList(
        name: data["name"],
        animesIDs: data["animesIDs"].cast<String>(),
        animeNames: data["animeNames"].cast<String>(),
        animeImageURLs: data["animeImageURLs"].cast<String>(),
        createdDate: data["createdDate"],
      );
    }).first;

    return animeList;
  }

  Future<List<AnimeList>> _getAllAnimeList(
    CollectionReference<Map<String, dynamic>> animeListCollection,
  ) {
    final animeLists = animeListCollection.snapshots().map((event) {
      List<AnimeList> lists = [];
      for (final data in event.docs) {
        if (data.id != Constants.favoriteListName &&
            data.id != Constants.watchingListName) {
          lists.add(
            AnimeList(
              name: data["name"],
              animesIDs: data["animesIDs"].cast<String>(),
              animeNames: data["animeNames"].cast<String>(),
              animeImageURLs: data["animeImageURLs"].cast<String>(),
              createdDate: data["createdDate"],
            ),
          );
        }
      }

      return lists;
    });

    return animeLists.first;
  }

  Future<void> _setAnimeList(
    String listName,
    AnimeList animeList,
    CollectionReference<Map<String, dynamic>> userListCollection,
  ) async {
    await userListCollection.doc(listName).set(animeList.toMap());
  }

  Future<void> _setAnime(Anime anime) async {
    await _animesCollection
        .doc(anime.id)
        .collection(FirebaseConstants.coreAnimeRef)
        .doc(anime.id)
        .set(anime.toMap());
  }

  Future<List<AnimeReview>?> _getAnimeReviews(
    bool isFirstFetch,
    CollectionReference<Map<String, dynamic>> reviewCollection,
  ) async {
    Query query = reviewCollection
        .orderBy(
          "createdDate",
          descending: true,
        )
        .limit(1);

    if (!isFirstFetch) {
      query = query.startAfterDocument(lastDocument!);
    }

    final reviewSnapshot = await query.get();

    if (reviewSnapshot.docs.isEmpty) {
      return null;
    }

    lastDocument = reviewSnapshot.docs.last;

    List<AnimeReview> result = __getAnimeReviewList(reviewSnapshot);

    return result;
  }

  List<AnimeReview> __getAnimeReviewList(QuerySnapshot<Object?> event) {
    List<AnimeReview> animeReviewList = [];

    for (final doc in event.docs) {
      animeReviewList.add(
        AnimeReview.fromMap(doc.data() as Map<String, dynamic>),
      );
    }

    return animeReviewList;
  }
}

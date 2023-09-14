// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AnimeReview {
  final String id;
  final String animeID;
  final String animeName;
  final String animeImageURL;
  final String userID;
  final Timestamp createdDate;
  final String score;
  final String reviewContent;

  AnimeReview({
    required this.id,
    required this.animeID,
    required this.animeName,
    required this.animeImageURL,
    required this.userID,
    required this.createdDate,
    required this.score,
    required this.reviewContent,
  });

  AnimeReview copyWith({
    String? id,
    String? animeID,
    String? animeName,
    String? animeImageURL,
    String? userID,
    Timestamp? createdDate,
    String? score,
    String? reviewContent,
  }) {
    return AnimeReview(
      id: id ?? this.id,
      animeID: animeID ?? this.animeID,
      animeName: animeName ?? this.animeName,
      animeImageURL: animeImageURL ?? this.animeImageURL,
      userID: userID ?? this.userID,
      createdDate: createdDate ?? this.createdDate,
      score: score ?? this.score,
      reviewContent: reviewContent ?? this.reviewContent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'animeID': animeID,
      'animeName': animeName,
      'animeImageURL': animeImageURL,
      'userID': userID,
      'createdDate': createdDate,
      'score': score,
      'reviewContent': reviewContent,
    };
  }

  factory AnimeReview.fromMap(Map<String, dynamic> map) {
    return AnimeReview(
      id: map['id'] as String,
      animeID: map['animeID'] as String,
      animeName: map['animeName'] as String,
      animeImageURL: map['animeImageURL'] as String,
      userID: map['userID'] as String,
      createdDate: map['createdDate'] as Timestamp,
      score: map['score'] as String,
      reviewContent: map['reviewContent'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeReview.fromJson(String source) =>
      AnimeReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimeReview(id: $id, animeID: $animeID, animeName: $animeName, animeImageURL: $animeImageURL, userID: $userID, createdDate: $createdDate, score: $score, reviewContent: $reviewContent)';
  }

  @override
  bool operator ==(covariant AnimeReview other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.animeID == animeID &&
        other.animeName == animeName &&
        other.animeImageURL == animeImageURL &&
        other.userID == userID &&
        other.createdDate == createdDate &&
        other.score == score &&
        other.reviewContent == reviewContent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        animeID.hashCode ^
        animeName.hashCode ^
        animeImageURL.hashCode ^
        userID.hashCode ^
        createdDate.hashCode ^
        score.hashCode ^
        reviewContent.hashCode;
  }
}

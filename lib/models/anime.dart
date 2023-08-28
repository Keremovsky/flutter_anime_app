// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Anime {
  final int id;
  final String name;
  final String japName;
  final List<String> genres;
  final double score;
  final int episodes;
  final String status;
  final int year;
  final String broadcastDay;
  final String imageURL;
  final String trailerURL;

  Anime({
    required this.id,
    required this.name,
    required this.japName,
    required this.genres,
    required this.score,
    required this.episodes,
    required this.status,
    required this.year,
    required this.broadcastDay,
    required this.imageURL,
    required this.trailerURL,
  });

  Anime copyWith({
    int? id,
    String? name,
    String? japName,
    List<String>? genres,
    double? score,
    int? episodes,
    String? status,
    int? year,
    String? broadcastDay,
    String? imageURL,
    String? trailerURL,
  }) {
    return Anime(
      id: id ?? this.id,
      name: name ?? this.name,
      japName: japName ?? this.japName,
      genres: genres ?? this.genres,
      score: score ?? this.score,
      episodes: episodes ?? this.episodes,
      status: status ?? this.status,
      year: year ?? this.year,
      broadcastDay: broadcastDay ?? this.broadcastDay,
      imageURL: imageURL ?? this.imageURL,
      trailerURL: trailerURL ?? this.trailerURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'japName': japName,
      'genres': genres,
      'score': score,
      'episodes': episodes,
      'status': status,
      'year': year,
      'broadcastDay': broadcastDay,
      'imageURL': imageURL,
      'trailerURL': trailerURL,
    };
  }

  factory Anime.fromMap(Map<String, dynamic> map) {
    return Anime(
      id: map['id'] as int,
      name: map['name'] as String,
      japName: map['japName'] as String,
      genres: List<String>.from((map['genres'] as List<String>)),
      score: map['score'] as double,
      episodes: map['episodes'] as int,
      status: map['status'] as String,
      year: map['year'] as int,
      broadcastDay: map['broadcastDay'] as String,
      imageURL: map['imageURL'] as String,
      trailerURL: map['trailerURL'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Anime.fromJson(String source) =>
      Anime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Anime(id: $id, name: $name, japName: $japName, genres: $genres, score: $score, episodes: $episodes, status: $status, year: $year, broadcastDay: $broadcastDay, imageURL: $imageURL, trailerURL: $trailerURL)';
  }

  @override
  bool operator ==(covariant Anime other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.japName == japName &&
        listEquals(other.genres, genres) &&
        other.score == score &&
        other.episodes == episodes &&
        other.status == status &&
        other.year == year &&
        other.broadcastDay == broadcastDay &&
        other.imageURL == imageURL &&
        other.trailerURL == trailerURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        japName.hashCode ^
        genres.hashCode ^
        score.hashCode ^
        episodes.hashCode ^
        status.hashCode ^
        year.hashCode ^
        broadcastDay.hashCode ^
        imageURL.hashCode ^
        trailerURL.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PreAnime {
  final String id;
  final String name;
  final List<dynamic> genres;
  final String imageURL;

  PreAnime({
    required this.id,
    required this.name,
    required this.genres,
    required this.imageURL,
  });

  PreAnime copyWith({
    String? id,
    String? name,
    List<dynamic>? genres,
    String? imageURL,
  }) {
    return PreAnime(
      id: id ?? this.id,
      name: name ?? this.name,
      genres: genres ?? this.genres,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'genres': genres,
      'imageURL': imageURL,
    };
  }

  factory PreAnime.fromMap(Map<String, dynamic> map) {
    return PreAnime(
      id: map['id'] as String,
      name: map['name'] as String,
      genres: List<dynamic>.from((map['genres'] as List<dynamic>)),
      imageURL: map['imageURL'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PreAnime.fromJson(String source) =>
      PreAnime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PreAnime(id: $id, name: $name, genres: $genres, imageURL: $imageURL)';
  }

  @override
  bool operator ==(covariant PreAnime other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.genres, genres) &&
        other.imageURL == imageURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ genres.hashCode ^ imageURL.hashCode;
  }
}

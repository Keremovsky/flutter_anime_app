// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AnimeList {
  final String name;
  final List<String> animesIDs;
  final List<String> animeNames;
  final List<String> animeImageURLs;
  final String createdDate;

  AnimeList({
    required this.name,
    required this.animesIDs,
    required this.animeNames,
    required this.animeImageURLs,
    required this.createdDate,
  });

  AnimeList copyWith({
    String? name,
    List<String>? animesIDs,
    List<String>? animeNames,
    List<String>? animeImageURLs,
    String? createdDate,
  }) {
    return AnimeList(
      name: name ?? this.name,
      animesIDs: animesIDs ?? this.animesIDs,
      animeNames: animeNames ?? this.animeNames,
      animeImageURLs: animeImageURLs ?? this.animeImageURLs,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'animesIDs': animesIDs,
      'animeNames': animeNames,
      'animeImageURLs': animeImageURLs,
      'createdDate': createdDate,
    };
  }

  factory AnimeList.fromMap(Map<String, dynamic> map) {
    return AnimeList(
      name: map['name'] as String,
      animesIDs: List<String>.from((map['animesIDs'] as List<String>)),
      animeNames: List<String>.from((map['animeNames'] as List<String>)),
      animeImageURLs:
          List<String>.from((map['animeImageURLs'] as List<String>)),
      createdDate: map['createdDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeList.fromJson(String source) =>
      AnimeList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimeList(name: $name, animesIDs: $animesIDs, animeNames: $animeNames, animeImageURLs: $animeImageURLs, createdDate: $createdDate)';
  }

  @override
  bool operator ==(covariant AnimeList other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.animesIDs, animesIDs) &&
        listEquals(other.animeNames, animeNames) &&
        listEquals(other.animeImageURLs, animeImageURLs) &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        animesIDs.hashCode ^
        animeNames.hashCode ^
        animeImageURLs.hashCode ^
        createdDate.hashCode;
  }
}

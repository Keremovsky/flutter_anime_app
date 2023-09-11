// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AnimeList {
  final String name;
  final List<String> animes;
  final String createdDate;

  AnimeList({
    required this.name,
    required this.animes,
    required this.createdDate,
  });

  AnimeList copyWith({
    String? name,
    List<String>? animes,
    String? createdDate,
  }) {
    return AnimeList(
      name: name ?? this.name,
      animes: animes ?? this.animes,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'animes': animes,
      'createdDate': createdDate,
    };
  }

  factory AnimeList.fromMap(Map<String, dynamic> map) {
    return AnimeList(
      name: map['name'] as String,
      animes: List<String>.from((map['animes'] as List<String>)),
      createdDate: map['createdDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeList.fromJson(String source) =>
      AnimeList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AnimeList(name: $name, animes: $animes, createdDate: $createdDate)';

  @override
  bool operator ==(covariant AnimeList other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.animes, animes) &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode => name.hashCode ^ animes.hashCode ^ createdDate.hashCode;
}

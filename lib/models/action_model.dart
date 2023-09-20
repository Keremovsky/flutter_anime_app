// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ActionModel {
  final String type;
  final String content;
  final Timestamp date;

  ActionModel({
    required this.type,
    required this.content,
    required this.date,
  });

  ActionModel copyWith({
    String? type,
    String? content,
    Timestamp? date,
  }) {
    return ActionModel(
      type: type ?? this.type,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'content': content,
      'date': date,
    };
  }

  factory ActionModel.fromMap(Map<String, dynamic> map) {
    return ActionModel(
      type: map['type'] as String,
      content: map['content'] as String,
      date: map['date'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionModel.fromJson(String source) =>
      ActionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ActionModel(type: $type, content: $content, date: $date)';

  @override
  bool operator ==(covariant ActionModel other) {
    if (identical(this, other)) return true;

    return other.type == type && other.content == content && other.date == date;
  }

  @override
  int get hashCode => type.hashCode ^ content.hashCode ^ date.hashCode;
}

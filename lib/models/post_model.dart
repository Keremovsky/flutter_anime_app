// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostModel {
  final String postId;
  final String postContent;
  final String postImage;
  final String postOwnerUid;
  final Timestamp postTime;
  final int postLikeCount;
  final int postCommentCount;
  final List<String> postLikeList;

  PostModel({
    required this.postId,
    required this.postContent,
    required this.postImage,
    required this.postOwnerUid,
    required this.postTime,
    required this.postLikeCount,
    required this.postCommentCount,
    required this.postLikeList,
  });

  PostModel copyWith({
    String? postId,
    String? postContent,
    String? postImage,
    String? postOwnerUid,
    Timestamp? postTime,
    int? postLikeCount,
    int? postCommentCount,
    List<String>? postLikeList,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      postContent: postContent ?? this.postContent,
      postImage: postImage ?? this.postImage,
      postOwnerUid: postOwnerUid ?? this.postOwnerUid,
      postTime: postTime ?? this.postTime,
      postLikeCount: postLikeCount ?? this.postLikeCount,
      postCommentCount: postCommentCount ?? this.postCommentCount,
      postLikeList: postLikeList ?? this.postLikeList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'postContent': postContent,
      'postImage': postImage,
      'postOwnerUid': postOwnerUid,
      'postTime': postTime,
      'postLikeCount': postLikeCount,
      'postCommentCount': postCommentCount,
      'postLikeList': postLikeList,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] as String,
      postContent: map['postContent'] as String,
      postImage: map['postImage'] as String,
      postOwnerUid: map['postOwnerUid'] as String,
      postTime: map['postTime'] as Timestamp,
      postLikeCount: map['postLikeCount'] as int,
      postCommentCount: map['postCommentCount'] as int,
      postLikeList: List<String>.from(
        (map['postLikeList'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(postId: $postId, postContent: $postContent, postImage: $postImage, postOwnerUid: $postOwnerUid, postTime: $postTime, postLikeCount: $postLikeCount, postCommentCount: $postCommentCount, postLikeList: $postLikeList)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.postContent == postContent &&
        other.postImage == postImage &&
        other.postOwnerUid == postOwnerUid &&
        other.postTime == postTime &&
        other.postLikeCount == postLikeCount &&
        other.postCommentCount == postCommentCount &&
        listEquals(other.postLikeList, postLikeList);
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        postContent.hashCode ^
        postImage.hashCode ^
        postOwnerUid.hashCode ^
        postTime.hashCode ^
        postLikeCount.hashCode ^
        postCommentCount.hashCode ^
        postLikeList.hashCode;
  }
}

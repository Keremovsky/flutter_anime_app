// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String uid;
  String username;
  String animeName;
  String email;
  String registerType;
  String profilePicURL;
  String backgroundPicURL;
  String joinDate;

  UserModel({
    required this.uid,
    required this.username,
    required this.animeName,
    required this.email,
    required this.registerType,
    required this.profilePicURL,
    required this.backgroundPicURL,
    required this.joinDate,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? animeName,
    String? email,
    String? registerType,
    String? profilePicURL,
    String? backgroundPicURl,
    String? joinDate,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      animeName: animeName ?? this.animeName,
      email: email ?? this.email,
      registerType: registerType ?? this.registerType,
      profilePicURL: profilePicURL ?? this.profilePicURL,
      backgroundPicURL: backgroundPicURl ?? this.backgroundPicURL,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'animeName': animeName,
      'email': email,
      'registerType': registerType,
      'profilePicURL': profilePicURL,
      'backgroundPicURl': backgroundPicURL,
      'joinDate': joinDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      username: map['username'] as String,
      animeName: map['animeName'] as String,
      email: map['email'] as String,
      registerType: map['registerType'] as String,
      profilePicURL: map['profilePicURL'] as String,
      backgroundPicURL: map['backgroundPicURl'] as String,
      joinDate: map['joinDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, username: $username, animeName: $animeName, email: $email, registerType: $registerType, profilePicURL: $profilePicURL, backgroundPicURl: $backgroundPicURL, joinDate: $joinDate)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.username == username &&
        other.animeName == animeName &&
        other.email == email &&
        other.registerType == registerType &&
        other.profilePicURL == profilePicURL &&
        other.backgroundPicURL == backgroundPicURL &&
        other.joinDate == joinDate;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        username.hashCode ^
        animeName.hashCode ^
        email.hashCode ^
        registerType.hashCode ^
        profilePicURL.hashCode ^
        backgroundPicURL.hashCode ^
        joinDate.hashCode;
  }
}

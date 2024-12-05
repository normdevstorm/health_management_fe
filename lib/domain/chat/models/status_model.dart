// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StatusModel {
  final String uid;
  final String username;
  final List<String> photoUrl;
  final List<DateTime> createdAt;
  final String profilePicture;
  final String statusId;
  final List<String>
      idOnAppUser; // id user who can see our status, which mean already install app
  final List<String> caption;

  const StatusModel({
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.createdAt,
    required this.profilePicture,
    required this.statusId,
    required this.idOnAppUser,
    required this.caption,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
      'createdAt': createdAt.map((e) => e.millisecondsSinceEpoch).toList(),
      'profilePicture': profilePicture,
      'statusId': statusId,
      'idOnAppUser': idOnAppUser,
      'caption': caption,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      uid: map['uid'] as String,
      username: map['username'] as String,
      photoUrl:
          (map['photoUrl'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: (map['createdAt'] as List<dynamic>)
          .map((e) => DateTime.fromMillisecondsSinceEpoch(e as int))
          .toList(),
      profilePicture: map['profilePicture'] as String,
      statusId: map['statusId'] as String,
      idOnAppUser: (map['idOnAppUser'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      caption: (map['caption'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  StatusModel copyWith({
    String? uid,
    String? username,
    List<String>? photoUrl,
    List<DateTime>? createdAt,
    String? profilePicture,
    String? statusId,
    //? idOnAppUser,
    List<String>? caption,
  }) {
    return StatusModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      profilePicture: profilePicture ?? this.profilePicture,
      statusId: statusId ?? this.statusId,
      idOnAppUser: idOnAppUser,
      caption: caption ?? this.caption,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusModel.fromJson(String source) =>
      StatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatusModel(uid: $uid, username: $username, photoUrl: $photoUrl, createdAt: $createdAt, profilePicture: $profilePicture, statusId: $statusId, idOnAppUser: $idOnAppUser, caption: $caption)';
  }

  @override
  bool operator ==(covariant StatusModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.username == username &&
        listEquals(other.photoUrl, photoUrl) &&
        other.createdAt == createdAt &&
        other.profilePicture == profilePicture &&
        other.statusId == statusId &&
        other.idOnAppUser == idOnAppUser &&
        other.caption == caption;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        username.hashCode ^
        photoUrl.hashCode ^
        createdAt.hashCode ^
        profilePicture.hashCode ^
        statusId.hashCode ^
        idOnAppUser.hashCode ^
        caption.hashCode;
  }
}

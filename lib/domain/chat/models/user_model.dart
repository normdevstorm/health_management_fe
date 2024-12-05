// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/chat/models/status_model.dart';

class UserChatModel {
  String uid;
  String userName;
  String profileImage;
  final DateTime lastSeen;
  final List<String> groupId;
  final bool isOnline;
  final Role role;
  final int? mainServiceId;
  UserChatModel({
    required this.uid,
    required this.userName,
    required this.profileImage,
    required this.lastSeen,
    required this.groupId,
    required this.isOnline,
     this.mainServiceId,
    this.role = Role.user,
  });

  UserChatModel copyWith({
    String? uid,
    String? userName,
    String? profileImage,
    DateTime? lastSeen,
    List<String>? groupId,
    StatusModel? status,
    bool? isOnline,
    List<String>? chats,
    Role? role,
    int? mainServiceId,
  }) {
    return UserChatModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      profileImage: profileImage ?? this.profileImage,
      lastSeen: lastSeen ?? this.lastSeen,
      groupId: groupId ?? this.groupId,
      isOnline: isOnline ?? this.isOnline,
      role: role ?? this.role,
      mainServiceId: mainServiceId ?? this.mainServiceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'profileImage': profileImage,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'groupId': groupId,
      'isOnline': isOnline,
      'role': role.toString().split('.').last,
      'mainServiceId': mainServiceId,};
  }

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      profileImage: map['profileImage'] as String,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen'] as int),
      groupId:
          (map['groupId'] as List<dynamic>).map((e) => e as String).toList(),
      isOnline: map['isOnline'] as bool,
      role:
          Role.values.firstWhere((e) => e.toString() == 'Role.${map['role']}'),
      mainServiceId: map['mainServiceId'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChatModel.fromJson(String source) =>
      UserChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, profileImage: $profileImage, lastSeen: $lastSeen, groupId: $groupId, isOnline: $isOnline, role: $role, mainServiceId: $mainServiceId)';
  }

  @override
  bool operator ==(covariant UserChatModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.profileImage == profileImage &&
        other.lastSeen == lastSeen &&
        listEquals(other.groupId, groupId) &&
        other.isOnline == isOnline &&
        other.role == role &&
        other.mainServiceId == mainServiceId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        profileImage.hashCode ^
        lastSeen.hashCode ^
        groupId.hashCode ^
        isOnline.hashCode ^
        role.hashCode ^
        mainServiceId.hashCode;
  }
}

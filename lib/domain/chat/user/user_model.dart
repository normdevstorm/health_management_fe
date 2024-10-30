import 'dart:convert';

class UserModel {
  String uid;
  String userName;
  String profileImage;
  final DateTime lastSeen;
  final bool isOnline;
  UserModel({
    required this.uid,
    required this.userName,
    required this.profileImage,
    required this.lastSeen,
    required this.isOnline,
  });

  UserModel copyWith(
      {String? uid,
      String? userName,
      String? profileImage,
      DateTime? lastSeen,
      bool? isOnline}) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      profileImage: profileImage ?? this.profileImage,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'profileImage': profileImage,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      profileImage: map['profileImage'] as String,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen'] as int),
      isOnline: map['isOnline'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, profileImage: $profileImage, lastSeen: $lastSeen, isOnline: $isOnline)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.profileImage == profileImage &&
        other.lastSeen == lastSeen &&
        other.isOnline == isOnline;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        profileImage.hashCode ^
        lastSeen.hashCode ^
        isOnline.hashCode;
  }
}

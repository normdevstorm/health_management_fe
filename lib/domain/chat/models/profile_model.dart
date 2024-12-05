// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatProfile {
  String uid;
  String userName;
  String email;
  String? phone;
  String? address;
  String? birthday;
  String avatar;
  String? gender;
  ChatProfile({
    required this.uid,
    required this.userName,
    required this.email,
    required this.avatar,
    this.phone,
    this.address,
    this.birthday,
    this.gender,
  });

  ChatProfile.defaultConstructor()
      : uid = '',
        userName = '',
        email = '',
        phone = null,
        address = null,
        birthday = null,
        avatar = '',
        gender = null;

  ChatProfile copyWith({
    String? uid,
    String? userName,
    String? email,
    String? phone,
    String? address,
    String? birthday,
    String? avatar,
    String? gender,
  }) {
    return ChatProfile(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'email': email,
      'phone': phone,
      'address': address,
      'birthday': birthday,
      'avatar': avatar,
      'gender': gender,
    };
  }

  factory ChatProfile.fromMap(Map<String, dynamic> map) {
    return ChatProfile(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      avatar: map['avatar'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatProfile.fromJson(String source) =>
      ChatProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(uid: $uid, userName: $userName, email: $email, phone: $phone, address: $address, birthday: $birthday, avatar: $avatar, gender: $gender)';
  }

  @override
  bool operator ==(covariant ChatProfile other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.birthday == birthday &&
        other.avatar == avatar &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        birthday.hashCode ^
        avatar.hashCode ^
        gender.hashCode;
  }
}

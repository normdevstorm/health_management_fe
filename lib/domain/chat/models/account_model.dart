// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatAccount {
  final String uid;
  final String email;
  final String password;
  ChatAccount({
    required this.uid,
    required this.email,
    required this.password,
  });
  ChatAccount.defaultConstructorMethod()
      : uid = '',
        email = '',
        password = '';

  ChatAccount copyWith({
    String? uid,
    String? email,
    String? password,
  }) {
    return ChatAccount(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'password': password,
    };
  }

  factory ChatAccount.fromMap(Map<String, dynamic> map) {
    return ChatAccount(
      uid: map['uid'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatAccount.fromJson(String source) =>
      ChatAccount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Account(uid: $uid, email: $email, password: $password)';

  @override
  bool operator ==(covariant ChatAccount other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ password.hashCode;

  static defaultConstructor() {}
}

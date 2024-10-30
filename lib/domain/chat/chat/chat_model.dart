// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Chat {
  final String name;
  final String contactId;
  final String profileUrl;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  Chat({
    required this.name,
    required this.contactId,
    required this.profileUrl,
    required this.lastMessage,
    this.lastMessageTime,
  });

  Chat copyWith({
    String? name,
    String? contactId,
    String? profileUrl,
    String? lastMessage,
    DateTime? lastMessageTime,
  }) {
    return Chat(
      name: name ?? this.name,
      contactId: contactId ?? this.contactId,
      profileUrl: profileUrl ?? this.profileUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contactId': contactId,
      'profileUrl': profileUrl,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime?.millisecondsSinceEpoch,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      name: map['name'] as String,
      contactId: map['contactId'] as String,
      profileUrl: map['profileUrl'] as String,
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,
      lastMessageTime: map['lastMessageTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(name: $name, contactId: $contactId, profileUrl: $profileUrl, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.contactId == contactId &&
        other.profileUrl == profileUrl &&
        other.lastMessage == lastMessage &&
        other.lastMessageTime == lastMessageTime;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        contactId.hashCode ^
        profileUrl.hashCode ^
        lastMessage.hashCode ^
        lastMessageTime.hashCode;
  }
}

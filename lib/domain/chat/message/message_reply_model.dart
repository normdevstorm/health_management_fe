import 'dart:convert';

import 'package:health_management/app/utils/enums/message_type.dart';

class MessageReplyModel {
  final String message;
  final bool isMe;
  final MessageType messageType;
  final String repliedTo;

  const MessageReplyModel({
    required this.message,
    required this.isMe,
    required this.messageType,
    required this.repliedTo,
  });

  MessageReplyModel copyWith({
    String? message,
    bool? isMe,
    MessageType? messageType,
    String? repliedTo,
  }) {
    return MessageReplyModel(
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      messageType: messageType ?? this.messageType,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'isMe': isMe,
      'messageType': messageType,
      'repliedTo': repliedTo,
    };
  }

  factory MessageReplyModel.fromMap(Map<String, dynamic> map) {
    return MessageReplyModel(
      message: map['message'] as String,
      isMe: map['isMe'] as bool,
      messageType: (map['messageType'] as String).toEnum(),
      repliedTo: map['repliedTo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageReplyModel.fromJson(String source) =>
      MessageReplyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageReplyModel(message: $message, isMe: $isMe, messageType: $messageType, repliedTo: $repliedTo)';
  }

  @override
  bool operator ==(covariant MessageReplyModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.isMe == isMe &&
        other.messageType == messageType &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        isMe.hashCode ^
        messageType.hashCode ^
        repliedTo.hashCode;
  }
}

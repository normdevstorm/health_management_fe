// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../app/utils/enums/message_type.dart';


class Message {
  final String messageId;
  final String content;
  final String senderId;
  final String senderName;
  final String receiverId;
  final DateTime timeSent;
  final bool isSeen;
  final MessageType messageType;
  //reply message
  final MessageType repliedMessageType;
  final String repliedMessage;
  final String repliedTo;
  Message({
    required this.messageId,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.timeSent,
    required this.isSeen,
    required this.messageType,
    required this.repliedMessageType,
    required this.repliedMessage,
    required this.repliedTo,
  });

  Message copyWith({
    String? messageId,
    String? content,
    String? senderId,
    String? senderName,
    String? receiverId,
    DateTime? timeSent,
    bool? isRead,
    MessageType? messageType,
    MessageType? replyMessageType,
    String? replyMessage,
    String? replyTo,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      timeSent: timeSent ?? this.timeSent,
      isSeen: isRead ?? this.isSeen,
      messageType: messageType ?? this.messageType,
      repliedMessageType: replyMessageType ?? repliedMessageType,
      repliedMessage: replyMessage ?? repliedMessage,
      repliedTo: replyTo ?? repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'messageType': messageType.type,
      'replyMessageType': repliedMessageType.type,
      'replyMessage': repliedMessage,
      'replyTo': repliedTo,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      content: map['content'] as String,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      receiverId: map['receiverId'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      isSeen: map['isSeen'] as bool,
      messageType: (map['messageType'] as String).toEnum(),
      repliedMessageType: (map['replyMessageType'] as String).toEnum(),
      repliedMessage: map['replyMessage'] as String,
      repliedTo: map['replyTo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(messageId: $messageId, content: $content, senderId: $senderId, senderName: $senderName, receiverId: $receiverId, timeSent: $timeSent, isRead: $isSeen, messageType: $messageType, replyMessageType: $repliedMessageType, replyMessage: $repliedMessage, replyTo: $repliedTo)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId &&
        other.content == content &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.receiverId == receiverId &&
        other.timeSent == timeSent &&
        other.isSeen == isSeen &&
        other.messageType == messageType &&
        other.repliedMessageType == repliedMessageType &&
        other.repliedMessage == repliedMessage &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        content.hashCode ^
        senderId.hashCode ^
        senderName.hashCode ^
        receiverId.hashCode ^
        timeSent.hashCode ^
        isSeen.hashCode ^
        messageType.hashCode ^
        repliedMessageType.hashCode ^
        repliedMessage.hashCode ^
        repliedTo.hashCode;
  }
}

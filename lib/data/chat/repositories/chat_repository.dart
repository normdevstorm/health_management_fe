import 'dart:io';

import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:health_management/domain/chat/models/message_reply_model.dart';
import 'package:either_dart/either.dart';

abstract class ChatRepository {
  Stream<List<Message>> getChatStream(String receiverId);

  Stream<List<Message>> getGroupChatStream(String groupId);

  Future<Either<Failure, void>> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<Either<Failure, void>> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<Either<Failure, void>> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<Either<Failure, void>> setMessageSeen(
      String receiverId, String messageId);
}

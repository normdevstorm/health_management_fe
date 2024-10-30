import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/message/message_model.dart';
import 'package:health_management/domain/chat/message/message_reply_model.dart';

abstract class ChatDetailRepository {
  Stream<List<Message>> getChatStream(String receiverId);

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

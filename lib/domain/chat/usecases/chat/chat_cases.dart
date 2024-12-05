// ignore: implementation_imports
import 'dart:io';

import 'package:either_dart/src/either.dart';

import '../../../../app/utils/enums/message_type.dart';
import '../../../../app/utils/errors/exception.dart';
import '../../../../app/utils/errors/failure.dart';
import '../../../../data/chat/repositories/chat_repository.dart';
import '../../models/message_model.dart';
import '../../models/message_reply_model.dart';

class ChatUseCase implements ChatRepository {
  final ChatRepository _repository;

  ChatUseCase(this._repository);

  @override
  Stream<List<Message>> getChatStream(String receiverId) {
    if (receiverId.isEmpty) {
      throw FirebaseDatabaseException('getChatStream: receiverId is empty');
    } else {
      return _repository.getChatStream(receiverId);
    }
  }

  @override
  Stream<List<Message>> getGroupChatStream(String groupId) {
    if (groupId.isEmpty) {
      throw FirebaseDatabaseException('getGroupChatStream: groupId is empty');
    } else {
      return _repository.getGroupChatStream(groupId);
    }
  }

  @override
  Future<Either<Failure, void>> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) {
    if (file.path.isEmpty || receiverId.isEmpty) {
      throw FirebaseDatabaseException(
          'sendFileMessage: file or receiverId is empty');
    } else {
      return _repository.sendFileMessage(
          file: file,
          receiverId: receiverId,
          messageType: messageType,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
    }
  }

  @override
  Future<Either<Failure, void>> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) {
    if (gifUrl.isEmpty || receiverId.isEmpty) {
      throw FirebaseDatabaseException(
          'sendGIFMessage: gifUrl or receiverId is empty');
    } else {
      return _repository.sendGIFMessage(
          gifUrl: gifUrl,
          receiverId: receiverId,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) {
    if (text.isEmpty || receiverId.isEmpty) {
      throw FirebaseDatabaseException(
          'sendTextMessage: text or receiverId is empty');
    } else {
      return _repository.sendTextMessage(
          text: text,
          receiverId: receiverId,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
    }
  }

  @override
  Future<Either<Failure, void>> setMessageSeen(
      String receiverId, String messageId) {
    if (receiverId.isEmpty || messageId.isEmpty) {
      throw FirebaseDatabaseException(
          'setMessageSeen: receiverId or messageId is empty');
    } else {
      return _repository.setMessageSeen(receiverId, messageId);
    }
  }
}

import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/data/chat/datasource/chat_detail_datasource.dart';
import 'package:health_management/domain/chat/chat_detail/chat_detail_repository.dart';
import 'package:health_management/domain/chat/message/message_model.dart';
import 'package:health_management/domain/chat/message/message_reply_model.dart';

class ChatDetailRepositoryImpl implements ChatDetailRepository {
  final ChatDetailDataSource _chatRemoteDataSource;
  ChatDetailRepositoryImpl(this._chatRemoteDataSource);
  @override
  Stream<List<Message>> getChatStream(String receiverId) {
    return _chatRemoteDataSource.getChatStream(receiverId);
  }

  @override
  Future<Either<Failure, void>> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      final result = await _chatRemoteDataSource.sendFileMessage(
          file: file,
          receiverId: receiverId,
          messageType: messageType,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      final result = await _chatRemoteDataSource.sendGIFMessage(
          gifUrl: gifUrl,
          receiverId: receiverId,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      final result = await _chatRemoteDataSource.sendTextMessage(
          text: text,
          receiverId: receiverId,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setMessageSeen(
      String receiverId, String messageId) async {
    try {
      final result =
          await _chatRemoteDataSource.setMessageSeen(receiverId, messageId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

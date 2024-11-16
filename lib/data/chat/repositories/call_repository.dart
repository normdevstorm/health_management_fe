import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/models/call_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

abstract class CallRepository {
  Stream<CallModel> get callStream;

  Stream<List<CallModel>> getCallHistory();

  Future<Either<Failure, void>> makeCall(BuildContext context,
      {required String receiverId,
      required String receiverName,
      required String receiverPic});

  Future<void> endCall({required String callerId, required String receiverId});
}

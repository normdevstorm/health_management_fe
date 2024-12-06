
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../../../app/utils/errors/exception.dart';
import '../../../app/utils/errors/failure.dart';
import '../../../data/chat/datasources/call/call_remote_data_source.dart';
import '../../../data/chat/repositories/call_repository.dart';
import '../models/call_model.dart';

class CallRepositoryImpl extends CallRepository {
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl(this.remoteDataSource);

  @override
  Stream<CallModel> get callStream => remoteDataSource.callStream;

  @override
  Stream<List<CallModel>> getCallHistory() => remoteDataSource.getCallHistory();

  @override
  Future<Either<Failure, void>> makeCall(BuildContext context,
      {required String receiverId,
      required String receiverName,
      required String receiverPic}) async {
    try {
      final result = await remoteDataSource.makeCall(context,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<void> endCall({required String callerId, required String receiverId}) {
    return remoteDataSource.endCall(callerId: callerId, receiverId: receiverId);
  }
}

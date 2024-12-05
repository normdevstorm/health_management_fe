
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../../app/utils/errors/failure.dart';
import '../../../../data/chat/repositories/call_repository.dart';
import '../../models/call_model.dart';

class CallUseCase extends CallRepository {
  final CallRepository _callRepository;

  CallUseCase(this._callRepository);

  @override
  Stream<CallModel> get callStream => _callRepository.callStream;

  @override
  Future<void> endCall({required String callerId, required String receiverId}) {
      return _callRepository.endCall(
          callerId: callerId, receiverId: receiverId);
  }
  @override
  Stream<List<CallModel>> getCallHistory() => _callRepository.getCallHistory();

  @override
  Future<Either<Failure, void>> makeCall(BuildContext context,
      {required String receiverId,
      required String receiverName,
      required String receiverPic}) {

      return _callRepository.makeCall(context,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic);
  }
}

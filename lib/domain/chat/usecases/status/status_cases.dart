import 'dart:io';

// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

import '../../../../app/utils/errors/exception.dart';
import '../../../../app/utils/errors/failure.dart';
import '../../../../data/chat/repositories/status_repository.dart';
import '../../models/status_model.dart';

class StatusUseCases implements StatusRepository {
  final StatusRepository _statusRepository;

  StatusUseCases(this._statusRepository);

  @override
  Future<Either<Failure, void>> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) {
    if (username.isEmpty ||
        profilePicture.isEmpty ||
        statusImage.path.isEmpty ||
        caption.isEmpty) {
      throw FirebaseDatabaseException('uploadStatus: some parameter is empty');
    } else {
      return _statusRepository.uploadStatus(
          username: username,
          profilePicture: profilePicture,
          statusImage: statusImage,
          uidOnAppContact: uidOnAppContact,
          caption: caption);
    }
  }

  @override
  Stream<List<StatusModel>> getStatus() {
    return _statusRepository.getStatus();
  }
}

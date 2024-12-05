import 'dart:io';

// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

import '../../../app/utils/errors/failure.dart';
import '../../../data/chat/datasources/status/status_data_source.dart';
import '../../../data/chat/repositories/status_repository.dart';
import '../models/status_model.dart';

class StatusRepositoryImpl implements StatusRepository {
  final StatusRemoteDataSource _statusRemoteDataSource;
  StatusRepositoryImpl(this._statusRemoteDataSource);

  @override
  Stream<List<StatusModel>> getStatus() {
    return _statusRemoteDataSource.getStatus();
  }

  @override
  Future<Either<Failure, void>> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) async {
    try {
      final result = await _statusRemoteDataSource.uploadStatus(
          username: username,
          profilePicture: profilePicture,
          statusImage: statusImage,
          uidOnAppContact: uidOnAppContact,
          caption: caption);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

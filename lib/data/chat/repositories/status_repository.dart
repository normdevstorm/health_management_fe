import 'dart:io';

import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/models/status_model.dart';
import 'package:either_dart/either.dart';

abstract class StatusRepository {
  Future<Either<Failure, void>> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption});

  Stream<List<StatusModel>> getStatus();
}

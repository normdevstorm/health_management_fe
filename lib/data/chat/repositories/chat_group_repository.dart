import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/models/group_model.dart';

abstract class ChatGroupRepository {
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact);
  Stream<List<GroupModel>> getChatGroups();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

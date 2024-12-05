import 'dart:io';


import 'package:either_dart/either.dart';

import '../../../app/utils/errors/exception.dart';
import '../../../app/utils/errors/failure.dart';
import '../../../data/chat/datasources/groups/groups_remote_data_source.dart';
import '../../../data/chat/repositories/chat_group_repository.dart';
import '../models/group_model.dart';

class ChatGroupRepositoryImpl implements ChatGroupRepository {
  final GroupsRemoteDataSource _chatGroupDataSource;
  ChatGroupRepositoryImpl(this._chatGroupDataSource);

  @override
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact) async {
    try {
      final result = await _chatGroupDataSource.createGroup(
          name, profilePicture, selectedUidContact);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Stream<List<GroupModel>> getChatGroups() {
    return _chatGroupDataSource.getChatGroups();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _chatGroupDataSource.getNumOfMessageNotSeen(senderId);
  }
}

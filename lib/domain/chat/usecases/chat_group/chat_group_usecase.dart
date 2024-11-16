
import 'dart:io';

import 'package:either_dart/either.dart';

import '../../../../app/utils/errors/failure.dart';
import '../../../../data/chat/repositories/chat_group_repository.dart';
import '../../models/group_model.dart';

class ChatGroupUseCase implements ChatGroupRepository {
  final ChatGroupRepository _chatGroupRepository;
  ChatGroupUseCase(this._chatGroupRepository);

  @override
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact) {
    if (name.isEmpty || selectedUidContact.isEmpty) {
      throw Exception('Please fill all the fields');
    } else {
      return _chatGroupRepository.createGroup(
          name, profilePicture, selectedUidContact);
    }
  }

  @override
  Stream<List<GroupModel>> getChatGroups() {
    return _chatGroupRepository.getChatGroups();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    if (senderId.isEmpty) {
      throw Exception('Please fill all the fields');
    } else {
      return _chatGroupRepository.getNumOfMessageNotSeen(senderId);
    }
  }
}

import '../../../../app/utils/errors/exception.dart';
import '../../../../data/chat/repositories/chat_contact_repository.dart';
import '../../models/chat_model.dart';

class ChatContactsUseCase implements ChatContactRepository {
  final ChatContactRepository _repository;

  ChatContactsUseCase(this._repository);

  @override
  Stream<List<Chat>> getChatContacts() {
    return _repository.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    if (senderId.isEmpty) {
      throw FirebaseDatabaseException(
          'getNumOfMessageNotSeen: senderId is empty');
    } else {
      return _repository.getNumOfMessageNotSeen(senderId);
    }
  }
}

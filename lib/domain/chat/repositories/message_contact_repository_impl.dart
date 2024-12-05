

import '../../../data/chat/datasources/chat_contacts/chat_contacts.dart';
import '../../../data/chat/repositories/chat_contact_repository.dart';
import '../models/chat_model.dart';

class MessageContactRepositoryImpl implements ChatContactRepository {
  final ChatContactsRemoteDataSource _messageContactDataSource;

  MessageContactRepositoryImpl(this._messageContactDataSource);

  @override
  Stream<List<Chat>> getChatContacts() {
    return _messageContactDataSource.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _messageContactDataSource.getNumOfMessageNotSeen(senderId);
  }
}

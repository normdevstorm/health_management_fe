import 'package:health_management/data/chat/datasource/chat_datasource.dart';
import 'package:health_management/domain/chat/chat/chat_model.dart';
import 'package:health_management/domain/chat/chat/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _messageContactDataSource;

  ChatRepositoryImpl(this._messageContactDataSource);

  @override
  Stream<List<Chat>> getChats() {
    return _messageContactDataSource.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _messageContactDataSource.getNumOfMessageNotSeen(senderId);
  }
}

import 'package:health_management/domain/chat/models/chat_model.dart';

abstract class ChatContactRepository {
  Stream<List<Chat>> getChatContacts();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

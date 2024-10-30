import 'package:health_management/domain/chat/chat/chat_model.dart';

abstract class ChatRepository {
  Stream<List<Chat>> getChats();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/chat/models/chat_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';

import '../../../../../domain/chat/models/message_reply_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  MessageReplyModel? messageReplay;
  bool isPressed = false;
  int selectedMessageIndex = -1;
  final usecase = getIt.call<AppChatUseCases>;
  ChatCubit() : super(ChatInitialState());

  Stream<List<Chat>> getAllChatContacts() {
    return usecase().chatContacts.getChatContacts();
  }

  Stream<int> getNumberOfUnreadMessages(String senderId) {
    return usecase().chatContacts.getNumOfMessageNotSeen(senderId);
  }

  /* Future<void> deleteChat(String senderId, String receiverId) async {
    emit(ChatLoadingState());

    try {
      await usecase().chat.deleteChat(senderId, receiverId);
      emit(ChatDeletedSuccess());
    } catch (error) {
      emit(ChatError(message: error.toString()));
    }
  } */
}

import 'package:health_management/domain/chat/usecases/user/user_cases.dart';

import 'auth/auth_cases.dart';
import 'call/call_usecase.dart';
import 'chat/chat_cases.dart';
import 'chat_contacts/message_contact_cases.dart';
import 'chat_group/chat_group_usecase.dart';
import 'contacts/contacts_use_case.dart';
import 'status/status_cases.dart';

class AppChatUseCases {
  final ChatUseCase chat;
  final UserChatUseCase user;
  final AuthUseCase auth;
  final StatusUseCases status;
  final ChatContactsUseCase chatContacts;
  final ContactsUseCase contacts;
  final ChatGroupUseCase chatGroup;
  final CallUseCase call;
  AppChatUseCases({
    required this.chat,
    required this.user,
    required this.auth,
    required this.status,
    required this.chatContacts,
    required this.contacts,
    required this.chatGroup,
    required this.call,
  });
}

import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/chat_contacts/chat_contacts_list.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/contacts/contacts.dart';
import 'package:health_management/presentation/chat/widgets/custom_separator.dart';

class ChatHomePage extends StatelessWidget {
  static const String routeName = 'home';

  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        ContactsList(),
        CustomSeparator(
            color: Colors.grey, height: 8, width: 40, borderRadius: 3),
        ChatContactList(),
      ],
    );
  }
}

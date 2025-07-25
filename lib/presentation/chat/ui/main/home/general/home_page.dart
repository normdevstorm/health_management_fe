import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/presentation/chat/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/chat_contacts/chat_contacts_list.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/contacts/contacts.dart';
import 'package:health_management/presentation/chat/widgets/custom_separator.dart';

import '../../../../bloc/contacts/contacts_cubit.dart';

class ChatHomePage extends StatefulWidget {
  static const String routeName = 'home';

  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<ContactsCubit>(context).getAllContacts();
        await BlocProvider.of<ChatCubit>(context).getAllChatContacts();
        setState(() {});
        return Future.value();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          ContactsList(),
          CustomSeparator(
              color: Colors.grey, height: 8, width: 40, borderRadius: 3),
          ChatContactList(),
        ],
      ),
    );
  }
}

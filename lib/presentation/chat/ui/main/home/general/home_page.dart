import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/bar/home_bar.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/chat_contacts/chat_contacts_list.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/chat_group/chat_group_list.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/contacts/contacts.dart';
import 'package:health_management/presentation/chat/widgets/custom_separator.dart';

import 'find_select_contact/search_bar_contact.dart';

class HomePages extends StatelessWidget {
  static const String routeName = 'home';

  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        SearchBarContact(),
        ContactsList(),
        CustomSeparator(
            color: Colors.grey, height: 8, width: 40, borderRadius: 3),
        ChatContactList(),
        // ChatGroupList()
      ],
    );
  }
}

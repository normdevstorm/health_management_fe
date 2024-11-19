import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/chat/models/chat_model.dart';
import 'package:health_management/presentation/chat/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/chat_page.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/chat_contacts/chat_contacts_item.dart';

class ChatContactList extends StatelessWidget {
  const ChatContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chat>>(
      stream: context.read<ChatCubit>().getAllChatContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data != null) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print('chat contact list snapshot.data: ${snapshot.data}');
                print('count: ${snapshot.data!.length}');
                var chatContactData = snapshot.data![index];
                return GestureDetector(
                    onTap: () {
                      context.pushNamed(RouteDefine.chatDetails,
                          extra: ChatPage(
                            name: chatContactData.name,
                            receiverId: chatContactData.contactId,
                            profilePicture: chatContactData.profileUrl,
                            isGroupChat: false,
                          ),
                          pathParameters: {'userId': chatContactData.name});
                      //update unread message to 0
                      // context.push();
                    },
                    child: ChatContactsCard(chat: chatContactData));
              },
            );
          } else {
            return const Center(
              child: Text('No contacts'),
            );
          }
        }
      },
    );
  }
}

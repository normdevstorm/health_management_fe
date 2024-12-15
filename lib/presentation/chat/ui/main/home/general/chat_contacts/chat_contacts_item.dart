import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/domain/chat/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/presentation/chat/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/chat_page.dart';
import 'package:health_management/presentation/chat/widgets/chat_item.dart';

class ChatContactsCard extends StatelessWidget {
  final Chat chat;
  const ChatContactsCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream:
          context.read<ChatCubit>().getNumberOfUnreadMessages(chat.contactId),
      builder: (context, snapshot) {
        return CustomListTile(
          onTap: () {
            context.pushNamed(RouteDefine.chatDetails,
                extra: ChatPageData(
                  name: chat.name,
                  receiverId: chat.contactId,
                  profilePicture: chat.profileUrl,
                  isGroupChat: false,
                ),
                pathParameters: {'userId': chat.name});
            //update unread message to 0
            // context.push();
          },
          roleTag: chat.role == Role.doctor ? "Doctor" : "Patient",
          leading: Hero(
            tag: chat.name.split('@').first,
            child: InkWell(
                // onTap: () => showContactProfileDialog(context,chatContactData),
                child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(chat.profileUrl),
            )),
          ),
          title: chat.name.split('@').first,
          subTitle: chat.lastMessage,
          time: chat.lastMessageTime!.getChatContactTime,
          numOfMessageNotSeen: snapshot.data ?? 0,
        );
      },
    );
  }
}

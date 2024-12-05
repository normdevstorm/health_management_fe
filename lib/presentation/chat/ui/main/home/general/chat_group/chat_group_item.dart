// ignore_for_file: avoid_print

import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/domain/chat/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/chat_page.dart';
import 'package:health_management/presentation/chat/widgets/chat_item.dart';
import 'package:health_management/presentation/chat/widgets/custom_avatar.dart';

class ChatGroupCard extends StatelessWidget {
  final GroupModel group;
  const ChatGroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        context.pushNamed(RouteDefine.chatDetails,
            extra: ChatPage(
              name: group.name,
              receiverId: group.groupId,
              profilePicture: group.groupProfilePic,
              isGroupChat: false,
            ),
            pathParameters: {'userId': group.name});
        //update unread message to 0
        // context.push();
      },
      leading: Hero(
        tag: group.name,
        child: InkWell(
            onTap: () => //show something when the image is clicked
                print('show something when the image is clicked'),
            child: CustomImage(
              imageUrl: group.groupProfilePic,
              radius: 30,
            )),
      ),
      title: group.name,
      subTitle: group.lastMessage,
      time: group.timeSent.getChatContactTime,
    );
  }
}

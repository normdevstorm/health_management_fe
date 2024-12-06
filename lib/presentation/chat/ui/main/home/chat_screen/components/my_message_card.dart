
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/reply_message_card.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/message_content_type.dart';
import 'package:swipe_to/swipe_to.dart';

class MyMessageCard extends StatelessWidget {
  final Message message;
  final int index;

  const MyMessageCard({super.key, required this.message, required this.index});

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        context.watch<InChatCubit>().selectedMessageIndex == index;
    //check repliedMessage is not empty
    final isReplying = message.repliedMessage.isNotEmpty;

    return SwipeTo(
      onRightSwipe: (details) {
        context.read<InChatCubit>().onMessageSwipe(
            message: message.content,
            isMe: true,
            messageType: message.messageType,
            repliedTo: message.senderName);
      },
      child: GestureDetector(
        onLongPress: () =>
            context.read<InChatCubit>().updateIsPressed(index, message),
        onTap: () => context.read<InChatCubit>().clearSelectedIndex(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width(0.8),
                  minWidth: 120,
                  maxHeight: double.infinity,
                ),
                child: Card(
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.zero),
                  ),
                  color: isSelected
                      ? AppColor.blue
                      : AppColor.blue.withOpacity(0.5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // if repliedMessage is not empty show MessageReplyCard
                      if (isReplying)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ReplyMessageCard(
                            isMe: message.repliedTo == message.senderName,
                            repliedTo: message.repliedTo,
                            text: message.repliedMessage,
                            repliedMessageType: message.repliedMessageType,
                          ),
                        ),
                      MessageContentType(messageData: message, isSender: true),
                    ],
                  ),
                ),
              ),
            ),
            if (isSelected) // Add a shadow or stacked container when selected
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.blue.withOpacity(0.5),
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

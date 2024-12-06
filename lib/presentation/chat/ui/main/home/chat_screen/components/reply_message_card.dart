import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';

class ReplyMessageCard extends StatelessWidget {
  final bool showCloseButton;
  final bool isMe;
  final String repliedTo;
  final String text;
  final MessageType repliedMessageType;

  const ReplyMessageCard(
      {super.key,
      this.showCloseButton = false,
      required this.isMe,
      required this.repliedTo,
      required this.text,
      required this.repliedMessageType});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white38,
            border: Border(
              left: BorderSide(
                  width: 5,
                  color:
                      isMe ? Colors.purpleAccent : AppColor.accentColorLight),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header reply message
            Row(
              children: [
                Expanded(
                  child: Text(
                    isMe ? "You" : repliedTo,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? AppColor.blue.withOpacity(0.5)
                            : AppColor.blue),
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () => context.read<InChatCubit>().cancelReplay(),
                    child: Icon(
                      Icons.clear,
                      size: 16,
                      color: AppColor.black,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            MessageReplyContent(
                repliedMessageType: repliedMessageType, text: text)
          ],
        ),
      ),
    );
  }
}

class MessageReplyContent extends StatelessWidget {
  final MessageType repliedMessageType;
  final String text;

  const MessageReplyContent(
      {super.key, required this.repliedMessageType, required this.text});

  @override
  Widget build(BuildContext context) {
    switch (repliedMessageType) {
      case MessageType.text:
        return Text(
          text,
          style: const TextStyle(color: Colors.black38, fontSize: 14),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
      case MessageType.image:
        return const Row(
          children: [
            Icon(Icons.image, color: Colors.black38),
            SizedBox(width: 4),
            Text(
              'Photo',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.gif:
        return const Row(
          children: [
            Icon(Icons.gif),
            Text(
              'GIF',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.video:
        return const Row(
          children: [
            Icon(Icons.videocam),
            Text(
              'Video',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.audio:
        return const Row(
          children: [
            Icon(
              Icons.mic,
              size: 18,
              color: Colors.black38,
            ),
            Text(
              'Voice message',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      default:
        return Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
    }
  }
}

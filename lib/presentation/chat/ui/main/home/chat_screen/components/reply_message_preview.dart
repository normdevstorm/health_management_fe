import 'package:health_management/domain/chat/models/message_reply_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/reply_message_card.dart';

class ReplyPreview extends StatelessWidget {
  final MessageReplyModel messageReply;
  const ReplyPreview({super.key, required this.messageReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      child: ReplyMessageCard(
          showCloseButton: true,
          repliedMessageType: messageReply.messageType,
          text: messageReply.message,
          isMe: messageReply.isMe,
          repliedTo: messageReply.repliedTo),
    );
  }
}

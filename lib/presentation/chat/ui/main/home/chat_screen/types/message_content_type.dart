import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/audio_message_widget.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/document_message_widget.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/text_message_widget.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/video_message_widget.dart';

import 'image_message_widget.dart';

class MessageContentType extends StatelessWidget {
  final Message messageData;
  final bool isSender;

  const MessageContentType(
      {super.key, required this.isSender, required this.messageData});

  @override
  Widget build(BuildContext context) {
    switch (messageData.messageType) {
      case MessageType.text:
        return TextMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.image:
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.video:
        return VideoMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.gif:
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.audio:
        return AudioMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.file:
        return DocumentMessageWidget(
            messageData: messageData, isSender: isSender);

      default:
        return TextMessageWidget(messageData: messageData, isSender: isSender);
    }
  }
}

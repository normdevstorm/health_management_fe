import 'package:cached_network_image/cached_network_image.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/previews/image_message_preview.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/time_sent_message_widget.dart';

class ImageMessageWidget extends StatelessWidget {
  final Message messageData;
  final bool isSender;

  const ImageMessageWidget(
      {super.key, required this.messageData, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ImageMessagePreview.routeName,
            arguments: messageData);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: messageData.content,
                maxHeightDiskCache: 380,
                fit: BoxFit.cover,
                // ignore: prefer_const_constructors
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: TimeSentMessageWidget(
                    isSender: isSender,
                    messageData: messageData,
                    colors: isSender ? AppColor.primaryColor : AppColor.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/previews/app_bar_message_preview.dart';
import 'package:health_management/presentation/chat/widgets/custom_loading.dart';

class ImageMessagePreview extends StatelessWidget {
  static const routeName = "image-message-preview";
  final Message messageData;

  const ImageMessagePreview({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBarMessagePreview(messageData: messageData),
        body: Center(
            child: CachedNetworkImage(
                imageUrl: messageData.content,
                width: double.infinity,
                fit: BoxFit.contain,
                placeholder: (context, url) => const CustomLoading(
                    size: 30,
                    borderColor: Colors.cyan,
                    backgroundColor: Colors.cyanAccent,
                    opacity: 0.5),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error))));
  }
}

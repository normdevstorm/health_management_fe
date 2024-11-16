import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/app/utils/functions/image_griphy_picker.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:health_management/presentation/chat/bloc/contacts/contacts_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/media/widget/preview/bottom_field_preview.dart';
import 'package:health_management/presentation/chat/ui/main/media/widget/preview/preview_app_bar_icon.dart';

import '../../../../../bloc/status/status_cubit.dart';

// ignore: must_be_immutable
class ImagePreviewPage extends StatefulWidget {
  static const routeName = "image-preview";

  String imageFilePath;
  final String? receiverId;
  final UserChatModel? userData;
  final bool isGroupChat;

  ImagePreviewPage(
      {super.key,
      required this.imageFilePath,
      this.receiverId,
      this.userData,
      required this.isGroupChat});

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final TextEditingController captionController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.file(
              File(widget.imageFilePath),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
            PreviewAppBarIcon(
              isVideoPreview: false,
              onPressCropped: () {
                cropImage(widget.imageFilePath).then((value) {
                  widget.imageFilePath = value!.path;
                  //calling set state to rebuild
                  setState(() {});
                });
              },
            ),
            Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: BottomFieldPreview(
                captionController: captionController,
                onSendButtonTaped: () {
                  if (widget.receiverId != null) {
                    context.read<InChatCubit>().sendFileMessage(
                        file: File(widget.imageFilePath),
                        receiverId: widget.receiverId!,
                        messageType: MessageType.image,
                        isGroupChat: widget.isGroupChat);
                    //to back to chat screen
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  } else {
                    List<String> contactUid = context
                        .read<ContactsCubit>()
                        .contactsUid; // to fetch user id on app for upload status

                    context.read<StatusCubit>().addStatus(
                        username: widget.userData!.userName,
                        profilePicture: widget.userData!.profileImage,
                        statusImage: File(widget.imageFilePath),
                        uidOnAppContact: contactUid,
                        caption: captionController.text.trim());
                    //to back to chat screen
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

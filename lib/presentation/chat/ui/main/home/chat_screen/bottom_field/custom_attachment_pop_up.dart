import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/app/utils/functions/image_griphy_picker.dart';
import 'package:health_management/presentation/chat/ui/main/media/camera_page.dart';
import 'package:health_management/presentation/chat/ui/main/media/widget/preview/image_preview_page.dart';
import 'package:health_management/presentation/chat/ui/main/media/widget/preview/video_preview_page.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../bloc/chat/in_chat/in_chat_cubit.dart';

class CustomAttachmentPopUp extends StatelessWidget {
  final String receiverId;
  final bool isGroupChat;

  const CustomAttachmentPopUp(
      {super.key, required this.receiverId, required this.isGroupChat});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: RotationTransition(
        turns: const AlwaysStoppedAnimation(-45 / 360),
        child: Icon(
          CupertinoIcons.paperclip,
          color: AppColor.grey,
          size: 25,
        ),
      ),
      //this allows you to specify the position of the popup menu relative to its anchor point
      offset: const Offset(0, -250),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
            enabled: false,
            onTap: () {},
            child: Wrap(
              spacing: 8,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                AttachmentCardItem(
                  name: "Document",
                  color: Colors.deepPurpleAccent,
                  icon: Icons.insert_drive_file,
                  onPress: () {
                    _selectDocument(context);
                  },
                ),
                AttachmentCardItem(
                  name: "Camera",
                  color: Colors.redAccent,
                  icon: Icons.camera_alt,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CameraPage(
                        receiverId: receiverId,
                        isGroupChat: isGroupChat,
                      );
                    }));
                  },
                ),
                AttachmentCardItem(
                  name: "Gallery",
                  color: Colors.purpleAccent,
                  icon: Icons.photo,
                  onPress: () {
                    selectImageFromGallery(context);
                  },
                ),
                AttachmentCardItem(
                    name: "Video",
                    color: Colors.blue,
                    icon: Icons.play_circle_fill,
                    onPress: () {
                      selectVideoFromGallery(context);
                    }),
                AttachmentCardItem(
                    name: "Location",
                    icon: Icons.map_outlined,
                    color: Colors.blue,
                    onPress: () {
                      _getLocation(context);
                    })
              ],
            ),
          )
        ];
      },
    );
  }

  void _selectDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx'
      ], // Chỉ cho phép chọn các loại tệp nhất định
    );

    if (result != null) {
      // Lấy đường dẫn của tệp đã chọn
      String? filePath = result.files.single.path;
      if (filePath != null) {
        // Xử lý tệp đã chọn ở đây
        if (context.mounted) {
          context.read<InChatCubit>().sendFileMessage(
              file: File(filePath),
              receiverId: receiverId,
              messageType: MessageType.file,
              isGroupChat: isGroupChat);
        }
      }
    } else {
      // Người dùng không chọn tệp
    }
  }

  // This  function that selects an image from the device's gallery,
  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFromGallery(context);
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImagePreviewPage(
        imageFilePath: image?.path ?? '',
        receiverId: receiverId,
        isGroupChat: isGroupChat,
      );
    }));
  }

  void selectVideoFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Xử lý video đã chọn ở đây
      String videoPath = pickedFile.path;
      if (videoPath.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return VideoPreviewPage(
            videoFilePath: videoPath,
            receiverId: receiverId,
            isGroupChat: isGroupChat,
          );
        }));
      }
    }
  }

  Future<String> _getLocation(BuildContext context) async {
    // Lấy vị trí hiện tại của người dùng
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permission is denied';
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Tạo URL của Google Maps dựa trên vị trí hiện tại
    String mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

    if (context.mounted) {
      context.read<InChatCubit>().sendTextMessage(
          text: mapsUrl, receiverId: receiverId, isGroupChat: isGroupChat);
    }
    return mapsUrl;
  }
}

class AttachmentCardItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onPress;

  const AttachmentCardItem(
      {super.key,
      required this.name,
      required this.icon,
      required this.color,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: IconButton(
              icon: Icon(icon),
              splashRadius: 28,
              onPressed: onPress,
              color: AppColor.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(name)
        ],
      ),
    );
  }
}

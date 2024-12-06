import 'dart:io';

import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:health_management/presentation/chat/bloc/contacts/contacts_cubit.dart';
import 'package:health_management/presentation/chat/bloc/status/status_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/media/widget/preview/preview_app_bar_icon.dart';
import 'package:video_player/video_player.dart';
import 'bottom_field_preview.dart';

class VideoPreviewPage extends StatefulWidget {
  static const routeName = "video-preview";

  final String videoFilePath;
  final String? receiverId;
  final UserChatModel? userData;
  final bool isGroupChat;

  const VideoPreviewPage(
      {super.key,
      this.receiverId,
      required this.videoFilePath,
      this.userData,
      required this.isGroupChat});

  @override
  State<VideoPreviewPage> createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late VideoPlayerController _controller;
  final TextEditingController captionController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    //_controller object is initialized with a VideoPlayerController that is created from a File object representing the video file path passed
    // as a parameter to the widget (widget.path). The initialize() method is called on the _controller object to initialize the video player,
    //and a then() callback is used to trigger a setState() call to rebuild the widget after the video is initialized,
    _controller = VideoPlayerController.file(File(widget.videoFilePath))
      ..initialize().then((value) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            buildVideoPreview(),
            const PreviewAppBarIcon(
              isVideoPreview: true,
            ),
            buildPlayPauseButton(),
            Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: BottomFieldPreview(
                captionController: captionController,
                onSendButtonTaped: () {
                  if (widget.receiverId != null) {
                    context.read<InChatCubit>().sendFileMessage(
                        file: File(widget.videoFilePath),
                        receiverId: widget.receiverId!,
                        messageType: MessageType.video,
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
                        statusImage: File(widget.videoFilePath),
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

  //The Visibility widget is used to conditionally show the video player (VideoPlayer) only if the _controller is initialized (_controller.value.isInitialized is true).
  Widget buildVideoPreview() {
    return Visibility(
      visible: _controller.value.isInitialized,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  //The playPauseButton() method acts as a play/pause button for the video. The onTap callback of the InkWell widget toggles the play/pause state of
  // the video by calling play() or pause() methods on the _controller object, and a setState() call is used to trigger a rebuild of the widget to update the UI accordingly.
  Widget buildPlayPauseButton() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black38,
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

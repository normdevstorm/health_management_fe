import 'package:cached_video_player/cached_video_player.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/previews/video_message_preview.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/time_sent_message_widget.dart';

class VideoMessageWidget extends StatefulWidget {
  final Message messageData;
  final bool isSender;

  const VideoMessageWidget(
      {super.key, required this.messageData, required this.isSender});

  @override
  State<VideoMessageWidget> createState() => _VideoMessageWidgetState();
}

class _VideoMessageWidgetState extends State<VideoMessageWidget> {
  late CachedVideoPlayerController _videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    //_controller object is initialized with a CachedVideoPlayerController that is created from a network and pass widget.messageData.text as url.
    // The initialize() method is called on the _controller object to initialize the video player, and a then() callback is used to trigger a setVolume after the video is initialized,
    _videoPlayerController =
        CachedVideoPlayerController.network(widget.messageData.content)
          ..initialize().then((value) {
            _videoPlayerController.setVolume(1);
            _videoPlayerController.addListener(() {
              if (_videoPlayerController.value.position ==
                  _videoPlayerController.value.duration) {
                // Video đã hoàn thành, quay lại điểm xuất phát
                _videoPlayerController.seekTo(Duration.zero);
              }
            });
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, VideoMessagePreview.routeName,
            arguments: widget.messageData);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                CachedVideoPlayer(_videoPlayerController),
                buildPlayPauseButton(),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: TimeSentMessageWidget(
                    messageData: widget.messageData,
                    colors:
                        widget.isSender ? AppColor.primaryColor : AppColor.grey,
                    isSender: widget.isSender,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlayPauseButton() {
    return Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          //If isPlay is true, _videoPlayerController.pause() is called to pause the video, otherwise _videoPlayerController.play() is called to play the video.
          // After that, setState() is called to update the state of the widget and toggle the value of isPlay using isPlay = !isPlay.
          if (isPlay) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
          setState(() {
            isPlay = !isPlay;
          });
        },
        icon: Icon(
          isPlay ? Icons.pause_circle : Icons.play_circle,
          size: 40,
          color: AppColor.black,
        ),
      ),
    );
  }
}

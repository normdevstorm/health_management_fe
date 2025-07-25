
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/time_sent_message_widget.dart';

class AudioMessageWidget extends StatefulWidget {
  final Message messageData;
  final bool isSender;

  const AudioMessageWidget(
      {super.key, required this.messageData, required this.isSender});

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration? newTiming;
  Duration? totalDuration;
  bool isPlaying = false;

  //initAudio is a function to initializes an AudioPlayer object for playing audio.
  void initAudio() {
    debugPrint("Audio Initialized");
    audioPlayer.play(UrlSource(widget.messageData.content));
    //// get total duration of the audio file
    audioPlayer.getDuration().then((value) {
      debugPrint(value.toString());
    });
    //this used to update the UI with the current playback position.
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        newTiming = event;
      });
    });
    //this used to update the UI with the total duration of the audio file.
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
    });
  }

  void seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAvatar(),
          GestureDetector(
            onTap: () {
              if (isPlaying) {
                audioPlayer.stop();
                setState(() {
                  isPlaying = !isPlaying; // isPlaying = false
                });
              } else {
                if (newTiming.toString() == "null") {
                  initAudio();
                } else {
                  audioPlayer.resume();
                }
                setState(() {
                  isPlaying = !isPlaying; // isPlaying = false
                });
              }
            },
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow_rounded,
              color: AppColor.grey,
              size: 40,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //The Slider widget is used to display the progress of the audio playback.
                Slider(
                  //value representing the current position of the audio.
                  value: newTiming == null
                      ? 0
                      : newTiming!.inMilliseconds.toDouble(),
                  min: 0,
                  // max representing the total duration of the audio.
                  max: totalDuration == null
                      ? 20
                      : totalDuration!.inMilliseconds.toDouble(),

                  activeColor: AppColor.primaryColor,
                  inactiveColor: Colors.black38,
                  // The onChanged callback is called when the user interacts with the slider, and it seeks the audio to the specified position using the
                  // seekAudio() method with the updated value
                  onChanged: (value) {
                    setState(() {
                      seekAudio(Duration(milliseconds: value.toInt()));
                    });
                  },
                ),

                // to show duration and time sent message
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //duration
                    Text(
                      (newTiming.toString() == "null")
                          ? "0:00"
                          : newTiming.toString().split('.').first.substring(3),
                      style: context.bodySmall?.copyWith(
                          color: widget.isSender
                              ? AppColor.primaryColor
                              : AppColor.black),
                    ),
                    TimeSentMessageWidget(
                        isSender: widget.isSender,
                        messageData: widget.messageData,
                        colors: widget.isSender
                            ? AppColor.primaryColor
                            : AppColor.grey)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColor.primaryColor,
          child: Image.asset("assets/images/default_avatar.jpg"),
        ),
        Positioned(
          right: -6,
          bottom: -3,
          child: Icon(Icons.mic, color: AppColor.black),
        )
      ],
    );
  }
}

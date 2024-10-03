import 'package:flutter/material.dart';

class ChatBlock extends StatelessWidget {
  final String message;
  final String sender;
  final bool isSentByMe;
  final Color sentMessageColor;
  final Color receivedMessageColor;
  final TextStyle messageTextStyle;
  final TextStyle senderTextStyle;

  const ChatBlock({
    Key? key,
    required this.message,
    required this.sender,
    this.isSentByMe = false,
    this.sentMessageColor = Colors.blue,
    this.receivedMessageColor = Colors.grey,
    this.messageTextStyle = const TextStyle(color: Colors.white),
    this.senderTextStyle = const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isSentByMe ? sentMessageColor : receivedMessageColor,
          borderRadius: isSentByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(16.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(0.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: senderTextStyle,
            ),
            const SizedBox(height: 5.0),
            Text(
              message,
              style: messageTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
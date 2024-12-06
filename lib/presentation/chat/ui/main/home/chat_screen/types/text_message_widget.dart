
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/time_sent_message_widget.dart';

import 'package:url_launcher/url_launcher.dart';

class TextMessageWidget extends StatelessWidget {
  final Message messageData;
  final bool isSender;
  static final RegExp _urlRegex = RegExp(
      r"(https?|ftp|file):\/\/[-A-Za-z0-9+&@#\/%?=~_|!:,.;]+[-A-Za-z0-9+&@#\/%=~_|]");

  const TextMessageWidget({
    super.key,
    required this.isSender,
    required this.messageData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleLinkTap(context),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: _buildTextSpan(context),
            ),
          ),
          TimeSentMessageWidget(
            isSender: isSender,
            messageData: messageData,
            colors: isSender ? AppColor.primaryColor : AppColor.grey,
          ),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan(BuildContext context) {
    String message = messageData.content;
    List<TextSpan> textSpans = [];
    Iterable<RegExpMatch> matches = _urlRegex.allMatches(message);
    int start = 0;

    for (RegExpMatch match in matches) {
      // Add non-link text
      if (match.start > start) {
        textSpans.add(
          TextSpan(
            text: message.substring(start, match.start),
            style: context.bodyLarge?.copyWith(
              color: isSender ? AppColor.primaryColor : AppColor.grey,
            ),
          ),
        );
      }

      // Add link text
      textSpans.add(
        TextSpan(
          text: message.substring(match.start, match.end),
          style: const TextStyle(
            color: Colors.red,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchURL(message.substring(match.start, match.end));
            },
        ),
      );

      start = match.end;
    }

    // Add remaining non-link text
    if (start < message.length) {
      textSpans.add(
        TextSpan(
          text: message.substring(start),
          style: TextStyle(
            color: isSender ? AppColor.primaryColor : AppColor.grey,
          ),
        ),
      );
    }

    return TextSpan(children: textSpans);
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleLinkTap(BuildContext context) {}
}

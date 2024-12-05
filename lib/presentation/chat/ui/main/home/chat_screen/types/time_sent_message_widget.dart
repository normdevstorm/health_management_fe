
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:flutter/material.dart';

class TimeSentMessageWidget extends StatelessWidget {
  final Message messageData;
  final Color colors;
  final bool isSender;

  const TimeSentMessageWidget({
    super.key,
    required this.messageData,
    required this.colors,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(messageData.timeSent.getTimeSentAmPmMode,
              style: context.bodySmall!.copyWith(color: colors)),
          const SizedBox(width: 5),
          if (isSender)
            Icon(
              messageData.isSeen
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              size: 20,
              color: messageData.isSeen ? AppColor.grey : AppColor.primaryColor,
            ),
        ],
      ),
    );
  }
}

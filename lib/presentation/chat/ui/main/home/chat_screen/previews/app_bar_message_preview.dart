
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:health_management/presentation/chat/widgets/pop_up.dart';

class AppBarMessagePreview extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarMessagePreview({
    super.key,
    required this.messageData,
  });

  final Message messageData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      leading: BackButton(color: AppColor.black),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            messageData.senderId,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Text(
              "${messageData.timeSent.getChatDayTime} ${messageData.timeSent.getTimeSentAmPmMode}",
              style: TextStyle(
                  fontSize: 12, color: AppColor.black.withOpacity(0.5)))
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.star_border),
          color: AppColor.black,
        ),
        IconButton(
          onPressed: () {},
          color: AppColor.black,
          icon: const Icon(CupertinoIcons.arrow_turn_up_right),
        ),
        PopUp(buttons: _buttons(context), colors: AppColor.black)
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: "Edit",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "All media",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "Show in message",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "Share",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "Save",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "See in gallery",
          onTap: () {},
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PopUpMenuItemModel extends Equatable {
  final String name;
  final VoidCallback onTap;

  const PopUpMenuItemModel({
    required this.name,
    required this.onTap,
  });

  @override
  List<Object?> get props => [name, onTap];
}

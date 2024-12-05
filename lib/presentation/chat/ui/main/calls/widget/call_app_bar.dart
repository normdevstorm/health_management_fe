import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/previews/app_bar_message_preview.dart';
import 'package:health_management/presentation/chat/widgets/pop_up.dart';

class CallAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CallAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      elevation: 2,
      centerTitle: true,
      title: Text(
        "Calls",
        style: context.titleLarge?.copyWith(color: AppColor.black),
      ),
      actions: [
        PopUp(
          buttons: _buttons(context),
          colors: AppColor.black,
        ),
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: "Clear Call Log",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "Settings",
          onTap: () {},
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

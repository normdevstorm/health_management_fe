import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/previews/app_bar_message_preview.dart';

class PopUp extends StatelessWidget {
  final List<PopUpMenuItemModel> buttons;
  final Color colors;
  const PopUp({super.key, required this.buttons, required this.colors});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: colors),
      onSelected: (value) {
        buttons[value].onTap();
      },
      itemBuilder: (context) {
        return buttons.map((value) {
          int index = buttons.indexOf(value);
          return PopupMenuItem(
            value: index,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(value.name),
            ),
          );
        }).toList();
      },
    );
  }
}

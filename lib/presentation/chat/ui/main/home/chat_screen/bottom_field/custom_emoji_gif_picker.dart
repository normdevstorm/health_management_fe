
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/presentation/chat/bloc/chat/bottom_chat/bottom_chat_cubit.dart';

class CustomEmojiGifPicker extends StatelessWidget {
  final TextEditingController messageController;
  final bool isShowSendButton;
  final VoidCallback onGifButtonTap;

  const CustomEmojiGifPicker(
      {super.key,
      required this.messageController,
      required this.isShowSendButton,
      required this.onGifButtonTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  if (!isShowSendButton) {
                    context.read<BottomChatCubit>().emojiSelectedShowButton();
                  }
                },
                onBackspacePressed: () => messageController.text.trimRight(),
                textEditingController: messageController,
                config: const Config()),
            Container(
                alignment: Alignment.bottomCenter,
                height: 40,
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: onGifButtonTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: AppColor.black)),
                    child: Icon(size: 30, Icons.gif, color: AppColor.black),
                  ),
                ))
          ],
        ));
  }
}

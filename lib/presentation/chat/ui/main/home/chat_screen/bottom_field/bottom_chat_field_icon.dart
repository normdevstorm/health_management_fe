import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/functions/image_griphy_picker.dart';
import 'package:health_management/presentation/chat/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/bottom_field/bottom_chat_field.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/bottom_field/custom_emoji_gif_picker.dart';

// ignore: must_be_immutable
class BottomChatFieldIcon extends StatelessWidget {
  final String receiverId;
  final bool isGroupChat;

 BottomChatFieldIcon(
      {super.key, required this.receiverId, required this.isGroupChat});

  final TextEditingController messageController =
      TextEditingController(text: "");
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomChatCubit, BottomChatState>(
      builder: (context, state) {
        final cubitRead = context.read<BottomChatCubit>();
        return PopScope(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  children: [
                    BottomChatField(
                      isGroupChat: isGroupChat,
                      receiverId: receiverId,
                      isShowEmoji: cubitRead.isShowEmojiContainer,
                      focusNode: focusNode,
                      messageController: messageController,
                      onTapTextField: () => cubitRead.hideEmojiContainer(),
                      toggleEmojiKeyboard: () =>
                          cubitRead.toggleEmojiKeyboard(focusNode),
                      onTextFieldValueChanged: (value) =>
                          cubitRead.showSendButton(value),
                    ),
                    if (cubitRead.isShowSendButton)
                      buildButtonSend(context, cubitRead.isShowSendButton)
                  ],
                ),
              ),

              //Offstage is being used to show or hide a CustomEmojiGifPicker widget based on the value of cubitRead.isShowEmojiContainer.
              // If isShowEmojiContainer is true, the CustomEmojiGifPicker widget will be visible, otherwise it will be hidden.
              Offstage(
                offstage: !cubitRead.isShowEmojiContainer,
                child: CustomEmojiGifPicker(
                  isShowSendButton: cubitRead.isShowSendButton,
                  messageController: messageController,
                  onGifButtonTap: () {
                    selectGif(context);
                  },
                ),
              )
            ],
        ));
      },
    );
  }

  Widget buildButtonSend(BuildContext context, bool isShowSendButton) {
    return GestureDetector(
      onTap: () {
        context.read<InChatCubit>().sendTextMessage(
            text: messageController.text.trim(),
            receiverId: receiverId,
            isGroupChat: isGroupChat);
        messageController.clear();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.blue,
        ),
        width: 50,
        height: 50,
        child: Icon(Icons.send, color: AppColor.primaryColor),
      ),
    );
  }

  void selectGif(BuildContext context) async {
    final gif = await pickGif(context);
    if (gif != null) {
      // ignore: use_build_context_synchronously
      final inChatCubit = context.read<InChatCubit>();
      inChatCubit.sendGIFMessage(
        gifUrl: gif.url!,
        receiverId: receiverId,
        isGroupChat: isGroupChat,
      );
    }
  }
}

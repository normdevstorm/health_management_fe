import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/domain/chat/models/message_reply_model.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/bottom_field/custom_attachment_pop_up.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/reply_message_preview.dart';

class BottomChatField extends StatelessWidget {
  final VoidCallback toggleEmojiKeyboard;
  final VoidCallback onTapTextField;
  final bool isShowEmoji;
  final TextEditingController messageController;
  final Function(String) onTextFieldValueChanged;
  final FocusNode focusNode;
  final String receiverId;

  final bool isGroupChat;

  const BottomChatField(
      {super.key,
      required this.onTapTextField,
      required this.messageController,
      required this.focusNode,
      required this.onTextFieldValueChanged,
      required this.isShowEmoji,
      required this.toggleEmojiKeyboard,
      required this.receiverId,
      required this.isGroupChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 85,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppColor.grey)),
      child: Column(
        children: [
          //this blocBuilder to show message reply preview
          BlocBuilder<InChatCubit, InChatState>(
            builder: (context, state) {
              MessageReplyModel? messageReply =
                  context.watch<InChatCubit>().messageReplay;
              if (messageReply == null) {
                return const SizedBox();
              }
              messageReply = messageReply.copyWith(
                  message: messageReply.message.length > 20
                      ? "${messageReply.message.substring(0, 20)}..."
                      : messageReply.message);

              return ReplyPreview(messageReply: messageReply);
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: toggleEmojiKeyboard,
                  color: AppColor.grey,
                  iconSize: 25,
                  icon: Icon(isShowEmoji
                      ? Icons.keyboard_alt_outlined
                      : Icons.emoji_emotions)),
              Flexible(
                //The ConstrainedBox widget is used to set constraints on the size of its child widget, which is a Scrollbar widget.
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                    maxWidth: double.infinity,
                    minHeight: 25,
                    maxHeight: 135,
                  ),

                  //The ConstrainedBox widget is used to set constraints on the size of its child widget, which is a Scrollbar widget.
                  child: Scrollbar(
                    child: TextField(
                      onTap: onTapTextField,
                      onChanged: onTextFieldValueChanged,
                      controller: messageController,
                      focusNode: focusNode,
                      cursorColor: AppColor.grey,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: AppColor.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              //this to attach file, image or audio
              CustomAttachmentPopUp(
                  receiverId: receiverId, isGroupChat: isGroupChat)
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/app/utils/functions/date_converter.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:health_management/presentation/chat/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/my_message_card.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/receiver_message_card.dart';
import 'package:health_management/presentation/chat/widgets/custom_loading.dart';

class MessagesList extends StatefulWidget {
  final String receiverId;
  final bool isGroupChat;

  const MessagesList(
      {super.key, required this.receiverId, required this.isGroupChat});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController messageScrollController = ScrollController();

  @override
  void dispose() {
    messageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: widget.isGroupChat
          ? context.read<InChatCubit>().getGroupChatStream(widget.receiverId)
          : context.read<InChatCubit>().getChatStream(widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CustomLoading(
                  borderColor: Colors.blueGrey,
                  backgroundColor: Colors.grey,
                  size: 80,
                  opacity: 0.3));
        }
        //this code is used to automatically scroll to the bottom of a scrollable widget, after the widget has finished rendering its content.
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageScrollController.animateTo(
            messageScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });

        return ListView.builder(
          controller: messageScrollController,
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) {
            var messageData = snapshot.data![index];
            print("Message Data: $messageData");

            //set chat message seen
            // if message not seen and receiver not equal the update seen to true because we already in listview or open the chat
            if (!messageData.isSeen &&
                widget.receiverId != messageData.receiverId) {
              context
                  .read<InChatCubit>()
                  .setMessageSeen(widget.receiverId, messageData.messageId);
            }
            return Column(
              children: [
                //If the message is the first one in the list or if it was sent on a different day than the previous message, a TagChatTime widget should be displayed.
                if (index == 0 ||
                    !DateChatConverter.getIsSameDay(messageData.timeSent,
                        snapshot.data![index - 1].timeSent))
                  TagChatTime(dateTime: messageData.timeSent),
                if (messageData.receiverId == widget.receiverId)
                  MyMessageCard(message: messageData, index: index),

                if (messageData.receiverId != widget.receiverId)
                  ReceiverMessageCard(message: messageData, index: index)
              ],
            );
          },
        );
      },
    );
  }
}

class TagChatTime extends StatelessWidget {
  final DateTime dateTime;

  const TagChatTime({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.black12),
        child: Text(
          dateTime.getChatDayTime,
          style: context.titleSmall?.copyWith(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}

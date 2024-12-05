
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/domain/chat/models/group_model.dart';
import 'package:health_management/presentation/chat/bloc/chat/chat_groups/chat_group_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/chat_group/chat_group_item.dart';

class ChatGroupList extends StatelessWidget {
  const ChatGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GroupModel>>(
      stream: context.read<ChatGroupCubit>().getChatGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data != null) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: 100, top: 10, left: 2, right: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var groupData = snapshot.data![index];
                return ChatGroupCard(group: groupData);
              },
            );
          } else {
            return const Center(
              child: Text('No groups'),
            );
          }
        }
      },
    );
  }
}

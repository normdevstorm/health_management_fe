import 'package:health_management/domain/chat/models/status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/presentation/chat/ui/main/status/components/story_item.dart';

import '../../../../bloc/user/user_cubit.dart';

class StatusList extends StatelessWidget {
  final List<StatusModel> status;

  const StatusList({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    //put my status first
    status.sort((a, b) {
      if (a.uid == context.read<UserCubit>().userModel!.uid) {
        return -1;
      } else {
        return 1;
      }
    });
    return GridView.count(
      crossAxisCount: 2, // Số cột
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: status.map((status) {
        final isMyStatus =
            context.read<UserCubit>().userModel!.uid == status.uid;
        return StoryListItem(
          status: status,
          username: status.username,
          isMyStatus: isMyStatus,
        );
      }).toList(),
    );
  }
}

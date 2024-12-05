import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/presentation/chat/bloc/user/user_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/profile_settings/my_profile_page.dart';

class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        UserChatModel? user = context.read<UserCubit>().userModel;
        if (user != null) {
          return AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Messages",
              style: context.titleLarge?.copyWith(color: Colors.black),
            ),
            leadingWidth: 54,
            leading: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName,
                        arguments: user.uid);
                  },
                  child: Hero(
                      tag: user.uid,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage),
                          radius: 20)),
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.black),
                onPressed: () {
                  /* Navigator.pushNamed(context, CameraPage.routeName,
                      arguments: CameraPage(
                        userData: user,
                        isGroupChat: false,
                      )); */
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

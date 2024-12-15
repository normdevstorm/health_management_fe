import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/extensions/time_extension.dart';
import 'package:health_management/data/chat/datasources/others/change_background_color.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/presentation/chat/bloc/user/user_cubit.dart';

import '../../../../../bloc/call/call_cubit.dart';
import '../../../profile_settings/contact_profile_page.dart';

class ChatPageBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String receiverId;
  final String profilePicture;
  final bool isGroupChat;

  const ChatPageBar({
    super.key,
    required this.name,
    required this.receiverId,
    required this.profilePicture,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context) {
    if (isGroupChat) {
      //not available yet
    }

    return StreamBuilder<UserChatModel>(
        stream: context.read<UserCubit>().getUserById(receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppBar(
              backgroundColor: Colors.white,
              elevation: 5,
              shadowColor: Colors.grey,
              title: const Text("Loading..."),
            );
          }
          UserChatModel user = snapshot.data!;
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.grey.withOpacity(0.5),
            title: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ContactProfilePage.routeName,
                              arguments: ContactProfilePage(
                                  uid: receiverId,
                                  name: name,
                                  imageUrl: profilePicture));
                        },
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(profilePicture),
                            radius: 20),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: user.isOnline ? Colors.green : Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.split('@').first,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Text(user.isOnline ? "Online" : user.lastSeen.getLastSeen,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    //not available yet
                  },
                  icon: const Icon(Icons.local_phone_outlined,
                      color: Colors.black)),
              IconButton(
                  onPressed: () {
                    //go to video call
                    context.read<CallCubit>().makeCall(context,
                        receiverId: receiverId,
                        receiverName: name,
                        receiverPic: profilePicture,
                        isGroupChat: isGroupChat);
                  },
                  icon:
                      const Icon(Icons.videocam_outlined, color: Colors.black)),
              IconButton(
                onPressed: () => {
                  showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(20, 50, 0, 0),
                      items: [
                        PopupMenuItem(
                            value: 1,
                            onTap: () => _showBackgroundDialog(context),
                            child: const Text("Change Background")),
                      ])
                },
                icon: const Icon(Icons.more_vert_outlined, color: Colors.black),
              ),
            ],
          );
        });
  }

  void _showBackgroundDialog(BuildContext context) {
    List<List<Color>> colors = [
      [
        const Color(0xFF4158D0),
        const Color(0xFFC850C0),
        const Color(0xFFFFCC70)
      ],
      [const Color(0xFF0093E9), const Color(0xFF80D0C7)],
      [const Color(0xFF00DBDE), const Color(0xFFFC00FF)],
      [const Color(0xFFD9AFD9), const Color(0xFF97D9E1)],
    ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Background'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      saveBackground(colors[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: colors[index],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      margin: const EdgeInsets.all(8.0),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

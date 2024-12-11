// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/bottom_field/bottom_chat_field_icon.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/bottom_field/mic/recording_mic.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/chat_page_bar.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/components/message_list.dart';

import '../../../../../../app/utils/regex/regex_manager.dart';
import '../../../../bloc/others/background_chat/background_cubit.dart';

class ChatPageData {
  final String name;
  final String receiverId;
  final String profilePicture;
  final bool isGroupChat;
  const ChatPageData({
    required this.name,
    required this.receiverId,
    required this.profilePicture,
    required this.isGroupChat,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'receiverId': receiverId,
      'profilePicture': profilePicture,
      'isGroupChat': isGroupChat,
    };
  }

  factory ChatPageData.fromJson(Map<String, dynamic> json) {
    return ChatPageData(
      name: json['name'],
      receiverId: json['receiverId'],
      profilePicture: json['profilePicture'],
      isGroupChat: json['isGroupChat'],
    );
  }
}

class ChatPage extends StatefulWidget {
  // static const String routeName = 'chat_page';
  final String name;
  final String receiverId;
  final String profilePicture;
  final bool isGroupChat;
  const ChatPage({
    super.key,
    required this.name,
    required this.receiverId,
    required this.profilePicture,
    required this.isGroupChat,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'receiverId': receiverId,
      'profilePicture': profilePicture,
      'isGroupChat': isGroupChat,
    };
  }

  factory ChatPage.fromJson(Map<String, dynamic> json) {
    return ChatPage(
      name: json['name'],
      receiverId: json['receiverId'],
      profilePicture: json['profilePicture'],
      isGroupChat: json['isGroupChat'],
    );
  }

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => {
        if (GoRouter.of(context)
            .routeInformationProvider
            .value
            .uri
            .path
            .startsWith(RegexManager.hideBottomNavBarPaths))
          {AppRouting.navBarVisibleNotifier.value = false}
        else
          {AppRouting.navBarVisibleNotifier.value = true}
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ChatPageBar(
            name: widget.name,
            receiverId: widget.receiverId,
            profilePicture: widget.profilePicture,
            isGroupChat: widget.isGroupChat,
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              return true;
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                children: [
                  BlocBuilder<BackgroundCubit, BackgroundState>(
                    builder: (context, state) {
                      context.watch<BackgroundCubit>().loadBackgroundColor();
                      if (state is GetBackgroundSuccess) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: state.gradientColors,
                            ),
                          ),
                        );
                      } else if (state is InitialBackground) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: state.defaultBackground,
                            ),
                          ),
                        );
                      } else if (state is ChangeBackgroundLoading) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white],
                            ),
                          ),
                        );
                      } else if (state is BackgroundError) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white],
                            ),
                          ),
                        );
                      }
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.white],
                          ),
                        ),
                      );
                    },
                  ),
                  Column(
                    children: [
                      Expanded(
                          child: MessagesList(
                              receiverId: widget.receiverId,
                              isGroupChat: widget.isGroupChat)),
                      BottomChatFieldIcon(
                          receiverId: widget.receiverId,
                          isGroupChat: widget.isGroupChat)
                    ],
                  ),
                  RecordingMic(
                      receiverId: widget.receiverId,
                      isGroupChat: widget.isGroupChat)
                ],
              ),
            ),
          )),
    );
  }
}

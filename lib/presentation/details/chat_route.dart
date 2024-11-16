import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/chat_page.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/home_page.dart';
import '../chat/bloc/auth/auth_cubit.dart';
import '../chat/bloc/call/call_cubit.dart';
import '../chat/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import '../chat/bloc/chat/chat_contacts/chat_cubit.dart';
import '../chat/bloc/chat/chat_groups/chat_group_cubit.dart';
import '../chat/bloc/chat/in_chat/in_chat_cubit.dart';
import '../chat/bloc/contacts/contacts_cubit.dart';
import '../chat/bloc/others/background_chat/background_cubit.dart';
import '../chat/bloc/pages/page_cubit.dart';
import '../chat/bloc/profile/profile_cubit.dart';
import '../chat/bloc/status/status_cubit.dart';
import '../chat/bloc/user/user_cubit.dart';
part 'chat_route.g.dart';

@TypedShellRoute<ChatRoute>(routes: [
  TypedGoRoute<ChatHomeRoute>(
      name: RouteDefine.chatHomeRoute, path: '/chat', routes: [  TypedGoRoute<ChatPersonDetailsRoute>(
    name: RouteDefine.chatDetails,
    path: '/:userId',
  )]),
    
])
class ChatRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => StatusCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => ContactsCubit()),
        BlocProvider(create: (context) => ChatGroupCubit()),
        BlocProvider(create: (context) => InChatCubit()),
        BlocProvider(create: (context) => CallCubit()),
        BlocProvider(create: (context) => BottomChatCubit()),
        BlocProvider(create: (context) => BackgroundCubit())
      ],
      child: navigator,
    );
  }
}

class ChatHomeRoute extends GoRouteData {
  const ChatHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePages();
  }
}

class ChatPersonDetailsRoute extends GoRouteData {
  final String userId;
  const ChatPersonDetailsRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    ChatPage chatContactData = state.extra as ChatPage;
    return ChatPage(
      name: chatContactData.name,
      receiverId: chatContactData.receiverId,
      profilePicture: chatContactData.profilePicture,
      isGroupChat: false,
    );
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    ChatPage chatContactData = state.extra as ChatPage;

    return CustomTransitionPage(
      child: ChatPage(
        name: chatContactData.name,
        receiverId: chatContactData.receiverId,
        profilePicture: chatContactData.profilePicture,
        isGroupChat: false,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: true,
          child: child,
        );
      },
    );
  }
}

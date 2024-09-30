import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/prototypes/my_details_screen.dart';
part 'chat_route.g.dart';

@TypedGoRoute<ChatRoute>(
    name: RouteDefine.chatRouteName,
    path: '/chat',
    routes: [
      TypedGoRoute<PersonDetailsRoute>(
        name: RouteDefine.chatDetails,
        path: ':userId',
      )
    ])
class ChatRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MyDetailsScreen();
  }
}

class PersonDetailsRoute extends GoRouteData {
  final String userId;
  const PersonDetailsRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PersonDetailScreen(
      person: {
        'name': userId,
        'age': '30',
        'email': 'johndoe@example.com',
        'phone': '+1234567890',
      },
    );
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    // TODO: implement buildPage
    return CustomTransitionPage(
      child: PersonDetailScreen(
        person: {
          'name': userId,
          'age': '30',
          'email': 'johndoe@example.com',
          'phone': '+1234567890',
        },
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

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/main.dart';
import 'package:health_management/presentation/details/details_route.dart';
import 'package:health_management/presentation/settings/settings_route.dart';

import '../../presentation/login/login_route.dart';

enum RouteDefine {
  // group routes of the same root with a comment
  //Registration
  registerScreen,
  loginScreen,
  codeVerifyScreen,

  //Home
  home,
  //Settings
  settings,
  //Profile
  profile,
  //Appointment
  appointment,
}

///TODO: group naviagtor keys into one separate file

final GlobalKey<NavigatorState> _rootNavigatorHome =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorChat =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorAppointment =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorProfile =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _globalRootNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouting {
  static GoRouter shellRouteConfig() => _shellRoute;

  static final GoRouter _shellRoute = GoRouter(
    observers: [ChuckerFlutter.navigatorObserver],
      navigatorKey: _globalRootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                SkeletonPage(title: "Skeleton page", child: navigationShell),
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                  navigatorKey: _rootNavigatorHome,
                  routes: <RouteBase>[
                    GoRoute(
                        path: '/',
                        builder: (context, state) =>
                            const MyHomePage(title: 'Flutter Demo Home Page')),
                  ]),
              StatefulShellBranch(
                  navigatorKey: _rootNavigatorChat,
                  routes: <RouteBase>[$detailsRoute]),
              StatefulShellBranch(
                  navigatorKey: _rootNavigatorAppointment,
                  routes: <RouteBase>[$loginRoute]),
              StatefulShellBranch(
                  routes: <RouteBase>[$settingsRoute],
                  navigatorKey: _rootNavigatorProfile)
            ])
      ]);
}

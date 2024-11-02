import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/main.dart';
import 'package:health_management/presentation/details/chat_route.dart';
import 'package:health_management/presentation/auth/auth_route.dart';
import 'package:health_management/presentation/settings/settings_route.dart';
import 'package:health_management/presentation/splash/ui/splash_screen.dart';

import '../../presentation/auth/appointment_route.dart';
import 'route_define.dart';

///TODO: group naviagtor keys into one separate file

final GlobalKey<NavigatorState> _rootNavigatorHome =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorChat =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorAppointment =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorProfile =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorAuthentication =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> globalRootNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouting {
  static GoRouter shellRouteConfig() => _shellRoute;
  static final GoRouter _shellRoute = GoRouter(
      observers: [ChuckerFlutter.navigatorObserver],
      navigatorKey: globalRootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          parentNavigatorKey: globalRootNavigatorKey,
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: globalRootNavigatorKey,
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: [$loginRoute, $registerRoute],
              navigatorKey: _rootNavigatorAuthentication,
            )
          ],
          builder: (context, state, navigationShell) => navigationShell,
        ),
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                SkeletonPage(title: "Skeleton page", child: navigationShell),
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                  navigatorKey: _rootNavigatorHome,
                  routes: <RouteBase>[
                    GoRoute(
                        name: RouteDefine.home,
                        path: '/home',
                        builder: (context, state) => MyHomePage(
                              title: 'Home',
                            )),
                  ]),
              StatefulShellBranch(
                  navigatorKey: _rootNavigatorChat,
                  routes: <RouteBase>[$chatRoute]),
              StatefulShellBranch(
                  navigatorKey: _rootNavigatorAppointment,
                  routes: <RouteBase>[$appointmentRoute]),
              StatefulShellBranch(
                  routes: <RouteBase>[$settingsRoute],
                  navigatorKey: _rootNavigatorProfile)
            ])
      ]);
}

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
                        builder: (context, state) => MyHomePage(title: 'Home',)
                        // DoctorProfileDetailsScreen(
                        //     doctor: UserEntity(
                        //         id: 1,
                        //         firstName: "Norm",
                        //         lastName: "Nguyen",
                        //         doctorProfile: DoctorEntity(
                        //             id: 1,
                        //             specialization: "Doctor",
                        //             experience: 10,
                        //             qualification: "PhD",
                        //             rating: 5,
                        //             about:
                        //                 "Dr. Norm Nguyen is a highly experienced and qualified doctor with a PhD in his field. With over 10 years of experience and a perfect rating of 5, he is dedicated to providing exceptional care to his patients"))),
                        )
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

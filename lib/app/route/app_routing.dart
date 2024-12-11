import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/main.dart';
import 'package:health_management/presentation/details/chat_route.dart';
import 'package:health_management/presentation/auth/auth_route.dart';
import 'package:health_management/presentation/settings/settings_route.dart';
import 'package:health_management/presentation/splash/ui/splash_screen.dart';
import '../../presentation/auth/appointment_route.dart';
import '../../presentation/nav_bar/bloc/navigation_bar_bloc.dart';
import 'custom_navigator_observer.dart';
import 'route_define.dart';

///TODO: group naviagtor keys into one separate file
final GlobalKey<NavigatorState> rootNavigatorHome = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorChat = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorAppointment =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorProfile =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorAuthentication =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> globalRootNavigatorKey =
    GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> rootNavigatorArticles =
//     GlobalKey<NavigatorState>();

class AppRouting {
  static final ValueNotifier<bool> navBarVisibleNotifier =
      ValueNotifier<bool>(true);
  static final CustomNavigatorObserver customNavigatorObserver =
      CustomNavigatorObserver();
  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();
  static final RouteObserver<ModalRoute<void>> appointmentRouteObserver =
      RouteObserver<ModalRoute<void>>();
  static GoRouter get shellRouteConfig => _shellRoute;
  static final GoRouter _shellRoute = GoRouter(
      observers: [
        ChuckerFlutter.navigatorObserver,
        routeObserver,
        customNavigatorObserver
      ],
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
              navigatorKey: rootNavigatorAuthentication,
            )
          ],
          builder: (context, state, navigationShell) => navigationShell,
        ),
        StatefulShellRoute.indexedStack(
            restorationScopeId: 'root',
            parentNavigatorKey: globalRootNavigatorKey,
            builder: (context, state, navigationShell) => BlocProvider(
                  create: (context) => NavigationBarBloc(),
                  child: SkeletonPage(
                      title: "Skeleton page", child: navigationShell),
                ),
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                  navigatorKey: rootNavigatorHome,
                  routes: <RouteBase>[
                    GoRoute(
                        name: RouteDefine.home,
                        path: '/home',
                        builder: (context, state) => const ArticleHome(
                              title: 'Home',
                            ))
                  ]),
              StatefulShellBranch(
                  restorationScopeId: 'chatRestorationScope',
                  navigatorKey: rootNavigatorChat,
                  routes: <RouteBase>[$chatRoute]),
              StatefulShellBranch(
                  observers: [appointmentRouteObserver],
                  navigatorKey: rootNavigatorAppointment,
                  routes: <RouteBase>[$appointmentRoute]),
              StatefulShellBranch(
                  navigatorKey: rootNavigatorProfile,
                  routes: <RouteBase>[$settingsRoute])
            ])
      ]);
}

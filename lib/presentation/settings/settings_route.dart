import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/articles/ui/article_screen.dart';
import 'package:health_management/presentation/settings/ui/screen/settings_screen.dart';

part 'settings_route.g.dart';

@TypedShellRoute<SettingRoute>(
  routes: [
    TypedGoRoute<SettingHomeRoute>(
      path: "/settings/home",
      name: RouteDefine.settings,
      routes: [
        // TypedGoRoute<SettingDataProfileRoute>(
        //   path: "/profile",
        //   name: RouteDefine.profile,
        // ),
        TypedGoRoute<SettingArticleRoute>(
          path: "/article",
          name: RouteDefine.article,
        ),
      ],
    ),
  ],
)
class SettingRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return navigator;
  }
}

class SettingHomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsScreen();
  }
}

// class SettingDataProfileRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return DataProfileScreen();
//   }
// }

class SettingArticleRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArticleScreen();
  }
}

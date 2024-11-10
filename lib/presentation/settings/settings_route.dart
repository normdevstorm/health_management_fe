import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/settings/ui/screen/settings_screen.dart';
part 'settings_route.g.dart';

@TypedGoRoute<SettingsRoute>(name: RouteDefine.settings, path: '/settings')
class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

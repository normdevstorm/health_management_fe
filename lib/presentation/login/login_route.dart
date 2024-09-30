
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/presentation/prototypes/my_overview_screen.dart';
part 'login_route.g.dart';

@TypedGoRoute<LoginRoute>(path: '/appointment')
class LoginRoute extends GoRouteData{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // TODO: wrap with bloc later on
    return const MyOverviewScreen() ;
  }
}
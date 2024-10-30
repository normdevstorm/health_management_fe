import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/prototypes/my_overview_screen.dart';
part 'appointment_route.g.dart';

@TypedGoRoute<AppointmentRoute>(
    name: RouteDefine.appointment, path: '/appointment')
class AppointmentRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // TODO: wrap with bloc later on
    return const MyOverviewScreen();
  }
}

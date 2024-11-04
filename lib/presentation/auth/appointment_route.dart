import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/appointment/bloc/appointment_bloc.dart';
import 'package:health_management/presentation/appointment/ui/screens/appointment_home.dart';
part 'appointment_route.g.dart';

@TypedGoRoute<AppointmentRoute>(
    name: RouteDefine.appointment, path: '/appointment')
class AppointmentRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // TODO: wrap with bloc later on
    return BlocProvider(
      create: (context) => AppointmentBloc(appointmentUseCase: getIt())..add(GetAllAppointmentRecordEvent()), 
      child:  AppointmentHome(),
    );
  }
}

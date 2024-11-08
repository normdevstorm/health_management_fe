import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/appointment/bloc/health_provider/health_provider_bloc.dart';
import 'package:health_management/presentation/appointment/ui/screens/appointment_home.dart';
import 'package:health_management/presentation/appointment/ui/screens/choose_appointment_date_time.dart';
import 'package:health_management/presentation/appointment/ui/screens/choose_doctor_screen.dart';
import 'package:health_management/presentation/appointment/ui/screens/choose_health_provider_screen.dart';

import '../appointment/bloc/appointment/appointment_bloc.dart';

part 'appointment_route.g.dart';

@TypedShellRoute<AppointmentRoute>(
  routes: [
  TypedGoRoute<AppointmentHomeRoute>(path: "/appointment/home", name: RouteDefine.appointment,routes: []),
  TypedGoRoute<AppointmentCreateRoute>(
      path: "/appointment/create",
      name: RouteDefine.createAppointment,
      routes: [
        TypedGoRoute<AppointmentCreateChooseProvider>(
            path: "/choose-provider",
            name: RouteDefine.createAppointmentChooseProvider),
        // TypedGoRoute<AppointmentCreateChooseDepartment>(
        //     path: "/choose-department",
        //     name: RouteDefine.createAppointmentChooseDepartment),
        TypedGoRoute<AppointmentCreateChooseDoctor>(
            path: "/choose-doctor",
            name: RouteDefine.createAppointmentChooseDoctor),
        TypedGoRoute<AppointmentCreateChooseTime>(
            path: "/choose-time",
            name: RouteDefine.createAppointmentChooseTime),
      ]),
],

)
class AppointmentRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BlocProvider(
      create: (context) => AppointmentBloc(appointmentUseCase: getIt()),
      child: navigator,     
    );
  }
} 

class AppointmentHomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentHome();
  }
}

class AppointmentCreateRoute extends GoRouteData {}

class AppointmentCreateChooseProvider extends AppointmentCreateRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => HealthProviderBloc(healthProviderUseCase: getIt())
        ..add(GetAllHealthProviderEvent()),
      child: ChooseHealthProviderScreen(),
    );
  }
}

class AppointmentCreateChooseTime extends AppointmentCreateRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChooseAppointmentDateTimeScreen();
  }
}

class AppointmentCreateChooseDoctor extends AppointmentCreateRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChooseDoctorScreen(doctors: state.extra as List<UserEntity>);
  }
}
// class AppointmentCreateChooseDepartment extends AppointmentCreateRoute {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return ChooseD;
//   }
// }
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/appointment/bloc/doctor_schedule/doctor_schedule_bloc.dart';
import 'package:health_management/presentation/appointment/bloc/health_provider/health_provider_bloc.dart';
import 'package:health_management/presentation/appointment/ui/screens/appointment_details.dart';
import 'package:health_management/presentation/appointment/ui/screens/appointment_home.dart';
import 'package:health_management/presentation/appointment/ui/screens/choose_appointment_date_time.dart';
import 'package:health_management/presentation/appointment/ui/screens/choose_doctor_screen.dart';
import 'package:health_management/presentation/appointment/ui/screens/choose_health_provider_screen.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/chat_page.dart';
import '../../domain/prescription/entities/prescription_entity.dart';
import '../appointment/bloc/appointment/appointment_bloc.dart';
import '../appointment/bloc/medication/medication_bloc.dart';
import '../chat/bloc/call/call_cubit.dart';
import '../chat/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import '../chat/bloc/chat/chat_contacts/chat_cubit.dart';
import '../chat/bloc/chat/in_chat/in_chat_cubit.dart';
import '../chat/bloc/contacts/contacts_cubit.dart';
import '../chat/bloc/others/background_chat/background_cubit.dart';
import '../chat/bloc/status/status_cubit.dart';
import '../chat/bloc/user/user_cubit.dart';
import '../prescription/bloc/prescription_ai_analysis_bloc.dart';
import '../prescription/ui/screens/prescription_screen.dart';
part 'appointment_route.g.dart';

@TypedShellRoute<AppointmentRoute>(
  routes: [
    TypedGoRoute<AppointmentHomeRoute>(
      path: "/appointment/home",
      name: RouteDefine.appointment,
      routes: [],
    ),
    TypedGoRoute<AppointmentDetailsRoute>(
        path: "/appointment/details/:appointmentId",
        name: RouteDefine.appointmentDetails,
        routes: [
          TypedGoRoute<AppointmentDetailsPrescription>(
            path: "/prescription",
            name: RouteDefine.appointmentDetailsPrescription,
          ),
          TypedGoRoute<AppointmentDetailsChatRoute>(
            path: "/chat/:userId",
            name: RouteDefine.appointmentDetailsChat,
          )
        ]),
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
      create: (context) => AppointmentBloc(
          appointmentUseCase: getIt(), healthProviderUseCase: getIt()),
      child: navigator,
    );
  }
}

class AppointmentDetailsPrescription extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final PrescriptionEntity? prescription = state.extra as PrescriptionEntity?;
    int appointmentId =
        int.tryParse(state.pathParameters['appointmentId'] ?? '0') ?? 0;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PrescriptionAiAnalysisBloc(
                prescriptionAiAnalysisUseCase: getIt()),
          ),
          BlocProvider(
            create: (context) => MedicationBloc(prescriptionUseCase: getIt())
              ..add(GetAllMedicationEvent()),
          ),
        ],
        child: MedicineListScreen(
          prescriptions: prescription?.details,
          appointmentId: appointmentId,
        ));
  }
}

class AppointmentDetailsRoute extends GoRouteData {
  final int appointmentId;
  AppointmentDetailsRoute({required this.appointmentId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    int appointmentId =
        int.tryParse(state.pathParameters['appointmentId'] ?? '0') ?? 0;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContactsCubit()..getAllContacts()),
      ],
      child: AppointmentDetails(appointmentId: appointmentId),
    );
  }
}

class AppointmentDetailsChatRoute extends GoRouteData {
  final String userId;
  const AppointmentDetailsChatRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    ChatPageData chatContactData = state.extra as ChatPageData;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => InChatCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => StatusCubit()),
        BlocProvider(create: (context) => ContactsCubit()),
        BlocProvider(create: (context) => CallCubit()),
        BlocProvider(create: (context) => BottomChatCubit()),
        BlocProvider(create: (context) => BackgroundCubit())
      ],
      child: ChatPage(
        name: chatContactData.name,
        receiverId: chatContactData.receiverId,
        profilePicture: chatContactData.profilePicture,
        isGroupChat: false,
      ),
    );
  }
}

class AppointmentHomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentHome();
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final routeQueryData = state.uri.queryParameters;
    if (routeQueryData['source'] == 'notification') {
      final appointmentId = int.parse(routeQueryData['appointmentId'] ?? '0');
      return "/appointment/details/$appointmentId";
    }
    return null;
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
    return BlocProvider(
      create: (context) => DoctorScheduleBloc(getIt()),
      child: ChooseAppointmentDateTimeScreen(
        doctorId: state.extra as int,
      ),
    );
  }
}

class AppointmentCreateChooseDoctor extends AppointmentCreateRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChooseDoctorScreen(doctors: state.extra as List<UserEntity>);
  }
}

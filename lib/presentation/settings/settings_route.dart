import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/edit_profile/ui/edit_profile_screen.dart';
import 'package:health_management/presentation/settings/ui/screen/settings_screen.dart';

import '../../app/di/injection.dart';
import '../../domain/user/usecases/user_usecase.dart';
import '../edit_profile/bloc/edit_profile_bloc.dart';
part 'settings_route.g.dart';

@TypedShellRoute<SettingsRoute>(routes: [
  TypedGoRoute<SettingScreenRoute>(path: '/settings', name: RouteDefine.settings, routes: [
    TypedGoRoute<ProfileRoute>(path: '/edit-profile', name: RouteDefine.editProfile),
  ]),
])
class SettingsRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditProfileBloc(
            userUseCase: getIt<UserUseCase>(),
          ),
        ),
      ],
      child: navigator,
    );
  }
}

class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditProfileScreen();
  }
}

class SettingScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

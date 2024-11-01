import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/auth/ui/login_screen.dart';
import 'package:health_management/presentation/auth/ui/register_screen.dart';

import 'bloc/authentication_bloc.dart';

part 'auth_route.g.dart';

@TypedGoRoute<LoginRoute>(name: RouteDefine.login, path: '/login')
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(name: RouteDefine.register, path: '/register')
class RegisterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterScreen();
  }
}

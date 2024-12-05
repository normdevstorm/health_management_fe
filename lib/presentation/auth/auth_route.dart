import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/auth/ui/login_screen.dart';
import 'package:health_management/presentation/auth/ui/register_screen.dart';
import '../verify_code/ui/screens/verify_code_screen.dart';

part 'auth_route.g.dart';

@TypedGoRoute<LoginRoute>(name: RouteDefine.login, path: '/login')
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(name: RouteDefine.register, path: '/register', routes: [
  TypedGoRoute<VerifyCodeRoute>(name: RouteDefine.verifyCode, path: '/verify-code'),
])
class RegisterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterScreen();
  }
}

class VerifyCodeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerifyCodeScreen();
  }
}

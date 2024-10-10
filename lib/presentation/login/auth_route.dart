import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/login/ui/login_screen.dart';
import 'package:health_management/presentation/login/ui/register_screen.dart';

import 'bloc/login_bloc.dart';

part 'auth_route.g.dart';

@TypedGoRoute<LoginRoute>(name: RouteDefine.login, path: '/login')
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          (previous != current),
      listener: (context, state) {
        // TODO: implement listener
        // if (state is LoginSuccess) {
        //   GoRouter.of(context).replaceNamed(RouteDefine.home);
        //   return;
        // }
      },
      child: const LoginScreen(),
    );
  }
}

@TypedGoRoute<RegisterRoute>(name: RouteDefine.register, path: '/register')
class RegisterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterScreen();
  }
}

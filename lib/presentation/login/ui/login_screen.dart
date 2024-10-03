import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/common/button.dart';
import 'package:health_management/presentation/common/input_field.dart';
import 'package:health_management/presentation/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final ValueNotifier<bool> _isHiddenPasswordNotifier =
      ValueNotifier<bool>(true);

  final _emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login success"),
            ));
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _emailFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonTextFormField(
                    controller: _emailController,
                    width: 327.w,
                    height: 64.h,
                    hintText: 'Email',
                    validator: (value) {
                      //todo: create a regex manager later on
                      if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value ?? "")) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                  ),
                  16.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: _isHiddenPasswordNotifier,
                    builder: (context, isHiddenPassword, child) =>
                        CommonTextFormField(
                      controller: _passwordController,
                      width: 327.w,
                      height: 64.h,
                      hintText: 'Password',
                      obscureText: isHiddenPassword,
                      suffixIcon: GestureDetector(
                        child: Icon(
                            isHiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                            size: 20.r),
                        onTap: () =>
                            _onTapIconHidden(_isHiddenPasswordNotifier),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password logic here
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  5.verticalSpace,
                  Button(
                    width: 327.w,
                    height: 60.h,
                    text: 'Login',
                    onPressed: () {
                      // Handle login logic here
                      if (_emailFormKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginSubmitEvent(
                              _emailController.text,
                              _passwordController.text,
                            ));
                        // context.pushNamed(RouteDefine.register);
                      }
                    },
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(RouteDefine.register);
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapIconHidden(ValueNotifier<bool> isHiddenPasswordNotifier) {
    isHiddenPasswordNotifier.value = !isHiddenPasswordNotifier.value;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/common/button.dart';
import 'package:health_management/presentation/common/input_field.dart';

import '../../../app/app.dart';
import '../../../app/route/route_define.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final ValueNotifier<bool> _isHiddenPasswordNotifier =
      ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is GetVerifyCodeSuccess) {
          GoRouter.of(context).pushNamed(RouteDefine.verifyCode,
              extra: RegisterSubmitEvent(
                  _emailController.text,
                  _passwordController.text,
                  _usernameController.text,
                  Role.user));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CommonTextFormField(
                  controller: _usernameController,
                  width: 327.w,
                  height: 64.h,
                  hintText: 'Username',
                  // Add other parameters if needed
                ),
                const SizedBox(height: 16.0),
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
                  // keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
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
                      onTap: () => _onTapIconHidden(_isHiddenPasswordNotifier),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Button(
                    text: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthenticationBloc>()
                            .add(GetVerifyCodeEvent(_emailController.text));
                      }
                    }),
              ],
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

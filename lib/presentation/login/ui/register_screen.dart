import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/presentation/common/button.dart';
import 'package:health_management/presentation/common/input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final ValueNotifier<bool> _isHiddenPasswordNotifier =
      ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: 327.w,
                height: 64.h,
                hintText: 'Username',
                // Add other parameters if needed
              ),
              const SizedBox(height: 16.0),
              CommonTextFormField(
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
                  _formKey.currentState!.validate();
                  // Handle registration logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTapIconHidden(ValueNotifier<bool> isHiddenPasswordNotifier) {
    isHiddenPasswordNotifier.value = !isHiddenPasswordNotifier.value;
  }
}

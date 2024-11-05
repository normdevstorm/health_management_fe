import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/common/button.dart';
import 'package:health_management/presentation/common/input_field.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _isHiddenPasswordNotifier =
      ValueNotifier<bool>(true);
  final _emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _emailFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Hình ảnh trên cùng
                Image.asset(
                  'assets/images/doctor_login_image.png', // Thay bằng đường dẫn hình ảnh của bạn
                  height: 150.h,
                ),
                SizedBox(height: 20.h),

                // Tiêu đề "LOGIN"
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20.h),

                // Trường email
                CommonTextFormField(
                  controller: _emailController,
                  width: 327.w,
                  height: 64.h,
                  hintText: 'Email',
                  // prefixIcon:
                  //     Icon(Icons.email, color: Colors.grey), // Thêm icon email
                  validator: (value) {
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value ?? "")) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // Trường mật khẩu
                ValueListenableBuilder(
                  valueListenable: _isHiddenPasswordNotifier,
                  builder: (context, isHiddenPassword, child) =>
                      CommonTextFormField(
                    controller: _passwordController,
                    width: 327.w,
                    height: 64.h,
                    hintText: 'Password',
                    obscureText: isHiddenPassword,
                    // prefixIcon:
                    //     Icon(Icons.lock, color: Colors.grey), // Thêm icon khóa
                    suffixIcon: GestureDetector(
                      child: Icon(
                        isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onTap: () => onTapIconHidden(_isHiddenPasswordNotifier),
                    ),
                  ),
                ),

                // Quên mật khẩu
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      // Xử lý quên mật khẩu
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),

                SizedBox(height: 10.h),

                // Nút đăng nhập
                Button(
                  width: 327.w,
                  height: 60.h,
                  text: 'LOGIN',
                  // color: Colors.blue, // Màu xanh cho nút đăng nhập
                  onPressed: () {
                    if (_emailFormKey.currentState!.validate()) {
                      context.read<AuthenticationBloc>().add(LoginSubmitEvent(
                            _emailController.text,
                            _passwordController.text,
                          ));
                    }
                  },
                ),

                SizedBox(height: 20.h),

                // "OR"
                Text("OR",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54)),

                SizedBox(height: 20.h),

                // Đăng nhập với Google, Apple, Facebook
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Xử lý đăng nhập Google
                      },
                      icon: Image.asset(
                          'assets/icons/flat-color-icons_google.png'),
                      iconSize: 40,
                    ),
                    SizedBox(width: 20.w),
                    IconButton(
                      onPressed: () {
                        // Xử lý đăng nhập Apple
                      },
                      icon: Image.asset('assets/icons/devicon_apple.png'),
                      iconSize: 40,
                    ),
                    SizedBox(width: 20.w),
                    IconButton(
                      onPressed: () {
                        // Xử lý đăng nhập Facebook
                      },
                      icon: Image.asset('assets/icons/logos_facebook.png'),
                      iconSize: 40,
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Đăng ký tài khoản
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        context.goNamed(RouteDefine.register);
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapIconHidden(ValueNotifier<bool> isHiddenPasswordNotifier) {
    isHiddenPasswordNotifier.value = !isHiddenPasswordNotifier.value;
  }
}

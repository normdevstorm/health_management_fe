
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_management/presentation/chat/bloc/auth/auth_cubit.dart';
import 'package:health_management/presentation/chat/bloc/auth/auth_state.dart';
import 'package:health_management/presentation/chat/widgets/button.dart';
import 'package:health_management/presentation/chat/widgets/snackbar.dart';

class SignUpBodySection extends StatefulWidget {
  const SignUpBodySection({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpBodySectionState();
}

class _SignUpBodySectionState extends State<SignUpBodySection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get userNameController => _userNameController;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();

  bool _showEmailSuffix = false;
  bool _showPasswordSuffix = false;
  bool _showConfirmPasswordSuffix = false;
  bool _showUserNameSuffix = false;
  bool _signUpButtonPressed = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: userNameController,
              focusNode: _userNameFocusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: _showUserNameSuffix
                    ? GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            'assets/vectors/empty.svg',
                            width: 8,
                            height: 8,
                          ),
                        ),
                      )
                    : null,
                labelText: 'Username',
                labelStyle: const TextStyle(
                  color: Color(0xffa5a5a5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _userNameController.text = value;
                  _showUserNameSuffix = _signUpButtonPressed && value.isEmpty;
                  if (_userNameFocusNode.hasFocus) {
                    _signUpButtonPressed = false;
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              focusNode: _emailFocusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: _showEmailSuffix
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          'assets/vectors/empty.svg',
                          width: 8,
                          height: 8,
                        ),
                      )
                    : null,
                labelText: 'Email',
                labelStyle: const TextStyle(
                  color: Color(0xffa5a5a5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _emailController.text = value;
                  _showEmailSuffix = value.isEmpty && _signUpButtonPressed;
                  if (_emailFocusNode.hasFocus) {
                    _signUpButtonPressed = false;
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              focusNode: _passwordFocusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: _showPasswordSuffix
                    ? GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            'assets/vectors/empty.svg',
                            width: 8,
                            height: 8,
                          ),
                        ),
                      )
                    : null,
                labelText: 'Password',
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: _isPasswordVisible
                        ? const Icon(Icons.visibility, color: Colors.white)
                        : const Icon(Icons.visibility_off,
                            color: Colors.white)),
                labelStyle: const TextStyle(
                  color: Color(0xffa5a5a5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              obscureText: !_isPasswordVisible,
              onChanged: (value) {
                setState(() {
                  _passwordController.text = value;
                  _showPasswordSuffix = _signUpButtonPressed && value.isEmpty;
                  if (_passwordFocusNode.hasFocus) {
                    _signUpButtonPressed = false;
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: _showConfirmPasswordSuffix
                    ? GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            'assets/vectors/empty.svg',
                            width: 8,
                            height: 8,
                          ),
                        ),
                      )
                    : null,
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: _isConfirmPasswordVisible
                        ? const Icon(Icons.visibility, color: Colors.white)
                        : const Icon(Icons.visibility_off,
                            color: Colors.white)),
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(
                  color: Color(0xffa5a5a5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffa5a5a5)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              obscureText: !_isConfirmPasswordVisible,
              onChanged: (value) {
                setState(() {
                  _confirmPasswordController.text = value;
                  _showConfirmPasswordSuffix =
                      _signUpButtonPressed && value.isEmpty;
                  if (_confirmPasswordFocusNode.hasFocus) {
                    _signUpButtonPressed = false;
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSignUpSuccess) {
                  MySnackBar.hideSnackBar(context);
                  MySnackBar.showSnackBar(context, 'Sign up success');
                  // Navigator.pushReplacementNamed(context, Login.routeName);
                } else if (state is AuthErrorState) {
                  MySnackBar.hideSnackBar(context);
                  MySnackBar.showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Button(
                      key: const Key('button sign up'),
                      text: 'Sign Up',
                      onPressed: _onPressed),
                );
              },
            ),
            const Expanded(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }

  _onPressed() async {
    setState(() {
      _showEmailSuffix = _emailController.text.isEmpty;
      _showPasswordSuffix = _passwordController.text.isEmpty;
      _showUserNameSuffix = _userNameController.text.isEmpty;
      _showConfirmPasswordSuffix = _confirmPasswordController.text.isEmpty;
      _signUpButtonPressed = true;
    });
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var confirmPassword = confirmPasswordController.text.trim();
    var username = userNameController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        username.isEmpty) {
      MySnackBar.hideSnackBar(context);
      MySnackBar.showSnackBar(context, 'Please fill all fields');
    } else if (password != confirmPassword) {
      MySnackBar.hideSnackBar(context);
      MySnackBar.showSnackBar(context, 'Password not match');
    } else {
      BlocProvider.of<AuthCubit>(context)
          .signUpWithEmail(email, password, username);
    }
  }
}

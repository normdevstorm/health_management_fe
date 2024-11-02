import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Center(
              child: Image.asset(
                'assets/images/placeholder.png',
                height: 100,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Enter the code sent to your email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final RegisterSubmitEvent registerSubmitEvent =
                    GoRouterState.of(context).extra! as RegisterSubmitEvent;
                // Add your OTP verification logic here
                context.read<AuthenticationBloc>().add(VerifyCodeSubmitEvent(
                    code: _codeController.text,
                    email: registerSubmitEvent.email,
                    registerSubmitEvent: registerSubmitEvent));
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

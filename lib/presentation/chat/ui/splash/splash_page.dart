// import 'package:health_management/features/presentation/bloc/auth/auth_cubit.dart';
// import 'package:health_management/features/presentation/bloc/auth/auth_state.dart';
// import 'package:health_management/features/presentation/ui/login/login.dart';
// import 'package:health_management/features/presentation/ui/main/main_screen.dart';
// import 'package:health_management/features/presentation/ui/splash/splash_body.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashPage extends StatelessWidget {
//   static const String routeName = 'splash';
//   const SplashPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // BlocProvider.of<AuthCubit>(context).signOut(); // For testing
//     return Scaffold(
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is AuthLoggedInState) {
//             Future.delayed(const Duration(milliseconds: 1000), () async {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const MainScreen()));
//             });
//           } else if (state is AuthLoggedOutState) {
//             Future.delayed(const Duration(milliseconds: 1000), () async {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const Login()));
//             });
//           }
//         },
//         builder: (context, state) {
//           if (state is AuthLoggedInState) {
//             Future.delayed(const Duration(milliseconds: 1000), () async {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const MainScreen()));
//             });
//           } else if (state is AuthLoggedOutState) {
//             Future.delayed(const Duration(milliseconds: 1000), () async {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const Login()));
//             });
//           }
//           return const SplashBody();
//         },
//       ),
//     );
//   }
// }

// // ignore_for_file: prefer_const_constructors

// import 'package:health_management/core/utils/constants/app_color.dart';
// import 'package:health_management/features/presentation/ui/login/components/sign_in_body_section.dart';
// import 'package:health_management/features/presentation/ui/login/components/sign_up_body_section.dart';
// import 'package:flutter/material.dart';

// class Login extends StatefulWidget {
//   static const String routeName = 'login';
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool _isSignInMode = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Stack(children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: AppColor.backgroundLoginColor,
//           ),
//           Positioned(top: 0, left: 0, right: 0, child: HeaderSection()),
//           Positioned(
//               top: 250,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                   height: MediaQuery.of(context).size.height - 250,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.3),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                     border: Border(
//                       top: BorderSide(
//                         color: Color(0xffa5a5a5),
//                         width: 1,
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                           child: _isSignInMode
//                               ? SignInBodySection()
//                               : SignUpBodySection()),
//                       ChangeBody(
//                         text1: _isSignInMode
//                             ? 'Don\'t have an account?'
//                             : 'Already have an account?',
//                         text2: _isSignInMode ? 'Sign Up' : 'Sign In',
//                         onPressed: () {
//                           setState(() {
//                             _isSignInMode = !_isSignInMode;
//                           });
//                         },
//                       ),
//                     ],
//                   ))),
//         ]),
//       ),
//     ));
//   }
// }

// // ignore: must_be_immutable
// class ChangeBody extends StatefulWidget {
//   String text1, text2;
//   Function onPressed;
//   ChangeBody(
//       {super.key,
//       required this.text1,
//       required this.text2,
//       required this.onPressed});

//   @override
//   State<ChangeBody> createState() => _ChangeBodyState();
// }

// class _ChangeBodyState extends State<ChangeBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             widget.text1,
//             style: TextStyle(
//               color: Color(0xFF8C8E99),
//               fontSize: 14,
//               fontFamily: 'Figtree',
//               fontWeight: FontWeight.w400,
//               height: 0,
//             ),
//           ),
//           TextButton(
//             onPressed: () => widget.onPressed(),
//             child: Text(
//               widget.text2,
//               style: TextStyle(
//                 color: Color(0xFF11DCE8),
//                 fontSize: 14,
//                 fontFamily: 'Figtree',
//                 fontWeight: FontWeight.w400,
//                 height: 0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: Container(
//         height: 250,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//         ),
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 50,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Sign in to continue',
//               style: TextStyle(
//                 color: Color(0xffa5a5a5),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

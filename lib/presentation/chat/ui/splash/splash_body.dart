// import 'package:health_management/features/presentation/widgets/background.dart';
// import 'package:flutter/material.dart';

// class SplashBody extends StatelessWidget {
//   const SplashBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const Background(),
//         Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 296,
//                 height: 296,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 0,
//                       top: 0,
//                       child: Opacity(
//                         opacity: 0.70,
//                         child: Container(
//                           width: 296,
//                           height: 296,
//                           decoration: const ShapeDecoration(
//                             color: Colors.transparent,
//                             shape: OvalBorder(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 0,
//                       top: 0,
//                       child: Container(
//                         width: 296,
//                         height: 296,
//                         decoration: const ShapeDecoration(
//                           color: Colors.transparent,
//                           shape: OvalBorder(
//                             side: BorderSide(
//                                 width: 1,
//                                 color: Color(0xFF11DCE8),
//                                 style: BorderStyle.solid),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 3.80,
//                       top: 4,
//                       child: Opacity(
//                         opacity: 0.30,
//                         child: Container(
//                           width: 288,
//                           height: 288,
//                           decoration: const ShapeDecoration(
//                             shape: OvalBorder(
//                               side: BorderSide(width: 1, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Positioned(
//                       left: 0,
//                       top: 0,
//                       child: SizedBox(
//                         width: 296,
//                         height: 296,
//                         child: CircularProgressIndicator(
//                           value: null,
//                           strokeWidth: 6.0,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.white),
//                           backgroundColor: Colors.transparent,
//                           strokeCap: StrokeCap.round,
//                         ),
//                       ),
//                     ),
//                     const Positioned(
//                       left: 40.80,
//                       top: 110,
//                       child: SizedBox(
//                         width: 213.92,
//                         height: 76.06,
//                         child: Stack(children: [
//                           Text(
//                             "Flutter",
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 247, 247, 247),
//                               fontSize: 64,
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w700,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ]),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Positioned(
//             bottom: 72,
//             right: 0,
//             left: 0,
//             child: Center(
//               child: Image.asset(
//                 'assets/images/flutter_logo.png',
//                 width: 111,
//                 height: 32,
//               ),
//             )),
//       ],
//     );
//   }
// }

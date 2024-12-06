import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/splash_screen_background.png',
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      fit: BoxFit.cover,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_management/screens/home_page.dart';
import 'package:health_management/screens/temperature_humidity_sensor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyHomePage(),
    themeAnimationStyle: AnimationStyle(),
    theme: ThemeData.light().copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
        scaffoldBackgroundColor: Colors.white),
  ));
}

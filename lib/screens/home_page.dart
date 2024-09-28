import 'package:flutter/material.dart';
import 'package:health_management/screens/living_room_ui.dart';
import 'package:health_management/screens/temperature_humidity_sensor_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const LivingRoomUI(),
    const TemperatureHumiditySensorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote),
            label: 'Remote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat_outlined),
            label: 'Thermostat',
          ),
        ],
      ),
    );
  }
}

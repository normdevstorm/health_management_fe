import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/device_remote_widget.dart';

class LivingRoomUI extends StatefulWidget {
  const LivingRoomUI({super.key});

  @override
  State<LivingRoomUI> createState() => _LivingRoomUIState();
}

class _LivingRoomUIState extends State<LivingRoomUI> {
  late DatabaseReference databaseDoor;
  late DatabaseReference databaseLight;
  late DatabaseReference databaseFan;
  bool isDoorOpened = false;
  bool isLightOn = false;
  bool isFanOn = false;

  @override
  void initState() {
    // TODO: implement initState
    databaseDoor = FirebaseDatabase.instance.ref().child('door');
    databaseLight = FirebaseDatabase.instance.ref().child('light');
    databaseFan = FirebaseDatabase.instance.ref().child('fan');

    databaseDoor.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        isDoorOpened = data['isOpened'] as bool;
      });
    });
    databaseLight.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        isLightOn = data['isOn'] as bool;
      });
    });
    databaseFan.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        isFanOn = data['isOn'] as bool;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Options',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeviceRemoteWidget(
                  database: databaseDoor,
                  isOpened: isDoorOpened,
                  deviceName: 'Door',
                  databaseStatusKey: 'isOpened',
                  icon: Icons.door_sliding_sharp,
                ),
                const SizedBox(height: 20),
                DeviceRemoteWidget(
                  database: databaseLight,
                  isOpened: isLightOn,
                  deviceName: 'Light',
                  databaseStatusKey: 'isOn',
                  deviceStatusOff: "off",
                  deviceStatusOn: "on",
                  icon: Icons.lightbulb_outline_sharp,
                ),
              ],
            ),
            const SizedBox(height: 20),
            DeviceRemoteWidget(
              database: databaseFan,
              isOpened: isFanOn,
              deviceName: 'Fan',
              databaseStatusKey: 'isOn',
              deviceStatusOff: "off",
              deviceStatusOn: "on",
              icon: Icons.wind_power_outlined,
            ),
            // Door
          ],
        ),
      ),
    );
  }
}

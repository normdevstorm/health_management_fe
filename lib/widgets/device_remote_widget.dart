import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DeviceRemoteWidget extends StatelessWidget {
  const DeviceRemoteWidget({
    super.key,
    required this.database,
    required this.isOpened,
    required this.deviceName,
    required this.databaseStatusKey,
    this.icon = Icons.power_settings_new_sharp,
    this.deviceStatusOn = "opened",
    this.deviceStatusOff = "closed",
  });

  final DatabaseReference database;
  final String databaseStatusKey;
  final IconData icon;
  final bool isOpened;
  final String deviceName;
  final String deviceStatusOn;
  final String deviceStatusOff;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deviceName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Manual mode',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          // Temperature Dial and Display
          Stack(
            alignment: Alignment.center,
            children: [
              // Temperature Dial (Placeholder)
              InkWell(
                onTap: () => {
                  database.set({databaseStatusKey: !isOpened}),
                },
                child: Container(
                  height: 150,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.grey[300]!),
                  ),
                  child: Icon(
                    icon,
                    size: 50,
                    color: isOpened ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '$deviceName is ${isOpened ? deviceStatusOn : deviceStatusOff}',
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

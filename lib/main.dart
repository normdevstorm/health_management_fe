import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widgets/humidity_graph.dart';
import 'widgets/temperature_graph.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TemperatureHumiditySensorScreen(),
  ));
}

class TemperatureHumiditySensorScreen extends StatefulWidget {
  const TemperatureHumiditySensorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureHumiditySensorScreenState createState() =>
      _TemperatureHumiditySensorScreenState();
}

class _TemperatureHumiditySensorScreenState
    extends State<TemperatureHumiditySensorScreen> {
  String temperature = 'Loading...';
  String humidity = 'Loading...';
  Map<String, double> temperatureRecords = {
    '00.00': 0.0,
    '04:00': 0.0,
    '08"00': 0.0,
    '12:00': 0.0,
    '16:00': 0.0,
    '20:00': 0.0,
  };
  Map<String, double> humididtyRecords = {
    '00.00': 0.0,
    '04:00': 0.0,
    '08"00': 0.0,
    '12:00': 0.0,
    '16:00': 0.0,
    '20:00': 0.0,
  };

  String _getTemperatureStatus() {
    double tempValue = double.tryParse(temperature.replaceAll('°C', '')) ?? 0.0;
    if (tempValue < 18.0) {
      return 'Cold';
    } else if (tempValue > 30.0) {
      return 'Hot';
    } else {
      return 'Normal';
    }
  }

  String _getHumidityStatus() {
    double humidityValue = double.tryParse(humidity.replaceAll('%', '')) ?? 0.0;
    if (humidityValue < 30.0) {
      return 'Dry';
    } else if (humidityValue > 60.0) {
      return 'Humid';
    } else {
      return 'Normal';
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('environment');

    DatabaseReference databaseTemperature =
        FirebaseDatabase.instance.ref().child('temperature_records');

    DatabaseReference databaseHumidity =
        FirebaseDatabase.instance.ref().child('humidity_records');

    databaseReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        temperature = '${data['temperature']}°C';
        humidity = '${data['humidity']}%';
      });
    });

    databaseTemperature.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        for (var element in data.keys) {
          temperatureRecords[element] =
              double.tryParse(data[element].toString()) ??
                  int.tryParse(data[element].toString())?.toDouble() ??
                  0.0;
        }
      });
    });

    databaseHumidity.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        for (var element in data.keys) {
          humididtyRecords[element] =
              double.tryParse(data[element].toString()) ??
                  int.tryParse(data[element].toString())?.toDouble() ??
                  0.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          'Temperature Humidity Sensor',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Icon(Icons.edit, color: Colors.black),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add some space below the AppBar
            const SizedBox(height: 24),
            // Temperature and Humidity Cards
            Row(
              children: [
                Expanded(
                  child: SensorCard(
                    icon: Icons.thermostat_outlined,
                    value: temperature,
                    status: _getTemperatureStatus(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SensorCard(
                    icon: Icons.water_drop_outlined,
                    value: humidity,
                    status: _getHumidityStatus(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // TabBar for Temperature / Humidity
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TabBar(
                        dividerHeight: 0,
                        dragStartBehavior: DragStartBehavior.start,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(text: 'Temperature'),
                          Tab(text: 'Humidity'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            TemperatureGraph(
                              val_1: temperatureRecords["00:00"] ?? 0.0,
                              val_2: temperatureRecords["04:00"] ?? 0.0,
                              val_3: temperatureRecords["08:00"] ?? 0.0,
                              val_4: temperatureRecords["12:00"] ?? 0.0,
                              val_5: temperatureRecords["16:00"] ?? 0.0,
                              val_6: temperatureRecords["20:00"] ?? 0.0,
                            ),
                            HumidityGraph(
                              val_1: humididtyRecords["00:00"] ?? 0.0,
                              val_2: humididtyRecords["04:00"] ?? 0.0,
                              val_3: humididtyRecords["08:00"] ?? 0.0,
                              val_4: humididtyRecords["12:00"] ?? 0.0,
                              val_5: humididtyRecords["16:00"] ?? 0.0,
                              val_6: humididtyRecords["20:00"] ?? 0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}

class SensorCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String status;

  const SensorCard(
      {super.key,
      required this.icon,
      required this.value,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 36),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

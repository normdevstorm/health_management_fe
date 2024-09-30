import 'package:flutter/material.dart';

class MyOverviewScreen extends StatelessWidget {
  const MyOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Here you can see an overview of your health data.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Heart Rate'),
                    subtitle: Text('72 bpm'),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_walk),
                    title: Text('Steps'),
                    subtitle: Text('10,000 steps'),
                  ),
                  ListTile(
                    leading: Icon(Icons.local_hospital),
                    title: Text('Blood Pressure'),
                    subtitle: Text('120/80 mmHg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
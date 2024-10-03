import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';

class MyDetailsScreen extends StatelessWidget {
  final List<Map<String, String>> people = [
    {
      'name': 'John Doe',
      'age': '30',
      'email': 'johndoe@example.com',
      'phone': '+1234567890',
    },
    {
      'name': 'Jane Smith',
      'age': '28',
      'email': 'janesmith@example.com',
      'phone': '+0987654321',
    },
    {
      'name': 'Alice Johnson',
      'age': '35',
      'email': 'alicejohnson@example.com',
      'phone': '+1122334455',
    },
  ];

  MyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return Card(
            child: ListTile(
              title: Text(person['name']!),
              subtitle: const Text('Tap to view details'),
              onTap: () {
                context.pushNamed(RouteDefine.chatDetails,
                    pathParameters: {'userId': person['name']!});
              },
            ),
          );
        },
      ),
    );
  }
}

class PersonDetailScreen extends StatelessWidget {
  final Map<String, String> person;

  const PersonDetailScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${person['name']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Age: ${person['age']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${person['email']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${person['phone']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

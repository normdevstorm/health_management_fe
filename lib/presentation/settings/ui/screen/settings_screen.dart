import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          minTileHeight: 100.h,
          leading: const Icon(Icons.account_circle),
          title: const Text('Account'),
          onTap: () {
            // Handle account settings tap
            context.goNamed(RouteDefineName.chatDetails,
                pathParameters: {'userId': 'Alice Johnson'});
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            // Handle notifications settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Privacy'),
          onTap: () {
            // Handle privacy settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          onTap: () {
            // Handle help & support settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () {
            // Handle about settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Account'),
          onTap: () {
            // Handle account settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            // Handle notifications settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Privacy'),
          onTap: () {
            // Handle privacy settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          onTap: () {
            // Handle help & support settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () {
            // Handle about settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Account'),
          onTap: () {
            // Handle account settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            // Handle notifications settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Privacy'),
          onTap: () {
            // Handle privacy settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          onTap: () {
            // Handle help & support settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () {
            // Handle about settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Account'),
          onTap: () {
            // Handle account settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            // Handle notifications settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Privacy'),
          onTap: () {
            // Handle privacy settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          onTap: () {
            // Handle help & support settings tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () {
            // Handle about settings tap
          },
        ),
      ],
    );
  }
}

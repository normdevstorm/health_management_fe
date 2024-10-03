import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/presentation/common/tag.dart';
import 'package:health_management/presentation/common/tag_list.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late PageController controller;
  // final int _value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: SizedBox(
                height: 280.h,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: const TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return Column(
      children: [
        10.verticalSpace,
        const TagList(tags: [
          TagChip(text: 'General', isActive: true),
          TagChip(text: 'Security', isActive: true),
          TagChip(text: 'Account', isActive: false),
          TagChip(text: 'Notifications', isActive: true),
          TagChip(text: 'Help & Support', isActive: false),
          TagChip(text: 'Appearance', isActive: true),
          TagChip(text: 'Language', isActive: false),
          TagChip(text: 'Data Usage', isActive: true),
          TagChip(text: 'Accessibility', isActive: false),
          TagChip(text: 'Blocked Contacts', isActive: true),
          TagChip(text: 'Linked Devices', isActive: false),
          TagChip(text: 'Storage', isActive: true),
        ]),
      ],
    );
    // ListView(
    //   children: <Widget>[
    //     ListTile(
    //       minTileHeight: 100.h,
    //       leading: const Icon(Icons.account_circle),
    //       title: const Text('Account'),
    //       onTap: () {
    //         // Handle account settings tap
    //         context.goNamed(RouteDefine.chatDetails,
    //             pathParameters: {'userId': 'Alice Johnson'});
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.notifications),
    //       title: const Text('Notifications'),
    //       onTap: () {
    //         // Handle notifications settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.lock),
    //       title: const Text('Privacy'),
    //       onTap: () {
    //         // Handle privacy settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.help),
    //       title: const Text('Help & Support'),
    //       onTap: () {
    //         // Handle help & support settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.info),
    //       title: const Text('About'),
    //       onTap: () {
    //         // Handle about settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.account_circle),
    //       title: const Text('Account'),
    //       onTap: () {
    //         // Handle account settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.notifications),
    //       title: const Text('Notifications'),
    //       onTap: () {
    //         // Handle notifications settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.lock),
    //       title: const Text('Privacy'),
    //       onTap: () {
    //         // Handle privacy settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.help),
    //       title: const Text('Help & Support'),
    //       onTap: () {
    //         // Handle help & support settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.info),
    //       title: const Text('About'),
    //       onTap: () {
    //         // Handle about settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.account_circle),
    //       title: const Text('Account'),
    //       onTap: () {
    //         // Handle account settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.notifications),
    //       title: const Text('Notifications'),
    //       onTap: () {
    //         // Handle notifications settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.lock),
    //       title: const Text('Privacy'),
    //       onTap: () {
    //         // Handle privacy settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.help),
    //       title: const Text('Help & Support'),
    //       onTap: () {
    //         // Handle help & support settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.info),
    //       title: const Text('About'),
    //       onTap: () {
    //         // Handle about settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.account_circle),
    //       title: const Text('Account'),
    //       onTap: () {
    //         // Handle account settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.notifications),
    //       title: const Text('Notifications'),
    //       onTap: () {
    //         // Handle notifications settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.lock),
    //       title: const Text('Privacy'),
    //       onTap: () {
    //         // Handle privacy settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.help),
    //       title: const Text('Help & Support'),
    //       onTap: () {
    //         // Handle help & support settings tap
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.info),
    //       title: const Text('About'),
    //       onTap: () {
    //         // Handle about settings tap
    //       },
    //     ),
    //   ],
    // );
  }
}

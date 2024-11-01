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
    // final pages = List.generate(
    //     6,
    //     (index) => Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16),
    //             color: Colors.grey.shade300,
    //           ),
    //           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    //           child: SizedBox(
    //             height: 280.h,
    //             child: Center(
    //                 child: Text(
    //               "Page $index",
    //               style: const TextStyle(color: Colors.indigo),
    //             )),
    //           ),
    //         ));
    return Column(
      children: [
        10.verticalSpace,
        const TagList(tags: [
          TagChip(text: 'General', isSelected: true),
          TagChip(text: 'Security', isSelected: true),
          TagChip(text: 'Account', isSelected: false),
          TagChip(text: 'Notifications', isSelected: true),
          TagChip(text: 'Help & Support', isSelected: false),
          TagChip(text: 'Appearance', isSelected: true),
          TagChip(text: 'Language', isSelected: false),
          TagChip(text: 'Data Usage', isSelected: true),
          TagChip(text: 'Accessibility', isSelected: false),
          TagChip(text: 'Blocked Contacts', isSelected: true),
          TagChip(text: 'Linked Devices', isSelected: false),
          TagChip(text: 'Storage', isSelected: true),
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

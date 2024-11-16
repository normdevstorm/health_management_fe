import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/presentation/common/tag_chip.dart';
import 'package:health_management/presentation/common/tag_list.dart';
import 'package:health_management/presentation/edit_profile/ui/edit_profile_screen.dart';

import '../../../auth/bloc/authentication_bloc.dart';

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
    super.initState();
    controller = PageController(initialPage: 1);
  }

  void _navigateToEditProfile() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const EditProfileScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpace,
        TagList(tags: [
          TagChip(
              text: 'Profile', isSelected: true, onTap: _navigateToEditProfile),
          const TagChip(text: 'Security', isSelected: true),
          const TagChip(text: 'Account', isSelected: false),
          const TagChip(text: 'Notifications', isSelected: true),
          const TagChip(text: 'Help & Support', isSelected: false),
          const TagChip(text: 'Appearance', isSelected: true),
          const TagChip(text: 'Language', isSelected: false),
          const TagChip(text: 'Data Usage', isSelected: true),
          const TagChip(text: 'Accessibility', isSelected: false),
          const TagChip(text: 'Blocked Contacts', isSelected: true),
          const TagChip(text: 'Linked Devices', isSelected: false),
          const TagChip(text: 'Storage', isSelected: true),
          const TagChip(text: "Logout", isSelected: false)
        ]),
      ],
    );
  }
}

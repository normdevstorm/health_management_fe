import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/common/tag_chip.dart';
import 'package:health_management/presentation/common/tag_list.dart';
import 'package:health_management/presentation/edit_profile/ui/edit_profile_screen.dart';

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
    // context.read<AuthenticationBloc>().add(LogOutEvent());
    controller = PageController(initialPage: 1);
  }

  void _navigateToEditProfile() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditProfileScreen(),
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
          TagChip(text: "Logout", isSelected: false)
        ]),
      ],
    );
  }
}

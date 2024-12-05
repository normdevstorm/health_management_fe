import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/common/tag.dart';
import 'package:health_management/presentation/common/tag_list.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    // context.read<AuthenticationBloc>().add(LogOutEvent());
    controller = PageController(initialPage: 1);
  }

  void _navigateToEditProfile() {
    context.pushNamed(RouteDefine.editProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            // Profile Info
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: const NetworkImage(
                      'https://cdn.eva.vn/upload/3-2022/images/2022-08-12/image7-1660292089-178-width640height700.jpg'),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jack 97',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'DOCTOR',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // // Tag List
            // const TagList(tags: [
            //   TagChip(text: 'General', isSelected: true),
            //   TagChip(text: 'Security', isSelected: true),
            //   TagChip(text: 'Account', isSelected: false),
            //   TagChip(text: 'Notifications', isSelected: true),
            //   TagChip(text: 'Help & Support', isSelected: false),
            //   TagChip(text: 'Appearance', isSelected: true),
            //   TagChip(text: 'Language', isSelected: false),
            //   TagChip(text: 'Data Usage', isSelected: true),
            //   TagChip(text: 'Accessibility', isSelected: false),
            //   TagChip(text: 'Blocked Contacts', isSelected: true),
            //   TagChip(text: 'Linked Devices', isSelected: false),
            //   TagChip(text: 'Storage', isSelected: true),
            // ]),
            SizedBox(height: 20.h),
            // Menu List
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(context, 'Personal Data', Icons.person, () {
                    print('Personal Data clicked');
                  }),
                  buildMenuItem(context, 'Settings', Icons.settings, () {
                    print('Settings clicked');
                  }),
                  buildMenuItem(context, 'My Articles', Icons.receipt_long, () {
                    print('Articles clicked');
                    context.goNamed(RouteDefine.article);
                  }),
                  buildMenuItem(context, 'Referral Code', Icons.card_giftcard,
                      () {
                    print('Referral Code clicked');
                  }),
                  buildMenuItem(context, 'FAQs', Icons.help_outline, () {
                    print('FAQs clicked');
                  }),
                  buildMenuItem(context, 'Our Handbook', Icons.book, () {
                    print('Our Handbook clicked');
                  }),
                  buildMenuItem(context, 'Logout', Icons.logout, () {
                    print('Logout clicked');
                    context.read<AuthenticationBloc>().add(const LogOutEvent());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, String title, IconData icon,
      VoidCallback onClicked) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onClicked,
    );
  }
}

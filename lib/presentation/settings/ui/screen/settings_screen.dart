import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_state.dart';

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
    context.read<EditProfileBloc>().add(const GetInformationUser());
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
            BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (context, state) {
                if (state.status == BlocStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == BlocStatus.success) {
                  final user = state.data as UserEntity;
                  final ava = user.avatarUrl ??
                      "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg";
                  final username = user.firstName ?? "Guest";
                  final role = user.account?.role?.name.toUpperCase();

                  return Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, left: 15.h), // Tạo khoảng cách từ trên xuống
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: NetworkImage(ava),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              role ?? "user",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 25.h),
            // Menu List
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(context, 'Personal Data', Icons.person, () {
                    print('Personal Data clicked');
                    context.pushNamed(RouteDefine.editProfile);
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
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: onClicked,
    );
  }
}

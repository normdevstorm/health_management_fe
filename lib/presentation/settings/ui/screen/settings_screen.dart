import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/app/utils/date_converter.dart';
import 'package:health_management/domain/doctor/usecases/doctor_usecase.dart';
import 'package:health_management/domain/doctor_schedule/usecases/doctor_schedule_usecase.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:permission_handler/permission_handler.dart';

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

  // void _navigateToEditProfile() {
  //   context.pushNamed(RouteDefine.editProfile);
  // }

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
                    context.pushNamed(RouteDefine.editProfile);
                  }),
                  buildMenuItem(context, 'Settings', Icons.settings, () {}),
                  buildMenuItem(context, 'My Articles', Icons.receipt_long, () {
                    context.goNamed(RouteDefine.article);
                  }),
                  buildMenuItem(
                      context, 'Referral Code', Icons.card_giftcard, () {}),
                  buildMenuItem(context, 'FAQs', Icons.help_outline, () {}),
                  buildMenuItem(context, 'Our Handbook', Icons.book, () {}),
                  buildMenuItem(context, 'Logout', Icons.logout, () {
                    context.read<AuthenticationBloc>().add(const LogOutEvent());
                  }),
                  if ((context.read<EditProfileBloc>().state.data as UserEntity)
                          .account
                          ?.role ==
                      Role.doctor)
                    buildMenuItem(
                      context,
                      'Export schedules',
                      Icons.import_export,
                      () async {
                        final doctorId = (context
                                .read<EditProfileBloc>()
                                .state
                                .data as UserEntity)
                            .doctorProfile
                            ?.id;
                        if (doctorId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Only available for doctors')),
                          );
                          return;
                        }

                        // Default date range (current month)
                        final now = DateTime.now();
                        DateTime startDate = DateTime(now.year, now.month, 1);
                        DateTime endDate = DateTime(now.year, now.month + 1, 0);

                        final DateTimeRange? result = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                          initialDateRange: DateTimeRange(
                            start: startDate,
                            end: endDate,
                          ),
                        );

                        if (result != null) {
                          startDate = result.start;
                          endDate = result.end;

                          try {
                            final String? resultFilePath =
                                await getIt<DoctorScheduleUseCase>()
                                    .exportDoctorSchedules(
                              doctorId,
                              startDate.toIso8601String(),
                              endDate.toIso8601String(),
                              'schedules_dr_${doctorId}_${DateConverter.convertToYearMonthDay(startDate)}_${DateConverter.convertToYearMonthDay(endDate)}.xlsx',
                            );
                            if (resultFilePath == null) {
                              throw Exception('Saved path is null');
                            }
                            ToastManager.showToast(
                                context: context,
                                message: "'Schedules exported successfully'");
                          } catch (e) {
                            ToastManager.showToast(
                                context: context, message: 'Failed to export');
                          }
                        }
                      },
                    )
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import '../widgets/app_bar_icon_button.dart';
import '../widgets/doctor_info_summary_card.dart';
import '../widgets/doctor_profile_app_bar.dart';
import '../widgets/doctor_stat_list_view.dart';

class DoctorProfileDetailsScreen extends StatelessWidget {
  final UserEntity doctor;

  const DoctorProfileDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DoctorProfileAppBar(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                80.verticalSpace,
                DoctorStatListview(
                  doctor: doctor,
                ),
                SizedBox(height: 20.h),
                DoctorAbout(doctor: doctor),
                20.verticalSpace,
                DoctorInfoSummaryCard(doctor: doctor),
              ],
            ))
          ],
        ),
        Align(
          alignment: Alignment.center,
          heightFactor: 3.8,
          child: DoctorInfoSummaryCard(doctor: doctor),
        ),
      ]),
    );
  }
}

class DoctorAbout extends StatelessWidget {
  const DoctorAbout({
    super.key,
    required this.doctor,
  });

  final UserEntity doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Doctor",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            doctor.doctorProfile?.about ?? "",
            style: TextStyle(fontSize: 16.sp, color: Color(0xFF283545)),
          ),
        ],
      ),
    );
  }
}

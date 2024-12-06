import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/user/entities/user_entity.dart';

class DoctorInfoSummaryCard extends StatelessWidget {
  const DoctorInfoSummaryCard({
    super.key,
    required this.doctor,
  });

  final UserEntity doctor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.h,
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xff1c6ba4), width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: ListTile(
        minVerticalPadding: 30.h,
        title: const Text("Specialization"),
        subtitle: Text(doctor.doctorProfile?.specialization?.name.toUpperCase() ?? ""),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/placeholder.png",
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
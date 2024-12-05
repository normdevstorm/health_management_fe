import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/user/entities/user_entity.dart';

class DoctorStatListview extends StatelessWidget {
  final UserEntity doctor;
  const DoctorStatListview({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => Center(
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                color: const Color(0xffe4e8f1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Qualification",
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF283545),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  doctor.doctorProfile?.qualification.toString() ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: const Color(0xFF283545)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

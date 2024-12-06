import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_bar_icon_button.dart';

class DoctorProfileAppBar extends StatelessWidget {
  const DoctorProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff1c6ba4),
      ),
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const AppBarIconButton(
                size: 30,
              ),
              Text(
                'Doctor Profile',
                style: TextStyle(
                    color: const Color(0xFFeff5f9),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              const AppBarIconButton(
                size: 30,
                icon: Icons.more_vert,
              ),
            ],
          )
        ],
      ),
    );
  }
}
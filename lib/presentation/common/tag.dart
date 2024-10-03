import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';

class TagChip extends StatelessWidget {
  final double height;
  final double fontSize;
  final Color fontColor;
  final Color inactiveColor;
  final Color activeColor;
  final IconData? icon;
  final String text;
  final bool isActive;

  const TagChip({
    super.key,
    this.height = 40.0,
    this.fontSize = 12.0,
    this.fontColor = Colors.black,
    this.inactiveColor = const Color(0xFFEEEEEE),
    this.activeColor = ColorManager.buttonColorLight,
    this.isActive = false,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicWidth(
          child: Container(
            height: height.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: ShapeDecoration(
              color: isActive ? activeColor : inactiveColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fontColor,
                    fontSize: fontSize.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (icon != null) SizedBox(width: 5.w),
                if (icon != null)
                  Icon(icon, size: fontSize.sp, color: fontColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

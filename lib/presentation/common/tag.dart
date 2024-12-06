import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';

class TagChip extends StatelessWidget {
  final double height;
  final double? width;
  final double fontSize;
  final Color fontColor;
  final Color unselectedColor;
  final Color selectedColor;
  final IconData? icon;
  final String text;
  final bool isSelected;
  final bool active;
  final VoidCallback? onTap;

  const TagChip({
    super.key,
    this.height = 35.0,
    this.width,
    this.fontSize = 12.0,
    this.fontColor = Colors.black,
    this.unselectedColor = const Color(0xFFEEEEEE),
    this.selectedColor = Colors.green,
    this.isSelected = false,
    this.icon,
    this.active = true,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          IntrinsicWidth(
            child: Container(
              foregroundDecoration: active
                  ? null
                  : BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20))),
              height: height.h,
              width: width?.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: ShapeDecoration(
                color: (isSelected && active ? selectedColor : unselectedColor),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: ColorManager.primaryColorLight,
                      style: BorderStyle.solid,
                      width: 1.sp),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20)),
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
                      color: isSelected && active ? Colors.white : fontColor,
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
      ),
    );
  }
}

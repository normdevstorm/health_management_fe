import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final Widget? icon;
  final String text;
  final VoidCallback? onPressed;

  const Button({
    super.key,
    this.width = 327.0,
    this.height = 56.0,
    this.fontSize = 18.0,
    this.fontColor = Colors.white,
    this.backgroundColor = const Color(0xFF232323),
    this.icon,
    this.text = 'button',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 17.h),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [backgroundColor, Colors.black],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
            SizedBox(width: 8.w),
            if (icon != null) ...[
              Container(
                width: 24.w,
                height: 24.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: icon,
              )
            ],
          ],
        ),
      ),
    );
  }
}

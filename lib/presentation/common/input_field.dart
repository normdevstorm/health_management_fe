// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextFormField extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final Icon? icon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  CommonTextFormField({
    super.key,
    this.height = 65.0,
    this.width = 327.0,
    this.fontSize = 14.0,
    this.fontColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.icon,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: height,
        width: width,
        child: TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(fontSize: fontSize.sp, color: fontColor),
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: fontSize.sp),
            prefixIcon: icon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                  color: const Color(0x00cecece),
                  width: 1.0.w,
                  style: BorderStyle.solid),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                  color: Colors.red, width: 1.0.w, style: BorderStyle.solid),
            ),
          ).copyWith(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              fillColor: const Color(0x00cecece),
              filled: true),
        ),
      ),
    );
  }
}

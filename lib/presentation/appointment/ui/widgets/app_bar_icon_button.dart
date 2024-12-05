import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarIconButton extends StatelessWidget {
  final double size;
  final IconData icon;
  const AppBarIconButton({
    this.size = 35,
    this.icon = Icons.arrow_back,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            iconSize: WidgetStateProperty.all(size.r),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            side: WidgetStateProperty.all(const BorderSide(
                color: Color(0xFFeff5f9),
                style: BorderStyle.solid,
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignOutside))),
        onPressed: () {},
        icon: Icon(icon));
  }
}
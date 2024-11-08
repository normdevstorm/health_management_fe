import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectItemWidget extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const SelectItemWidget(
      {required this.child,
      this.isSelected = false,
      super.key,
      this.onTap,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  color: Colors.blue, style: BorderStyle.solid, width: 3.sp)
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}

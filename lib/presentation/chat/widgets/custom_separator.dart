import 'package:flutter/material.dart';

class CustomSeparator extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final double borderRadius; // Độ cong của border
  const CustomSeparator({
    Key? key,
    required this.color,
    required this.height,
    required this.width,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( // Căn giữa phân cách
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius), // Bo tròn border
            color: color, // Màu sắc
          ),
        ),
      ),
    );
  }
}


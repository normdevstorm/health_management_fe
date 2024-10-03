import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Make sure to import your TagChip class

class TagList extends StatelessWidget {
  final List<Widget> tags;

  const TagList({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0.w, // Adjust spacing between tags as needed
      runSpacing: 8.0.h, // Adjust spacing between lines as needed
      children: tags,
    );
  }
}

import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap; // Thêm callback onTap để xử lý sự kiện tap

  const TagChip({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap, // Nhận vào callback onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Khi bấm vào, sẽ gọi hàm onTap
      child: Chip(
        label: Text(text),
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}

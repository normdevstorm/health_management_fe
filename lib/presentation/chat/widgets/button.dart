import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Button({required Key key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Đặt màu nền là transparent
        foregroundColor: Colors.white, // Đặt màu chữ
        elevation:
            0, // Đặt độ nâng lên (elevation) là 0 để loại bỏ hiệu ứng shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Đặt bo góc
        ),
        padding: const EdgeInsets.only(
            left: 20, top: 6, right: 20, bottom: 6), // Đặt độ dày của nút
        shadowColor:
            Colors.transparent, // Đặt màu của bóng (shadow) là transparent
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.69, -0.72),
            end: Alignment(0.69, 0.72),
            colors: [
              Color(0xFF00E5E5),
              Color(0xFF72A4F1),
              Color(0xFFE860FF),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0), // Đặt bo góc
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

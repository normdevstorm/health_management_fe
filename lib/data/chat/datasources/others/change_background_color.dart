
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Lưu gradient vào SharedPreferences
Future<void> saveBackground(List<Color> gradientColors) async {
  final prefs = await SharedPreferences.getInstance();
  final gradientStringList = gradientColors.map((color) => color.value.toRadixString(16)).toList();
  await prefs.setStringList('backgroundGradient', gradientStringList);
}

// Đọc gradient từ SharedPreferences
Future<List<Color>> getBackground() async {
  final prefs = await SharedPreferences.getInstance();
  final gradientStringList = prefs.getStringList('backgroundGradient');
  if (gradientStringList != null) {
    return gradientStringList.map((colorString) => Color(int.parse(colorString, radix: 16))).toList();
  } else {
    // Trả về một danh sách mặc định nếu không có gradient được lưu
    return [Colors.white, Colors.white]; // hoặc bất kỳ giá trị mặc định nào bạn muốn
  }
}



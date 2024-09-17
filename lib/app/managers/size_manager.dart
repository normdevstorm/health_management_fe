import 'package:flutter/material.dart';

class SizeManager {
  // Default sizes
  //TODO: Config with ScreenUtils later
  static const double defaultCommonPadding = 16.0;
  static const double defaultCommonMargin = 16.0;
  static const double defaultCommonBorderRadius = 8.0;
  static const double defaultCommonFontSize = 16.0;
}
 ///TODO: Config with ScreenUtils later
extension ScreenUtils on int {
  SizedBox get verticalSpace {
    return SizedBox(height: toDouble());
  }

    SizedBox get horizontalSpace {
    return SizedBox(width: toDouble());
  }
}


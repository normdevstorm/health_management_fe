import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app.dart';

class ChuckerLogButton extends StatelessWidget {
  const ChuckerLogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChuckerFlutter.showChuckerScreen();
      },
      child: Text('LOG',
          style: TextStyle(
              fontSize: 15.sp, color: ColorManager.textBlockColorLight)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app.dart';

class ShadowEdgeWidget extends StatelessWidget {
  const ShadowEdgeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(height: 24.h),
      Align(
        alignment: Alignment.topCenter,
        heightFactor: 1.5,
        child: Container(
          height: 10,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Colors.transparent,
              //     ColorManager.buttonShadowColorLight,
              //   ],
              // ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.buttonShadowColorLight.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]),
        ),
      )
    ]);
  }
}

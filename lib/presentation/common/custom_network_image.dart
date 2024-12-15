import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.avatarUrl,
    this.width = 100,
    this.height = 80,
  });

  final String? avatarUrl;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: avatarUrl ?? 'assets/images/placeholder.png',
      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/placeholder.png',
        height: height.h,
        width: width.w,
        fit: BoxFit.cover,
      ),
      placeholder: 'assets/images/circle_progress_indicator.gif',
      width: width.w,
      height: height.h,
      fit: BoxFit.cover,
    );
  }
}

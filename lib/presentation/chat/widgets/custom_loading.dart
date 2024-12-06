import 'package:flutter/cupertino.dart';
import 'package:loading_animations/loading_animations.dart';

class CustomLoading extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final double size;
  final double opacity;
  const CustomLoading({
    Key? key,
    required this.borderColor,
    required this.backgroundColor,
    required this.size,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: opacity, // Đặt độ mờ ở đây
            child: LoadingBouncingGrid.square(
              borderColor: borderColor,
              borderSize: 3.0,
              size: size,
              backgroundColor: backgroundColor,
              duration: const Duration(milliseconds: 500),
            ),
          ),
        ],
      ),
    );
  }
}

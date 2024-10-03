import 'package:flutter/material.dart';

class CommonBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final double height;
  final double width;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CommonBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.height = 300.0,
    this.width = double.infinity,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(child: content),
        ],
      ),
    );
  }
}

void showCommonBottomSheet({
  required BuildContext context,
  required String title,
  required Widget content,
  double height = 300.0,
  double width = double.infinity,
  Color backgroundColor = Colors.white,
  EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
}) {
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CommonBottomSheet(
        title: title,
        content: content,
        height: height,
        width: width,
        backgroundColor: backgroundColor,
        padding: padding,
      );
    },
  );
}

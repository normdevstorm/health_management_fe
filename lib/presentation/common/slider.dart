import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class CustomSlider extends StatelessWidget {
  ValueChanged<int>? onDotClicked;
  final PageController controller;
  final List<Widget> pages;
  final double pageHeight;

  CustomSlider({
    super.key,
    required this.controller,
    this.onDotClicked,
    required this.pages,
    this.pageHeight = 240,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: pageHeight.h,
          child: PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: const ExpandingDotsEffect(
              activeDotColor: ColorManager.buttonEnabledColorLight),
          onDotClicked: onDotClicked ??
              (value) {
                controller.animateToPage(value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              },
          axisDirection: Axis.horizontal,
        ),
      ],
    );
  }
}

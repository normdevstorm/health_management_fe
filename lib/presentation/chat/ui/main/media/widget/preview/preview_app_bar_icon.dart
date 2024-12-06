import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:flutter/material.dart';

class PreviewAppBarIcon extends StatelessWidget {
  final VoidCallback? onPressCropped;
  final bool isVideoPreview;

  const PreviewAppBarIcon(
      {super.key, this.onPressCropped, required this.isVideoPreview});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.clear),
          color: AppColor.primaryColor,
          iconSize: 30,
        ),
        const Spacer(),
        isVideoPreview
            ? const SizedBox()
            : IconButton(
                onPressed: onPressCropped,
                icon: Icon(Icons.crop, color: AppColor.primaryColor),
                iconSize: 27,
              ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.emoji_emotions),
          color: AppColor.primaryColor,
          iconSize: 27,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.title),
          color: AppColor.primaryColor,
          iconSize: 27,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          color: AppColor.primaryColor,
          iconSize: 27,
        )
      ],
    );
  }
}

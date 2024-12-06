import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double? radius;
  const CustomImage({super.key, required this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    final height = radius != null ? radius! * 2 : null;
    return ClipOval(
      child: CachedNetworkImage(
        height: height,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Image.asset("assets/images/default_avatar.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }
}

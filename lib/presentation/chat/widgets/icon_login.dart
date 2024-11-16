import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconLogin extends StatelessWidget {
  final Function onPress;
  const IconLogin({
    Key? key,
    required this.onPress,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: SizedBox(
        width: 48,
        height: 48,
        child: Opacity(
          opacity: 0.80,
          child: SizedBox(
            width: 48,
            height: 48,
            child: SvgPicture.asset(
              path,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

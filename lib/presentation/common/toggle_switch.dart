import 'package:flutter/material.dart';
import 'package:health_management/app/app.dart';

class ToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color thumbColor;
  final Color backgroundColor;

  const ToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 40.0,
    this.thumbColor = ColorManager.buttonEnabledColorLight,
    this.backgroundColor = ColorManager.backgroundColorLight,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size / 40.0,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: thumbColor,
        activeTrackColor: backgroundColor,
        trackOutlineColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return thumbColor.withOpacity(0.5); // Use the default color.
        }),
      ),
    );
  }
}

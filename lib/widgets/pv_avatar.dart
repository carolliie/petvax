import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class PvAvatar extends StatelessWidget {
  final double size;
  final Color background;
  final Color foreground;
  final String? label;
  final Widget? child;
  final Border? border;

  const PvAvatar({
    super.key,
    this.size = 44,
    this.background = AppColors.soft2,
    this.foreground = AppColors.deep,
    this.label,
    this.child,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      alignment: Alignment.center,
      child: child ??
          (label != null
              ? Text(
                  label![0].toUpperCase(),
                  style: AppTextStyles.sans(
                    size: size * 0.4,
                    weight: FontWeight.w900,
                    color: foreground,
                  ),
                )
              : null),
    );
  }
}

import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

enum TagVariant { green, amber, red, soft }

class PvTag extends StatelessWidget {
  final String label;
  final TagVariant variant;
  final Widget? icon;

  const PvTag({super.key, required this.label, this.variant = TagVariant.soft, this.icon});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (variant) {
      TagVariant.green => (AppColors.greenBg, const Color(0xFF2F7D5B)),
      TagVariant.amber => (AppColors.amberBg, const Color(0xFF9C6A1C)),
      TagVariant.red   => (AppColors.redBg,   const Color(0xFFA8404F)),
      TagVariant.soft  => (AppColors.chip,     AppColors.deep),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 5)],
          Text(label, style: AppTextStyles.sans(size: 11, weight: FontWeight.w800, color: fg)),
        ],
      ),
    );
  }
}

class PvPill extends StatelessWidget {
  final String label;
  final bool filled;
  final Widget? icon;

  const PvPill({super.key, required this.label, this.filled = true, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? AppColors.deep : AppColors.chip,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 6)],
          Text(
            label,
            style: AppTextStyles.sans(size: 12, weight: FontWeight.w800, color: filled ? Colors.white : AppColors.deep),
          ),
        ],
      ),
    );
  }
}

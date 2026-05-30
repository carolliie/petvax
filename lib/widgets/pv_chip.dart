import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class PvChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget? leading;
  final VoidCallback? onTap;

  const PvChip({
    super.key,
    required this.label,
    this.selected = false,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.deep : Colors.white,
          border: Border.all(
            color: selected ? AppColors.deep : AppColors.line,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 6)],
            Text(
              label,
              style: AppTextStyles.sans(
                size: 13,
                weight: FontWeight.w800,
                color: selected ? Colors.white : AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class PvPushHeader extends StatelessWidget {
  final String title;
  final Widget? right;

  const PvPushHeader({super.key, required this.title, this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.line, width: 1.5),
              ),
              child: const Icon(Icons.chevron_left, color: AppColors.deep, size: 26),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: AppTextStyles.h3())),
          ?right,
        ],
      ),
    );
  }
}

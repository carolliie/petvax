import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';
import 'paw_icon.dart';

class CrossPaw extends StatelessWidget {
  final double size;
  final Color crossColor;
  final Color pawColor;

  const CrossPaw({
    super.key,
    this.size = 120,
    this.crossColor = AppColors.deep,
    this.pawColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final ch = _hex(crossColor);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.string(
            '<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">'
            '<rect x="33" y="5" width="34" height="90" rx="11" fill="$ch"/>'
            '<rect x="5" y="33" width="90" height="34" rx="11" fill="$ch"/>'
            '</svg>',
            width: size,
            height: size,
          ),
          PawIcon(size: size * 0.4, color: pawColor),
        ],
      ),
    );
  }

  static String _hex(Color c) {
    final r = (c.r * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (c.g * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (c.b * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}

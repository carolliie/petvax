import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SyringeIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const SyringeIcon({
    super.key,
    this.size = 22,
    required this.color,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final h = _hex(color);
    final sw = strokeWidth.toString();
    return SvgPicture.string(
      '<svg viewBox="0 0 24 24" fill="none" stroke="$h" stroke-width="$sw"'
      ' stroke-linecap="round" stroke-linejoin="round"'
      ' xmlns="http://www.w3.org/2000/svg">'
      '<path d="M18 2l4 4"/>'
      '<path d="M14.5 4.5l5 5"/>'
      '<path d="M17 7 7 17l-3 .5L3.5 21 3 20.5l.5-3.5L4 14 14 4"/>'
      '<path d="M9.5 9.5l2 2"/>'
      '<path d="M7 12l2 2"/>'
      '<path d="M12 7l2 2"/>'
      '</svg>',
      width: size,
      height: size,
    );
  }

  static String _hex(Color c) {
    final r = (c.r * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (c.g * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (c.b * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}

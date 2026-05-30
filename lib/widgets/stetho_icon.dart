import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StethoIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const StethoIcon({
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
      '<path d="M4 3v6a5 5 0 0 0 10 0V3"/>'
      '<path d="M4 3H3"/>'
      '<path d="M14 3h1"/>'
      '<path d="M9 14v2a5 5 0 0 0 5 5 5 5 0 0 0 5-5v-3"/>'
      '<circle cx="19" cy="10" r="2.2"/>'
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

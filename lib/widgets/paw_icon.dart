import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PawIcon extends StatelessWidget {
  final double size;
  final Color color;

  const PawIcon({super.key, this.size = 22, required this.color});

  @override
  Widget build(BuildContext context) {
    final h = _hex(color);
    return SvgPicture.string(
      '<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">'
      '<ellipse cx="16" cy="21" rx="7.2" ry="6" fill="$h"/>'
      '<ellipse cx="7.5" cy="14.5" rx="3.1" ry="3.7" fill="$h"/>'
      '<ellipse cx="24.5" cy="14.5" rx="3.1" ry="3.7" fill="$h"/>'
      '<ellipse cx="12" cy="9" rx="2.7" ry="3.4" fill="$h"/>'
      '<ellipse cx="20" cy="9" rx="2.7" ry="3.4" fill="$h"/>'
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

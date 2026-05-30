import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class PetDuo extends StatelessWidget {
  final double width;
  final Color stroke;
  final double strokeWidth;
  final Color bg;

  const PetDuo({
    super.key,
    this.width = 300,
    this.stroke = Colors.white,
    this.strokeWidth = 5,
    this.bg = AppColors.lilac,
  });

  @override
  Widget build(BuildContext context) {
    final sh = _hex(stroke);
    final bh = _hex(bg);
    final sw = strokeWidth.toString();
    final swm = (strokeWidth - 1.2).toStringAsFixed(1);
    return SvgPicture.string(
      '<svg width="300" viewBox="0 0 300 220" fill="none"'
      ' xmlns="http://www.w3.org/2000/svg">'
      // Dog body
      '<ellipse cx="132" cy="116" rx="17" ry="42"'
      ' transform="rotate(-20 132 116)" fill="$bh" stroke="$sh" stroke-width="$sw"'
      ' stroke-linecap="round" stroke-linejoin="round"/>'
      '<ellipse cx="242" cy="116" rx="17" ry="42"'
      ' transform="rotate(20 242 116)" fill="$bh" stroke="$sh" stroke-width="$sw"'
      ' stroke-linecap="round" stroke-linejoin="round"/>'
      '<ellipse cx="187" cy="118" rx="64" ry="60" fill="$bh" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      // Dog features
      '<circle cx="165" cy="106" r="5.5" fill="$sh"/>'
      '<circle cx="209" cy="106" r="5.5" fill="$sh"/>'
      '<ellipse cx="187" cy="138" rx="9" ry="6.5" fill="$sh"/>'
      '<path d="M187 144 C187 157 176 161 168 156" fill="none" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      '<path d="M187 144 C187 157 198 161 206 156" fill="none" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      // Cat body
      '<path d="M62 132 L73 90 L103 124 Z" fill="$bh" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      '<path d="M134 132 L123 90 L93 124 Z" fill="$bh" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      '<ellipse cx="98" cy="160" rx="50" ry="46" fill="$bh" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      // Cat whiskers
      '<path d="M52 156 L18 150" fill="none" stroke="$sh" stroke-width="$swm"'
      ' stroke-linecap="round"/>'
      '<path d="M52 166 L18 168" fill="none" stroke="$sh" stroke-width="$swm"'
      ' stroke-linecap="round"/>'
      '<path d="M144 156 L178 150" fill="none" stroke="$sh" stroke-width="$swm"'
      ' stroke-linecap="round"/>'
      '<path d="M144 166 L178 168" fill="none" stroke="$sh" stroke-width="$swm"'
      ' stroke-linecap="round"/>'
      // Cat eyes
      '<circle cx="80" cy="152" r="4.8" fill="$sh"/>'
      '<circle cx="116" cy="152" r="4.8" fill="$sh"/>'
      // Cat nose/mouth
      '<path d="M92 166 L98 172 L104 166" fill="none" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      '<path d="M98 172 C98 180 92 182 87 179" fill="none" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      '<path d="M98 172 C98 180 104 182 109 179" fill="none" stroke="$sh"'
      ' stroke-width="$sw" stroke-linecap="round" stroke-linejoin="round"/>'
      '</svg>',
      width: width,
    );
  }

  static String _hex(Color c) {
    final r = (c.r * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (c.g * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (c.b * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle serif({
    double size = 16,
    FontWeight weight = FontWeight.w900,
    Color color = AppColors.deep,
    FontStyle style = FontStyle.normal,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontStyle: style,
        letterSpacing: -0.01 * size,
      );

  static TextStyle sans({
    double size = 14,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.ink,
  }) =>
      GoogleFonts.mulish(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  static TextStyle h1({Color color = AppColors.deep, double size = 32}) =>
      serif(size: size, weight: FontWeight.w900, color: color);

  static TextStyle h2() => serif(size: 23, weight: FontWeight.w800);

  static TextStyle h3({double size = 18}) =>
      serif(size: size, weight: FontWeight.w800);

  static TextStyle eyebrow() => sans(
        size: 11,
        weight: FontWeight.w800,
        color: AppColors.muted,
      ).copyWith(letterSpacing: 0.14 * 11);

  static TextStyle meta({double size = 13}) =>
      sans(size: size, weight: FontWeight.w600, color: AppColors.muted);

  static TextStyle label() =>
      sans(size: 12.5, weight: FontWeight.w800, color: AppColors.deep);
}

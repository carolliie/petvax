import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class HatchBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Widget? child;

  const HatchBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: _HatchPainter(),
          child: child,
        ),
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppColors.soft2,
    );
    final stripePaint = Paint()
      ..color = const Color(0xFF543075).withValues(alpha: 0.10)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.butt;
    for (double i = -size.height; i < size.width + size.height; i += 14) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), stripePaint);
    }
  }

  @override
  bool shouldRepaint(_HatchPainter old) => false;
}

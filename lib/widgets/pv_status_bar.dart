import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class PvStatusBar extends StatelessWidget {
  final bool dark;

  const PvStatusBar({super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    final color = dark ? Colors.white : AppColors.deep;
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(26, 0, 26, 8),
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:41', style: AppTextStyles.sans(size: 15, weight: FontWeight.w800, color: color)),
          Row(
            children: [
              _SignalIcon(color: color),
              const SizedBox(width: 6),
              _WifiIcon(color: color),
              const SizedBox(width: 6),
              _BatteryIcon(color: color),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignalIcon extends StatelessWidget {
  final Color color;
  const _SignalIcon({required this.color});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(18, 12), painter: _SignalPainter(color));
  }
}

class _SignalPainter extends CustomPainter {
  final Color color;
  _SignalPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color;
    final bars = [
      Rect.fromLTWH(0, 7, 3, 5),
      Rect.fromLTWH(5, 4.5, 3, 7.5),
      Rect.fromLTWH(10, 2, 3, 10),
    ];
    for (final b in bars) {
      canvas.drawRRect(RRect.fromRectAndRadius(b, const Radius.circular(1)), p);
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(15, 0, 3, 12), const Radius.circular(1)),
      Paint()..color = color.withValues(alpha: 0.4),
    );
  }
  @override
  bool shouldRepaint(_SignalPainter old) => old.color != color;
}

class _WifiIcon extends StatelessWidget {
  final Color color;
  const _WifiIcon({required this.color});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(16, 12), painter: _WifiPainter(color));
  }
}

class _WifiPainter extends CustomPainter {
  final Color color;
  _WifiPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(8, 11.2)
      ..lineTo(1.2, 4.4)
      ..cubicTo(5.0, 0.6, 11.0, 0.6, 14.8, 4.4)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }
  @override
  bool shouldRepaint(_WifiPainter old) => old.color != color;
}

class _BatteryIcon extends StatelessWidget {
  final Color color;
  const _BatteryIcon({required this.color});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(26, 13), painter: _BatteryPainter(color));
  }
}

class _BatteryPainter extends CustomPainter {
  final Color color;
  _BatteryPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    // Outline
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(1, 1, 21, 11), const Radius.circular(3)),
      Paint()
        ..color = color.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
    // Fill
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(3, 3, 15, 7), const Radius.circular(1.5)),
      Paint()..color = color,
    );
    // Nub
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(23.5, 4.5, 2, 4), const Radius.circular(1)),
      Paint()..color = color.withValues(alpha: 0.5),
    );
  }
  @override
  bool shouldRepaint(_BatteryPainter old) => old.color != color;
}

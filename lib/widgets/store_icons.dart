import 'package:flutter/material.dart';

/// Pixel-perfect vector icon for Google Play Store.
/// Renders reliably across all browsers without external font tree-shaking issues.
class GooglePlayIcon extends StatelessWidget {
  final double size;
  final Color? color;
  final bool isMultiColor;

  const GooglePlayIcon({
    super.key,
    this.size = 14,
    this.color,
    this.isMultiColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GooglePlayPainter(
          color: color ?? Colors.white,
          isMultiColor: isMultiColor,
        ),
      ),
    );
  }
}

class _GooglePlayPainter extends CustomPainter {
  final Color color;
  final bool isMultiColor;

  _GooglePlayPainter({required this.color, required this.isMultiColor});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    if (isMultiColor) {
      final pBlue = Paint()..color = const Color(0xFF00C3FF);
      final pRed = Paint()..color = const Color(0xFFFF3D00);
      final pYellow = Paint()..color = const Color(0xFFFFC107);
      final pGreen = Paint()..color = const Color(0xFF00E676);

      final pathBlue = Path()
        ..moveTo(w * 0.10, h * 0.08)
        ..lineTo(w * 0.56, h * 0.50)
        ..lineTo(w * 0.10, h * 0.92)
        ..close();
      canvas.drawPath(pathBlue, pBlue);

      final pathGreen = Path()
        ..moveTo(w * 0.10, h * 0.08)
        ..lineTo(w * 0.56, h * 0.50)
        ..lineTo(w * 0.70, h * 0.36)
        ..lineTo(w * 0.22, h * 0.04)
        ..close();
      canvas.drawPath(pathGreen, pGreen);

      final pathYellow = Path()
        ..moveTo(w * 0.10, h * 0.92)
        ..lineTo(w * 0.56, h * 0.50)
        ..lineTo(w * 0.70, h * 0.64)
        ..lineTo(w * 0.22, h * 0.96)
        ..close();
      canvas.drawPath(pathYellow, pYellow);

      final pathRed = Path()
        ..moveTo(w * 0.56, h * 0.50)
        ..lineTo(w * 0.70, h * 0.36)
        ..lineTo(w * 0.94, h * 0.50)
        ..lineTo(w * 0.70, h * 0.64)
        ..close();
      canvas.drawPath(pathRed, pRed);
    } else {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      // Rounded play triangle
      final path = Path()
        ..moveTo(w * 0.15, h * 0.08)
        ..lineTo(w * 0.88, h * 0.50)
        ..lineTo(w * 0.15, h * 0.92)
        ..close();
      canvas.drawPath(path, paint);

      // Subtle fold overlay
      final foldPaint = Paint()
        ..color = Colors.black.withOpacity(0.18)
        ..strokeWidth = w * 0.08
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(w * 0.15, h * 0.08), Offset(w * 0.55, h * 0.50), foldPaint);
      canvas.drawLine(Offset(w * 0.15, h * 0.92), Offset(w * 0.55, h * 0.50), foldPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Pixel-perfect vector icon for Apple App Store.
/// Renders reliably across all browsers without external font tree-shaking issues.
class AppleStoreIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const AppleStoreIcon({
    super.key,
    this.size = 15,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AppleStorePainter(color: color ?? Colors.white),
      ),
    );
  }
}

class _AppleStorePainter extends CustomPainter {
  final Color color;

  _AppleStorePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Apple Leaf
    final leaf = Path()
      ..moveTo(w * 0.52, h * 0.02)
      ..cubicTo(w * 0.60, h * 0.02, w * 0.72, h * 0.08, w * 0.68, h * 0.22)
      ..cubicTo(w * 0.58, h * 0.22, w * 0.46, h * 0.14, w * 0.52, h * 0.02)
      ..close();
    canvas.drawPath(leaf, paint);

    // Apple Body with bite cutout
    final body = Path()
      ..moveTo(w * 0.48, h * 0.26)
      ..cubicTo(w * 0.38, h * 0.26, w * 0.28, h * 0.32, w * 0.18, h * 0.45)
      ..cubicTo(w * 0.08, h * 0.62, w * 0.16, h * 0.86, w * 0.28, h * 0.98)
      ..cubicTo(w * 0.35, h * 1.04, w * 0.43, h * 1.04, w * 0.50, h * 0.98)
      ..cubicTo(w * 0.57, h * 0.92, w * 0.65, h * 0.92, w * 0.72, h * 0.98)
      ..cubicTo(w * 0.78, h * 1.04, w * 0.86, h * 1.04, w * 0.92, h * 0.96)
      ..cubicTo(w * 0.98, h * 0.88, w * 0.86, h * 0.78, w * 0.86, h * 0.66)
      ..cubicTo(w * 0.86, h * 0.54, w * 0.97, h * 0.48, w * 0.92, h * 0.42)
      ..cubicTo(w * 0.86, h * 0.34, w * 0.74, h * 0.26, w * 0.64, h * 0.26)
      ..cubicTo(w * 0.56, h * 0.26, w * 0.52, h * 0.30, w * 0.48, h * 0.26)
      ..close();
    canvas.drawPath(body, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

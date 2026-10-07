import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.color = const Color(0xFFCBD5E1),
    this.strokeWidth = 1.2,
    this.dashWidth = 5.0,
    this.dashSpace = 4.0,
    this.borderRadius = 10.0,
    this.backgroundColor,
    this.height,
    this.width,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: color,
            strokeWidth: strokeWidth,
            dashWidth: dashWidth,
            dashSpace: dashSpace,
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double length = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        final extractPath = metric.extractPath(distance, distance + length);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

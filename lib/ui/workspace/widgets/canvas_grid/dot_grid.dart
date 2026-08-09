import 'dart:ui';

import 'package:iux/ui/workspace/widgets/canvas_grid/grid_painter.dart';

class DotGrid extends GridPainter {
  final Color dotColor;
  final double dotSize;
  final double dotSpacing;

  DotGrid({
    required super.viewportRect,
    required this.dotColor,
    this.dotSize = 2,
    this.dotSpacing = 50,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..strokeWidth = dotSize
      ..strokeCap = StrokeCap.round;

    final startX = (viewportRect.left / dotSpacing).floor() * dotSpacing;
    final endX = (viewportRect.right / dotSpacing).ceil() * dotSpacing;
    final startY = (viewportRect.top / dotSpacing).floor() * dotSpacing;
    final endY = (viewportRect.bottom / dotSpacing).ceil() * dotSpacing;

    final points = <Offset>[];

    for (double y = startY; y <= endY; y += dotSpacing) {
      for (double x = startX; x <= endX; x += dotSpacing) {
        points.add(Offset(x, y));
      }
    }

    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(DotGrid oldDelegate) {
    return oldDelegate.viewportRect != viewportRect ||
        oldDelegate.dotColor != dotColor ||
        oldDelegate.dotSize != dotSize ||
        oldDelegate.dotSpacing != dotSpacing;
  }
}

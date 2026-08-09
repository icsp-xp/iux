import 'dart:ui';

import 'package:iux/ui/workspace/widgets/canvas_grid/grid_painter.dart';

class LineGrid extends GridPainter {
  final Color lineColor;
  final double lineWidth;
  final double lineSpacing;

  LineGrid({
    required super.viewportRect,
    required this.lineColor,
    this.lineWidth = 1,
    this.lineSpacing = 50,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    final startX = (viewportRect.left / lineSpacing).floor() * lineSpacing;
    final endX = (viewportRect.right / lineSpacing).ceil() * lineSpacing;

    final startY = (viewportRect.top / lineSpacing).floor() * lineSpacing;
    final endY = (viewportRect.bottom / lineSpacing).ceil() * lineSpacing;

    final lines = <Offset>[];

    for (double x = startX; x <= endX; x += lineSpacing) {
      lines.add(Offset(x, viewportRect.top));
      lines.add(Offset(x, viewportRect.bottom));
    }

    for (double y = startY; y <= endY; y += lineSpacing) {
      lines.add(Offset(viewportRect.left, y));
      lines.add(Offset(viewportRect.right, y));
    }

    canvas.drawPoints(PointMode.lines, lines, paint);
  }

  @override
  bool shouldRepaint(covariant LineGrid oldDelegate) {
    return oldDelegate.viewportRect != viewportRect ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.lineSpacing != lineSpacing;
  }
}

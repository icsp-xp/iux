import 'package:flutter/widgets.dart';

abstract class CanvasComponentPainter extends CustomPainter {
  final Offset position;
  final Size size;
  final double rotation;

  CanvasComponentPainter({
    required this.position,
    required this.size,
    this.rotation = 0,
    super.repaint,
  });
}

import 'package:flutter/widgets.dart';

abstract class GridPainter extends CustomPainter {
  final Rect viewportRect;

  const GridPainter({required this.viewportRect, super.repaint});
}

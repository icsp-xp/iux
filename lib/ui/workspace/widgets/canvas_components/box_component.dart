import 'package:flutter/widgets.dart';
import 'package:iux/ui/workspace/widgets/canvas_components/canvas_component.dart';

class BoxComponent extends CanvasComponent {
  const BoxComponent({
    required super.position,
    required super.size,
    super.rotation,
  });
  
  BoxComponent.fromModifiedProperties(super.modifiedProperties)
    : super.fromModifiedProperties();

  @override
  void paint(Canvas canvas, Size _) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 255, 0, 0)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawRect(
      Rect.fromPoints(position, Offset(size.width, size.height)),
      paint,
    );
  }

  @override
  bool shouldRepaint(BoxComponent oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.size != size ||
        oldDelegate.rotation != rotation;
  }
}

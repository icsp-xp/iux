import 'package:flutter/widgets.dart';
import 'package:iux/domain/model/component_definition/box_component_definition.dart';

abstract class CanvasComponent extends CustomPainter {
  final Offset position;
  final Size size;
  final double rotation;

  const CanvasComponent({
    required this.position,
    required this.size,
    this.rotation = 0,
    super.repaint,
  });

  CanvasComponent.fromModifiedProperties(
    Map<String, Object?> modifiedProperties,
  ) : position =
          modifiedProperties[BoxComponentDefinition.position.name] as Offset? ??
          Offset.zero,
      rotation =
          modifiedProperties[BoxComponentDefinition.rotation.name] as double? ??
          0,
      size =
          modifiedProperties[BoxComponentDefinition.size.name] as Size? ??
          const Size.square(64);
}

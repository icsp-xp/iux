import 'package:iux/domain/model/component.dart';
import 'package:iux/domain/model/component_type.dart';
import 'package:iux/ui/workspace/widgets/canvas_components/box_component.dart';
import 'package:iux/ui/workspace/widgets/canvas_components/canvas_component.dart';

abstract final class ComponentFactory {
  CanvasComponent create(Component component) => switch (component.type) {
    ComponentType.box => BoxComponent.fromModifiedProperties(
      component.modifiedProperties,
    ),
  };
}

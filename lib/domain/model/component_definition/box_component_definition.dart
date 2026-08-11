import 'package:iux/domain/model/component_definition/component_definition.dart';
import 'package:iux/domain/model/component_type.dart';
import 'package:iux/domain/model/property_data_type.dart';

enum BoxComponentDefinition implements ComponentDefinition {
  position(PropertyDataType.vec2),
  rotation(PropertyDataType.double),
  size(PropertyDataType.vec2);

  @override
  final PropertyDataType dataType;

  const BoxComponentDefinition(this.dataType);

  @override
  ComponentType get componentType => ComponentType.box;
}

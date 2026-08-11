import 'package:iux/domain/model/component_type.dart';
import 'package:iux/domain/model/property_data_type.dart';

abstract interface class ComponentDefinition {
  ComponentType get componentType;
  PropertyDataType get dataType;
}
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{class_name.snakeCase()}}.freezed.dart';

@freezed
abstract class {{class_name.pascalCase()}} with _${{class_name.pascalCase()}} {
  const factory {{class_name.pascalCase()}}() = _{{class_name.pascalCase()}};
}
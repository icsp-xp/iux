import 'package:freezed_annotation/freezed_annotation.dart';

part '{{page_name.snakeCase()}}_state.freezed.dart';

@freezed
abstract class {{page_name.pascalCase()}}State with _${{page_name.pascalCase()}}State {
  const factory {{page_name.pascalCase()}}State() = _{{page_name.pascalCase()}}State;
}
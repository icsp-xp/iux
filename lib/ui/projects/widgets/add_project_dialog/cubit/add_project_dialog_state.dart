import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iux/core/extension/string_ext.dart';

part 'add_project_dialog_state.freezed.dart';

@freezed
abstract class AddProjectDialogState with _$AddProjectDialogState {
  const AddProjectDialogState._();

  const factory AddProjectDialogState({
    @Default('') String name,

    @Default('') String dirPath,
    @Default(false) bool isDirPathValid,

    @Default(false) bool isAdding,
  }) = _AddProjectDialogState;

  bool _isDirPathValid() => dirPath.isNotBlank && isDirPathValid;

  bool canAdd() => !isAdding && name.isNotBlank && _isDirPathValid();
}

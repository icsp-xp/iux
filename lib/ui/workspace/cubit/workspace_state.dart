import 'package:freezed_annotation/freezed_annotation.dart';

part 'workspace_state.freezed.dart';

@freezed
abstract class WorkspaceState with _$WorkspaceState {
  const factory WorkspaceState() = _WorkspaceState;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iux/domain/model/project.dart';
import 'package:iux/domain/request_status.dart';

part 'projects_state.freezed.dart';

@freezed
abstract class ProjectsState with _$ProjectsState {
  const factory ProjectsState({
    @Default(RequestStatus<List<Project>>.idle())
    RequestStatus<List<Project>> projects,
  }) = _ProjectsState;
}

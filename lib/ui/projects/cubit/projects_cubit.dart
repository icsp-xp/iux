import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/data/repository/projects_repository.dart';
import 'package:iux/domain/request_status.dart';
import 'package:iux/ui/projects/cubit/projects_state.dart';

final class ProjectsCubit extends Cubit<ProjectsState> {
  final ProjectsRepository _projectsRepository;

  late final StreamSubscription _projectsSubscription;

  ProjectsCubit({required this._projectsRepository})
    : super(const ProjectsState()) {
    _watchProjects();
  }

  void _watchProjects() {
    emit(state.copyWith(projects: const RequestStatus.pending()));
    _projectsSubscription = _projectsRepository.watchProjects().listen(
      (data) => data.fold(
        (failure) =>
            emit(state.copyWith(projects: RequestStatus.failed(failure))),
        (projects) =>
            emit(state.copyWith(projects: RequestStatus.succeeded(projects))),
      ),
    );
  }

  @override
  Future<void> close() {
    _projectsSubscription.cancel();
    return super.close();
  }
}

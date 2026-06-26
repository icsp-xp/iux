import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/data/repositories/iux_settings_repository.dart';
import 'package:iux/data/repositories/projects_repository.dart';
import 'package:iux/domain/request_status.dart';
import 'package:iux/ui/projects/cubit/projects_state.dart';

final class ProjectsCubit extends Cubit<ProjectsState> {
  final ProjectsRepository _projectsRepository;
  final IuxSettingsRepository _iuxSettingsRepository;

  late final StreamSubscription _projectsSubscription;

  ProjectsCubit({
    required this._projectsRepository,
    required this._iuxSettingsRepository,
  }) : super(const ProjectsState()) {
    _watchProjects();
  }

  void _watchProjects() async {
    emit(state.copyWith(projects: const RequestStatus.pending()));

    final settings = await _iuxSettingsRepository.getSettings().run();
    settings.fold(
      (failure) =>
          emit(state.copyWith(projects: RequestStatus.failed(failure))),
      (settings) {
        _projectsSubscription = _projectsRepository
            .watchProjects(settings.defaultProjectDirPath)
            .listen(
              (data) => data.fold(
                (failure) => emit(
                  state.copyWith(projects: RequestStatus.failed(failure)),
                ),
                (projects) => emit(
                  state.copyWith(projects: RequestStatus.succeeded(projects)),
                ),
              ),
            );
      },
    );
  }

  Future<void> delete(final String projectDirPath) async {
    await _projectsRepository.delete(projectDirPath).run();
  }

  @override
  Future<void> close() {
    _projectsSubscription.cancel();
    return super.close();
  }
}

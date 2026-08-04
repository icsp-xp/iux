import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/data/repositories/iux_settings_repository.dart';
import 'package:iux/data/repositories/projects_repository.dart';
import 'package:iux/domain/request_status.dart';
import 'package:iux/domain/use_cases/get_folder_path_use_case.dart';
import 'package:iux/ui/projects/cubit/projects_state.dart';

final class ProjectsCubit extends Cubit<ProjectsState> {
  final ProjectsRepository _projectsRepository;
  final IuxSettingsRepository _iuxSettingsRepository;
  final GetFolderPathUseCase _getFolderPathUseCase;

  StreamSubscription? _projectsSubscription;

  ProjectsCubit({
    required this._projectsRepository,
    required this._iuxSettingsRepository,
    required this._getFolderPathUseCase,
  }) : super(const ProjectsState());

  Future<void> init() async {
    final settings = await _iuxSettingsRepository.getSettings().run();
    settings.fold(
      (failure) =>
          emit(state.copyWith(projects: RequestStatus.failed(failure))),
      (settings) {
        emit(state.copyWith(projectsDirPath: settings.defaultProjectDirPath));
        _watchProjects(settings.defaultProjectDirPath);
      },
    );
  }

  Future<void> _watchProjects(final String folderPath) async {
    _projectsSubscription?.cancel();

    emit(state.copyWith(projects: const RequestStatus.pending()));

    _projectsSubscription = _projectsRepository
        .watchProjects(Directory(folderPath))
        .listen(
          (projects) =>
              emit(state.copyWith(projects: RequestStatus.succeeded(projects))),
        );
  }

  Future<void> delete(final String projectDirPath) async {
    await _projectsRepository.delete(projectDirPath).run();
  }

  Future<void> chooseProjectDir(final String dialogTitle) async {
    final result = await _getFolderPathUseCase.get(dialogTitle);
    result.fold(
      (_) {}, // TODO: show snackbar message
      (path) {
        emit(state.copyWith(projectsDirPath: path));
        _watchProjects(path);
      },
    );
  }

  @override
  Future<void> close() {
    _projectsSubscription?.cancel();
    return super.close();
  }
}

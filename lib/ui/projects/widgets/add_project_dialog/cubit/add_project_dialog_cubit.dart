import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/data/repositories/iux_settings_repository.dart';
import 'package:iux/data/repositories/projects_repository.dart';
import 'package:iux/domain/validators/path_validator.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';

final class AddProjectDialogCubit extends Cubit<AddProjectDialogState> {
  final ProjectsRepository _projectsRepository;
  final IuxSettingsRepository _iuxSettingsRepository;

  AddProjectDialogCubit({
    required this._projectsRepository,
    required this._iuxSettingsRepository,
  }) : super(const AddProjectDialogState());

  Future<void> setDirPathToDefault() async {
    final result = await _iuxSettingsRepository.getSettings().run();

    result.fold(
      (_) {},
      (settings) => _setDirPath(settings.defaultProjectDirPath),
    );
  }

  Future<void> onAdd() async {
    if (!state.canAdd()) {
      return;
    }

    emit(state.copyWith(isAdding: true));
    final result = await _projectsRepository
        .create(state.name, state.dirPath) // TODO: 
        .run();

    result.fold(
      (failure) {
        // TODO: handle failure
      },
      (_) {
        /* empty */
      },
    );

    emit(state.copyWith(isAdding: false));
  }

  void onNameChanged(final String value) {
    final trimmed = value.trim();
    emit(state.copyWith(name: trimmed));
  }

  void _setDirPath(final String value) {
    final trimmed = value.trim();
    emit(
      state.copyWith(
        dirPath: trimmed,
        isDirPathValid: PathValidator.isValid(trimmed).getOrElse((_) => false),
      ),
    );
  }

  void onDirPathChanged(final String value) => _setDirPath(value);

  Future<void> getProjectDir(final String dialogTitle) async {
    final path = await FilePicker.getDirectoryPath(dialogTitle: dialogTitle);

    if (path != null) {
      _setDirPath(path);
    }
  }
}

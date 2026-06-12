import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/data/repository/projects_repository.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';

final class AddProjectDialogCubit extends Cubit<AddProjectDialogState> {
  final ProjectsRepository _projectsRepository;

  AddProjectDialogCubit({required this._projectsRepository})
    : super(const AddProjectDialogState());

  Future<void> onAdd() async {
    if (!state.canAdd()) {
      return;
    }

    emit(state.copyWith(isAdding: true));
    await _projectsRepository.upsert(state.name, state.dirPath).run();
    emit(state.copyWith(isAdding: false));
  }

  void onNameChanged(String value) {
    final trimmed = value.trim(); // TODO: validate name
    emit(state.copyWith(name: trimmed));
  }

  void onDirPathChanged(String value) {
    final trimmed = value.trim(); // TODO: validate dirPath
    emit(state.copyWith(dirPath: trimmed));
  }

  Future<void> getProjectDir(String dialogTitle) async {
    final path = await FilePicker.getDirectoryPath(dialogTitle: dialogTitle);

    if (path != null) {
      emit(state.copyWith(dirPath: path));
    }
  }
}

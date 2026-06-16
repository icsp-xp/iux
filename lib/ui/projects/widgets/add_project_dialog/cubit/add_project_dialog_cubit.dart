import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iux/core/constants.dart';
import 'package:iux/data/repositories/projects_repository.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/validators/path_validator.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';
import 'package:path/path.dart' as p;

final class AddProjectDialogCubit extends Cubit<AddProjectDialogState> {
  final ProjectsRepository _projectsRepository;

  AddProjectDialogCubit({required this._projectsRepository})
    : super(const AddProjectDialogState());

  Future<void> onAdd() async {
    if (!state.canAdd()) {
      return;
    }

    emit(state.copyWith(isAdding: true));
    final result =
        await TaskEither<Failure, Unit>.tryCatch(() async {
              final file = File(
                p.join(
                  state.dirPath,
                  '${state.name}${Constants.canvasFileExt}',
                ),
              );
              await file.create(recursive: true);
              return unit;
            }, (_, _) => const UnexpectedFailure())
            .flatMap(
              (_) => _projectsRepository.upsert(state.name, state.dirPath),
            )
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

  void onDirPathChanged(final String value) {
    final trimmed = value.trim();
    emit(
      state.copyWith(
        dirPath: trimmed,
        isDirPathValid: PathValidator.isValid(trimmed).getOrElse((_) => false),
      ),
    );
  }

  Future<void> getProjectDir(final String dialogTitle) async {
    final path = await FilePicker.getDirectoryPath(dialogTitle: dialogTitle);

    if (path != null) {
      onDirPathChanged(path);
    }
  }
}

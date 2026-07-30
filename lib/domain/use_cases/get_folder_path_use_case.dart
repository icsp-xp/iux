import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iux/domain/error_handler.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/validators/path_validator.dart';

class GetFolderPathUseCase {
  Future<Either<Failure, String>> get([String? dialogTitle]) {
    return TaskEither.tryCatch(
          () => FilePicker.getDirectoryPath(dialogTitle: dialogTitle),
          (error, stackTrace) =>
              ErrorHandler.handle(error, stackTrace, 'On get directory path'),
        )
        .flatMap(
          (path) => TaskEither.fromOption(
            Option.fromNullable(path),
            () => const InvalidDataFailure(),
          ),
        )
        .flatMap((path) {
          final trimmed = path.trim();
          return TaskEither.fromEither(
            PathValidator.isValid(trimmed).map((_) => trimmed),
          );
        })
        .run();
  }
}

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iux/core/mixin/error_handler_mixin.dart';
import 'package:iux/data/dao/projects_dao.dart';
import 'package:iux/data/iux_database.dart';
import 'package:iux/domain/failure.dart';

class ProjectsRepository with ErrorHandlerMixin {
  final ProjectsDao _projectsDao;

  ProjectsRepository(this._projectsDao);

  Stream<Either<Failure, List<Project>>> watchProjects() {
    return _projectsDao
        .watchAllProjects()
        .distinct()
        .map((data) => right<Failure, List<Project>>(data))
        .handleError((error, stackTrace) {
          final failure = handleError(
            error,
            stackTrace,
            'On watch all projects',
          );
          return Stream.value(left<Failure, List<Project>>(failure));
        });
  }

  TaskEither<Failure, Unit> upsert(String? name, String? dirPath) =>
      TaskEither.tryCatch(
        () => _projectsDao
            .upsert(
              ProjectsCompanion(
                id: const Value.absent(),
                name: Value.absentIfNull(name),
                path: Value.absentIfNull(dirPath),
                createdAt: Value(DateTime.now()),
              ),
            )
            .then((_) => unit),
        (error, stackTrace) =>
            handleError(error, stackTrace, 'On upsert project'),
      );
}

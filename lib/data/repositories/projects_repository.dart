import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iux/core/constants.dart';
import 'package:iux/domain/error_handler.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/model/project.dart';
import 'package:path/path.dart' as p;
import 'package:stream_transform/stream_transform.dart';
import 'package:watcher/watcher.dart';

final class ProjectsRepository {
  Future<Either<Failure, List<Project>>> getProjects(
    String projectsDirPath,
  ) async {
    final projectsDir = Directory(projectsDirPath);

    try {
      if (!projectsDir.existsSync()) {
        await projectsDir.create(recursive: true);
        return right([]);
      }

      final entities = await projectsDir.list().toList();
      final projects = <Project>[];

      for (final entity in entities) {
        if (entity is Directory &&
            Directory(
              p.join(entity.path, Constants.iuxProjectFolder),
            ).existsSync()) {
          final dirStat = entity.statSync();

          projects.add(
            Project(
              name: p.basename(entity.path),
              dirPath: entity.path,
              createdAt: dirStat.changed,
            ),
          );
        }
      }

      return right(projects);
    } catch (error) {
      return left(
        ErrorHandler.handle(error, StackTrace.current, 'On list projects'),
      );
    }
  }

  Stream<Either<Failure, List<Project>>> watchProjects(
    final String projectsDirPath,
  ) async* {
    final projectsDir = Directory(projectsDirPath);

    try {
      if (!projectsDir.existsSync()) {
        await projectsDir.create(recursive: true);
      }

      yield* Stream.fromFuture(getProjects(projectsDirPath));

      final watcher = DirectoryWatcher(projectsDir.path);
      yield* watcher.events
          .debounce(const Duration(milliseconds: 500))
          .asyncMap((_) => getProjects(projectsDirPath));
    } catch (error) {
      yield left(
        ErrorHandler.handle(error, StackTrace.current, 'On watch projects'),
      );
    }
  }

  TaskEither<Failure, Unit> upsert(
    final String projectName,
    final String projectPath,
  ) => TaskEither.tryCatch(
    () async {
      final projectFolderPath = p.join(projectPath, projectName);
      final iuxFolderPath = p.join(
        projectFolderPath,
        Constants.iuxProjectFolder,
      );

      await Directory(projectFolderPath).create(recursive: true);
      Directory(iuxFolderPath).create();

      return unit;
    },
    (error, stackTrace) =>
        ErrorHandler.handle(error, stackTrace, 'On upsert project'),
  );

  TaskEither<Failure, Unit> delete(
    final String projectName,
    final String projectPath,
  ) => TaskEither.tryCatch(
    () async {
      final projectDir = Directory(p.join(projectPath, projectName));
      if (projectDir.existsSync()) {
        await projectDir.delete(recursive: true);
      }
      return unit;
    },
    (error, stackTrace) =>
        ErrorHandler.handle(error, stackTrace, 'On delete project'),
  );
}

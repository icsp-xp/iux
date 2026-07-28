import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iux/core/constants.dart';
import 'package:iux/domain/error_handler.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/model/project.dart';
import 'package:path/path.dart' as p;
import 'package:stream_transform/stream_transform.dart';

final class ProjectsRepository {
  bool isIuxProject(final String dirPath) =>
      Directory(p.join(dirPath, Constants.iuxProjectFolder)).existsSync();

  Stream<List<Project>> watchProjects(Directory parentDir) async* {
    List<Project> fetchCurrentProjects() {
      if (!parentDir.existsSync()) {
        return [];
      }

      return parentDir
          .listSync(recursive: false, followLinks: false)
          .whereType<Directory>()
          .where((dir) => isIuxProject(dir.path))
          .map((projectDir) {
            final dirStat = projectDir.statSync();
            return Project(
              name: p.basename(projectDir.path),
              dirPath: projectDir.path,
              createdAt: dirStat.changed,
            );
          })
          .toList();
    }

    yield fetchCurrentProjects();

    await for (final _
        in parentDir
            .watch(recursive: false)
            .debounce(const Duration(milliseconds: 300))) {
      yield fetchCurrentProjects();
    }
  }

  TaskEither<Failure, Unit> create(
    final String projectName,
    final String projectsDirPath,
  ) => TaskEither.tryCatch(
    () async {
      final projectDirPath = p.join(projectsDirPath, projectName);
      final iuxFolderPath = p.join(projectDirPath, Constants.iuxProjectFolder);

      final projectDir = Directory(projectDirPath);

      if (projectDir.existsSync()) {
        throw const DataAlreadyExistsFailure();
      }

      await projectDir.create(recursive: true);
      await File(
        p.join(projectDirPath, '$projectName${Constants.canvasFileExt}'),
      ).create();
      await Directory(iuxFolderPath).create();
      // TODO: create project settings file

      return unit;
    },
    (error, stackTrace) =>
        ErrorHandler.handle(error, stackTrace, 'On upsert project'),
  );

  TaskEither<Failure, Unit> delete(final String projectDirPath) =>
      TaskEither.tryCatch(
        () async {
          final projectDir = Directory(projectDirPath);
          if (projectDir.existsSync()) {
            await projectDir.delete(recursive: true);
          } else {
            throw const DataNotFoundFailure();
          }
          return unit;
        },
        (error, stackTrace) =>
            ErrorHandler.handle(error, stackTrace, 'On delete project'),
      );
}

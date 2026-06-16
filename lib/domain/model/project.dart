import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

part 'project.freezed.dart';

@freezed
abstract class Project with _$Project {
  const Project._();

  const factory Project({
    required String name,
    required String dirPath,
    required DateTime createdAt,
  }) = _Project;

  String get projectPath => p.join(dirPath, name);
}

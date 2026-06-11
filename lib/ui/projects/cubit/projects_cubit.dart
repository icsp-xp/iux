import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/data/repository/projects_repository.dart';

final class ProjectsCubit extends Cubit {
  final ProjectsRepository _projectsRepository;

  ProjectsCubit({required this._projectsRepository}) : super(0);
}

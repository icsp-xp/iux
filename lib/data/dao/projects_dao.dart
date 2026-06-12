import 'package:drift/drift.dart';
import 'package:iux/data/tables/projects.dart';
import 'package:iux/data/iux_database.dart';

part 'projects_dao.g.dart';

@DriftAccessor(tables: [Projects])
class ProjectsDao extends DatabaseAccessor<IuxDatabase>
    with _$ProjectsDaoMixin {
  ProjectsDao(super.attachedDatabase);

  Future<int> upsert(ProjectsCompanion project) {
    return into(projects).insert(project, mode: InsertMode.replace);
  }

  Future<int> deleteById(int id) {
    return (delete(projects)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<Project>> watchAllProjects() {
    return select(projects).watch();
  }
}

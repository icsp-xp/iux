import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:iux/data/dao/projects_dao.dart';
import 'package:iux/data/tables/projects.dart';
import 'package:path_provider/path_provider.dart';

part 'iux_database.g.dart';

@DriftDatabase(tables: [Projects], daos: [ProjectsDao])
class IuxDatabase extends _$IuxDatabase {
  IuxDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'iux_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

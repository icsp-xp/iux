import 'package:drift/drift.dart';

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get path => text().withLength(min: 1, max: 255)();
  DateTimeColumn get createdAt => dateTime()();
}
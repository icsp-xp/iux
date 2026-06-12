import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:iux/domain/failure.dart';

abstract class ExceptionMapper {
  static Failure toFailure(Object error) {
    if (error is Failure) {
      return error;
    } else if (error is DriftWrappedException) {
      return _mapDriftException(error);
    }

    return const UnexpectedFailure();
  }

  // Error codes are available at https://sqlite.org/rescode.html
  static Failure _mapDriftException(DriftWrappedException error) {
    final cause = error.cause;

    if (cause is SqliteException) {
      switch (cause.extendedResultCode) {
        // (1555) SQLITE_CONSTRAINT_PRIMARYKEY
        // (2067) SQLITE_CONSTRAINT_UNIQUE
        case 1555:
        case 2067:
          return const DataAlreadyExistsFailure();

        // (787) SQLITE_CONSTRAINT_FOREIGNKEY
        // (1299) SQLITE_CONSTRAINT_NOTNULL
        // (275) SQLITE_CONSTRAINT_CHECK
        case 787:
        case 1299:
        case 275:
          return const InvalidDataFailure();

        default:
          // (19) SQLITE_CONSTRAINT
          if (cause.resultCode == 19) {
            return const InvalidDataFailure();
          }

          return const UnexpectedFailure();
      }
    }

    if (cause is StateError && cause.message.contains('No element')) {
      return const DataNotFoundFailure();
    }

    return const UnexpectedFailure();
  }
}

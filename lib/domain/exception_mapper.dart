import 'package:iux/domain/failure.dart';

abstract class ExceptionMapper {
  static Failure toFailure(Object error) {
    if (error is Failure) {
      return error;
    }

    return const UnexpectedFailure();
  }
}

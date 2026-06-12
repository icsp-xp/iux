import 'package:iux/domain/exception_mapper.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/main.dart';

mixin ErrorHandlerMixin {
  Failure handleError(Object error, [StackTrace? stackTrace, String? label]) {
    final failure = ExceptionMapper.toFailure(error);

    final logMessage = label != null ? '[$label]: $failure' : '$failure';

    talker.error(logMessage, error, stackTrace);

    return failure;
  }
}

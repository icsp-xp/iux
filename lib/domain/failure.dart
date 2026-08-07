sealed class Failure {
  const Failure();
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

final class DataAlreadyExistsFailure extends Failure {
  const DataAlreadyExistsFailure();
}

final class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure();
}

final class InvalidDataFailure extends Failure {
  const InvalidDataFailure();
}

final class UnsupportedOs extends Failure {
  const UnsupportedOs();
}

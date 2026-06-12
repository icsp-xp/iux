sealed class Failure {
  const Failure();
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

class DataAlreadyExistsFailure extends Failure {
  const DataAlreadyExistsFailure();
}

class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure();
}

class InvalidDataFailure extends Failure {
  const InvalidDataFailure();
}

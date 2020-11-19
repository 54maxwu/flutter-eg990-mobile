import 'failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}

class HttpResponseFailed extends Error {
  final HttpFailure httpFailure;

  HttpResponseFailed(this.httpFailure);

  @override
  String toString() {
    const explanation = 'Encountered a HttpFailure. Data request Failed';
    return Error.safeToString('$explanation Failure was: $httpFailure');
  }
}

class DataDecodeFailed extends Error {
  final DataFailure dataFailure;

  DataDecodeFailed(this.dataFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a DataFailure. Failed to parse data into required data type.';
    return Error.safeToString('$explanation Failure was: $dataFailure');
  }
}

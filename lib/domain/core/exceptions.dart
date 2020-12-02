import 'package:flutter_eg990_mobile/domain/response/request_status_model.dart';

class ServerException implements Exception {}

class LocationException implements ServerException {}

class RequestTypeErrorException implements ServerException {}

class RequestTimeoutException implements ServerException {
  final String message;

  RequestTimeoutException([this.message = ""]);

  @override
  String toString() {
    if (message.isEmpty) return super.toString();
    return 'RequestTimeoutException!! msg:$message';
  }
}

class RequestCanceledException implements ServerException {}

class ResponseException implements ServerException {}

class TokenException implements ServerException {}

class LoginException implements ServerException {
  final RequestStatusModel data;

  LoginException({this.data});

  @override
  String toString() {
    if (data != null) return super.toString();
    return 'LoginException!! data:$data';
  }
}

abstract class DataException implements Exception {
  final dynamic data;

  DataException(this.data);

  @override
  String toString() => 'DataException!! data: $data';
}

class HiveDataException extends DataException {
  HiveDataException(data) : super(data);

  @override
  String toString() => 'HiveDataException!! data type: ${data.runtimeType}';
}

class JsonDecodeException extends DataException {
  JsonDecodeException(data) : super(data);

  @override
  String toString() => 'JsonDecodeException!! data: $data';
}

class UnexpectedTypeException extends DataException {
  UnexpectedTypeException(data) : super(data);

  @override
  String toString() => 'UnexpectedTypeException!! data: ${data.runtimeType}';
}

class UnknownConditionException extends DataException {
  UnknownConditionException(data) : super(data);

  @override
  String toString() =>
      'UnknownConditionException!! data type: ${data.runtimeType}';
}

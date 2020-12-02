import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/domain/response/request_code_model.dart';
import 'package:flutter_eg990_mobile/domain/response/request_status_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_enum/super_enum.dart';

import 'failure_code.dart';

export 'failure_code.dart';

part 'failures.freezed.dart';
part 'failures.super.dart';

@superEnum
enum _Failure {
  @object
  Network,
  @object
  NetworkLocation,
  @object
  Server,
  @object
  JsonFormat,
  @object
  DataType,
  @object
  CachedFile,
  @Data(fields: [
    DataField<String>('msg'),
  ])
  ErrorMessage,
  @UseClass(RequestStatusModel)
  ErrorStatus,
  @UseClass(RequestCodeModel)
  ErrorCode,
  @UseClass(FailureCode)
  Internal,
  @UseClass(RequestStatusModel)
  Login,
  @UseClass(FailureType)
  Token,
  @object
  Event,
}

extension FailureExtension on Failure {
  int get typeIndex => this._type.index;

  String get message {
    switch (this._type) {
      case _Failure.Network:
        return localeStr.messageErrorNoNetwork;
      case _Failure.NetworkLocation:
        return localeStr.messageWarnNetworkLocation;
      case _Failure.Server:
        return localeStr.messageErrorNoServerConnection;
      case _Failure.JsonFormat:
        return localeStr.messageErrorServerData;
      case _Failure.Login:
        return localeStr.messageLoginFailed +
            '(${(this.props.first as RequestStatusModel).msg})';
      case _Failure.Token:
        return localeStr.messageErrorToken +
            '(code: ${(this.props.first as FailureType).value})';
      case _Failure.Event:
        return localeStr.messageErrorEvent;
      case _Failure.CachedFile:
        return localeStr.messageErrorCachedFile;
      case _Failure.Internal:
        return localeStr.messageErrorInternal +
            '(${(this.props.first as FailureCode).errorCode})';
      case _Failure.ErrorMessage:
        return '${this.props.first}';
      case _Failure.ErrorStatus:
        return '${(this.props.first as RequestStatusModel).msg}';
      case _Failure.ErrorCode:
        return '${(this.props.first as RequestCodeModel).msg}(code: ${(this.props.first as RequestCodeModel).code})';
      case _Failure.DataType:
        return localeStr.messageErrorServerData;
      default:
        return _OTHER_FAILURE_MESSAGE;
    }
  }
}

const String _OTHER_FAILURE_MESSAGE = 'Unexpected error';

/// TODO change failures like this
/// see auth folder under domain as example
@freezed
abstract class HttpFailure with _$HttpFailure {
  const factory HttpFailure.invalidToken() = InvalidToken;

  const factory HttpFailure.serverError({
    @required String code,
    @required String msg,
  }) = ServerError;
}

@freezed
abstract class DataFailure<T> with _$DataFailure<T> {
  const factory DataFailure.decodeError({
    @required T type,
    @required dynamic data,
  }) = DataDecodeError<T>;

  const factory DataFailure.invalidResponse({
    @required T type,
    @required dynamic data,
  }) = InvalidResponse<T>;
}

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidId({
    @required T data,
  }) = InvalidUserId<T>;
}

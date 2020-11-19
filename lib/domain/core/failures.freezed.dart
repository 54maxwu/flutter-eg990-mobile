// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HttpFailureTearOff {
  const _$HttpFailureTearOff();

// ignore: unused_element
  InvalidToken invalidToken() {
    return const InvalidToken();
  }

// ignore: unused_element
  ServerError serverError({@required String code, @required String msg}) {
    return ServerError(
      code: code,
      msg: msg,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HttpFailure = _$HttpFailureTearOff();

/// @nodoc
mixin _$HttpFailure {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result invalidToken(),
    @required Result serverError(String code, String msg),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result invalidToken(),
    Result serverError(String code, String msg),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result invalidToken(InvalidToken value),
    @required Result serverError(ServerError value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result invalidToken(InvalidToken value),
    Result serverError(ServerError value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $HttpFailureCopyWith<$Res> {
  factory $HttpFailureCopyWith(
          HttpFailure value, $Res Function(HttpFailure) then) =
      _$HttpFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$HttpFailureCopyWithImpl<$Res> implements $HttpFailureCopyWith<$Res> {
  _$HttpFailureCopyWithImpl(this._value, this._then);

  final HttpFailure _value;
  // ignore: unused_field
  final $Res Function(HttpFailure) _then;
}

/// @nodoc
abstract class $InvalidTokenCopyWith<$Res> {
  factory $InvalidTokenCopyWith(
          InvalidToken value, $Res Function(InvalidToken) then) =
      _$InvalidTokenCopyWithImpl<$Res>;
}

/// @nodoc
class _$InvalidTokenCopyWithImpl<$Res> extends _$HttpFailureCopyWithImpl<$Res>
    implements $InvalidTokenCopyWith<$Res> {
  _$InvalidTokenCopyWithImpl(
      InvalidToken _value, $Res Function(InvalidToken) _then)
      : super(_value, (v) => _then(v as InvalidToken));

  @override
  InvalidToken get _value => super._value as InvalidToken;
}

/// @nodoc
class _$InvalidToken implements InvalidToken {
  const _$InvalidToken();

  @override
  String toString() {
    return 'HttpFailure.invalidToken()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InvalidToken);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result invalidToken(),
    @required Result serverError(String code, String msg),
  }) {
    assert(invalidToken != null);
    assert(serverError != null);
    return invalidToken();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result invalidToken(),
    Result serverError(String code, String msg),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidToken != null) {
      return invalidToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result invalidToken(InvalidToken value),
    @required Result serverError(ServerError value),
  }) {
    assert(invalidToken != null);
    assert(serverError != null);
    return invalidToken(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result invalidToken(InvalidToken value),
    Result serverError(ServerError value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidToken != null) {
      return invalidToken(this);
    }
    return orElse();
  }
}

abstract class InvalidToken implements HttpFailure {
  const factory InvalidToken() = _$InvalidToken;
}

/// @nodoc
abstract class $ServerErrorCopyWith<$Res> {
  factory $ServerErrorCopyWith(
          ServerError value, $Res Function(ServerError) then) =
      _$ServerErrorCopyWithImpl<$Res>;
  $Res call({String code, String msg});
}

/// @nodoc
class _$ServerErrorCopyWithImpl<$Res> extends _$HttpFailureCopyWithImpl<$Res>
    implements $ServerErrorCopyWith<$Res> {
  _$ServerErrorCopyWithImpl(
      ServerError _value, $Res Function(ServerError) _then)
      : super(_value, (v) => _then(v as ServerError));

  @override
  ServerError get _value => super._value as ServerError;

  @override
  $Res call({
    Object code = freezed,
    Object msg = freezed,
  }) {
    return _then(ServerError(
      code: code == freezed ? _value.code : code as String,
      msg: msg == freezed ? _value.msg : msg as String,
    ));
  }
}

/// @nodoc
class _$ServerError implements ServerError {
  const _$ServerError({@required this.code, @required this.msg})
      : assert(code != null),
        assert(msg != null);

  @override
  final String code;
  @override
  final String msg;

  @override
  String toString() {
    return 'HttpFailure.serverError(code: $code, msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ServerError &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.msg, msg) ||
                const DeepCollectionEquality().equals(other.msg, msg)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(msg);

  @override
  $ServerErrorCopyWith<ServerError> get copyWith =>
      _$ServerErrorCopyWithImpl<ServerError>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result invalidToken(),
    @required Result serverError(String code, String msg),
  }) {
    assert(invalidToken != null);
    assert(serverError != null);
    return serverError(code, msg);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result invalidToken(),
    Result serverError(String code, String msg),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (serverError != null) {
      return serverError(code, msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result invalidToken(InvalidToken value),
    @required Result serverError(ServerError value),
  }) {
    assert(invalidToken != null);
    assert(serverError != null);
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result invalidToken(InvalidToken value),
    Result serverError(ServerError value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError implements HttpFailure {
  const factory ServerError({@required String code, @required String msg}) =
      _$ServerError;

  String get code;
  String get msg;
  $ServerErrorCopyWith<ServerError> get copyWith;
}

/// @nodoc
class _$DataFailureTearOff {
  const _$DataFailureTearOff();

// ignore: unused_element
  DataDecodeError<T> decodeError<T>(
      {@required T type, @required dynamic data}) {
    return DataDecodeError<T>(
      type: type,
      data: data,
    );
  }

// ignore: unused_element
  InvalidResponse<T> invalidResponse<T>(
      {@required T type, @required dynamic data}) {
    return InvalidResponse<T>(
      type: type,
      data: data,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DataFailure = _$DataFailureTearOff();

/// @nodoc
mixin _$DataFailure<T> {
  T get type;
  dynamic get data;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result decodeError(T type, dynamic data),
    @required Result invalidResponse(T type, dynamic data),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result decodeError(T type, dynamic data),
    Result invalidResponse(T type, dynamic data),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result decodeError(DataDecodeError<T> value),
    @required Result invalidResponse(InvalidResponse<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result decodeError(DataDecodeError<T> value),
    Result invalidResponse(InvalidResponse<T> value),
    @required Result orElse(),
  });

  $DataFailureCopyWith<T, DataFailure<T>> get copyWith;
}

/// @nodoc
abstract class $DataFailureCopyWith<T, $Res> {
  factory $DataFailureCopyWith(
          DataFailure<T> value, $Res Function(DataFailure<T>) then) =
      _$DataFailureCopyWithImpl<T, $Res>;
  $Res call({T type, dynamic data});
}

/// @nodoc
class _$DataFailureCopyWithImpl<T, $Res>
    implements $DataFailureCopyWith<T, $Res> {
  _$DataFailureCopyWithImpl(this._value, this._then);

  final DataFailure<T> _value;
  // ignore: unused_field
  final $Res Function(DataFailure<T>) _then;

  @override
  $Res call({
    Object type = freezed,
    Object data = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as T,
      data: data == freezed ? _value.data : data as dynamic,
    ));
  }
}

/// @nodoc
abstract class $DataDecodeErrorCopyWith<T, $Res>
    implements $DataFailureCopyWith<T, $Res> {
  factory $DataDecodeErrorCopyWith(
          DataDecodeError<T> value, $Res Function(DataDecodeError<T>) then) =
      _$DataDecodeErrorCopyWithImpl<T, $Res>;
  @override
  $Res call({T type, dynamic data});
}

/// @nodoc
class _$DataDecodeErrorCopyWithImpl<T, $Res>
    extends _$DataFailureCopyWithImpl<T, $Res>
    implements $DataDecodeErrorCopyWith<T, $Res> {
  _$DataDecodeErrorCopyWithImpl(
      DataDecodeError<T> _value, $Res Function(DataDecodeError<T>) _then)
      : super(_value, (v) => _then(v as DataDecodeError<T>));

  @override
  DataDecodeError<T> get _value => super._value as DataDecodeError<T>;

  @override
  $Res call({
    Object type = freezed,
    Object data = freezed,
  }) {
    return _then(DataDecodeError<T>(
      type: type == freezed ? _value.type : type as T,
      data: data == freezed ? _value.data : data as dynamic,
    ));
  }
}

/// @nodoc
class _$DataDecodeError<T> implements DataDecodeError<T> {
  const _$DataDecodeError({@required this.type, @required this.data})
      : assert(type != null),
        assert(data != null);

  @override
  final T type;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'DataFailure<$T>.decodeError(type: $type, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DataDecodeError<T> &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(data);

  @override
  $DataDecodeErrorCopyWith<T, DataDecodeError<T>> get copyWith =>
      _$DataDecodeErrorCopyWithImpl<T, DataDecodeError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result decodeError(T type, dynamic data),
    @required Result invalidResponse(T type, dynamic data),
  }) {
    assert(decodeError != null);
    assert(invalidResponse != null);
    return decodeError(type, data);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result decodeError(T type, dynamic data),
    Result invalidResponse(T type, dynamic data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (decodeError != null) {
      return decodeError(type, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result decodeError(DataDecodeError<T> value),
    @required Result invalidResponse(InvalidResponse<T> value),
  }) {
    assert(decodeError != null);
    assert(invalidResponse != null);
    return decodeError(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result decodeError(DataDecodeError<T> value),
    Result invalidResponse(InvalidResponse<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (decodeError != null) {
      return decodeError(this);
    }
    return orElse();
  }
}

abstract class DataDecodeError<T> implements DataFailure<T> {
  const factory DataDecodeError({@required T type, @required dynamic data}) =
      _$DataDecodeError<T>;

  @override
  T get type;
  @override
  dynamic get data;
  @override
  $DataDecodeErrorCopyWith<T, DataDecodeError<T>> get copyWith;
}

/// @nodoc
abstract class $InvalidResponseCopyWith<T, $Res>
    implements $DataFailureCopyWith<T, $Res> {
  factory $InvalidResponseCopyWith(
          InvalidResponse<T> value, $Res Function(InvalidResponse<T>) then) =
      _$InvalidResponseCopyWithImpl<T, $Res>;
  @override
  $Res call({T type, dynamic data});
}

/// @nodoc
class _$InvalidResponseCopyWithImpl<T, $Res>
    extends _$DataFailureCopyWithImpl<T, $Res>
    implements $InvalidResponseCopyWith<T, $Res> {
  _$InvalidResponseCopyWithImpl(
      InvalidResponse<T> _value, $Res Function(InvalidResponse<T>) _then)
      : super(_value, (v) => _then(v as InvalidResponse<T>));

  @override
  InvalidResponse<T> get _value => super._value as InvalidResponse<T>;

  @override
  $Res call({
    Object type = freezed,
    Object data = freezed,
  }) {
    return _then(InvalidResponse<T>(
      type: type == freezed ? _value.type : type as T,
      data: data == freezed ? _value.data : data as dynamic,
    ));
  }
}

/// @nodoc
class _$InvalidResponse<T> implements InvalidResponse<T> {
  const _$InvalidResponse({@required this.type, @required this.data})
      : assert(type != null),
        assert(data != null);

  @override
  final T type;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'DataFailure<$T>.invalidResponse(type: $type, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InvalidResponse<T> &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(data);

  @override
  $InvalidResponseCopyWith<T, InvalidResponse<T>> get copyWith =>
      _$InvalidResponseCopyWithImpl<T, InvalidResponse<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result decodeError(T type, dynamic data),
    @required Result invalidResponse(T type, dynamic data),
  }) {
    assert(decodeError != null);
    assert(invalidResponse != null);
    return invalidResponse(type, data);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result decodeError(T type, dynamic data),
    Result invalidResponse(T type, dynamic data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidResponse != null) {
      return invalidResponse(type, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result decodeError(DataDecodeError<T> value),
    @required Result invalidResponse(InvalidResponse<T> value),
  }) {
    assert(decodeError != null);
    assert(invalidResponse != null);
    return invalidResponse(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result decodeError(DataDecodeError<T> value),
    Result invalidResponse(InvalidResponse<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidResponse != null) {
      return invalidResponse(this);
    }
    return orElse();
  }
}

abstract class InvalidResponse<T> implements DataFailure<T> {
  const factory InvalidResponse({@required T type, @required dynamic data}) =
      _$InvalidResponse<T>;

  @override
  T get type;
  @override
  dynamic get data;
  @override
  $InvalidResponseCopyWith<T, InvalidResponse<T>> get copyWith;
}

/// @nodoc
class _$ValueFailureTearOff {
  const _$ValueFailureTearOff();

// ignore: unused_element
  InvalidUserId<T> invalidId<T>({@required T data}) {
    return InvalidUserId<T>(
      data: data,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ValueFailure = _$ValueFailureTearOff();

/// @nodoc
mixin _$ValueFailure<T> {
  T get data;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result invalidId(T data),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result invalidId(T data),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result invalidId(InvalidUserId<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result invalidId(InvalidUserId<T> value),
    @required Result orElse(),
  });

  $ValueFailureCopyWith<T, ValueFailure<T>> get copyWith;
}

/// @nodoc
abstract class $ValueFailureCopyWith<T, $Res> {
  factory $ValueFailureCopyWith(
          ValueFailure<T> value, $Res Function(ValueFailure<T>) then) =
      _$ValueFailureCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class _$ValueFailureCopyWithImpl<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  final ValueFailure<T> _value;
  // ignore: unused_field
  final $Res Function(ValueFailure<T>) _then;

  @override
  $Res call({
    Object data = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed ? _value.data : data as T,
    ));
  }
}

/// @nodoc
abstract class $InvalidUserIdCopyWith<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  factory $InvalidUserIdCopyWith(
          InvalidUserId<T> value, $Res Function(InvalidUserId<T>) then) =
      _$InvalidUserIdCopyWithImpl<T, $Res>;
  @override
  $Res call({T data});
}

/// @nodoc
class _$InvalidUserIdCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res>
    implements $InvalidUserIdCopyWith<T, $Res> {
  _$InvalidUserIdCopyWithImpl(
      InvalidUserId<T> _value, $Res Function(InvalidUserId<T>) _then)
      : super(_value, (v) => _then(v as InvalidUserId<T>));

  @override
  InvalidUserId<T> get _value => super._value as InvalidUserId<T>;

  @override
  $Res call({
    Object data = freezed,
  }) {
    return _then(InvalidUserId<T>(
      data: data == freezed ? _value.data : data as T,
    ));
  }
}

/// @nodoc
class _$InvalidUserId<T> implements InvalidUserId<T> {
  const _$InvalidUserId({@required this.data}) : assert(data != null);

  @override
  final T data;

  @override
  String toString() {
    return 'ValueFailure<$T>.invalidId(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InvalidUserId<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @override
  $InvalidUserIdCopyWith<T, InvalidUserId<T>> get copyWith =>
      _$InvalidUserIdCopyWithImpl<T, InvalidUserId<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result invalidId(T data),
  }) {
    assert(invalidId != null);
    return invalidId(data);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result invalidId(T data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidId != null) {
      return invalidId(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result invalidId(InvalidUserId<T> value),
  }) {
    assert(invalidId != null);
    return invalidId(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result invalidId(InvalidUserId<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidId != null) {
      return invalidId(this);
    }
    return orElse();
  }
}

abstract class InvalidUserId<T> implements ValueFailure<T> {
  const factory InvalidUserId({@required T data}) = _$InvalidUserId<T>;

  @override
  T get data;
  @override
  $InvalidUserIdCopyWith<T, InvalidUserId<T>> get copyWith;
}

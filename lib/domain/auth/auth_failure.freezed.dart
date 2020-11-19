// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AuthFailureTearOff {
  const _$AuthFailureTearOff();

// ignore: unused_element
  AuthServerError serverError() {
    return const AuthServerError();
  }

// ignore: unused_element
  AuthDataFormatError dataFormatError() {
    return const AuthDataFormatError();
  }

// ignore: unused_element
  InvalidUsernameAndPasswordCombination
      invalidUsernameAndPasswordCombination() {
    return const InvalidUsernameAndPasswordCombination();
  }
}

/// @nodoc
// ignore: unused_element
const $AuthFailure = _$AuthFailureTearOff();

/// @nodoc
mixin _$AuthFailure {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result serverError(),
    @required Result dataFormatError(),
    @required Result invalidUsernameAndPasswordCombination(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result serverError(),
    Result dataFormatError(),
    Result invalidUsernameAndPasswordCombination(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result serverError(AuthServerError value),
    @required Result dataFormatError(AuthDataFormatError value),
    @required
        Result invalidUsernameAndPasswordCombination(
            InvalidUsernameAndPasswordCombination value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result serverError(AuthServerError value),
    Result dataFormatError(AuthDataFormatError value),
    Result invalidUsernameAndPasswordCombination(
        InvalidUsernameAndPasswordCombination value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res> implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  final AuthFailure _value;
  // ignore: unused_field
  final $Res Function(AuthFailure) _then;
}

/// @nodoc
abstract class $AuthServerErrorCopyWith<$Res> {
  factory $AuthServerErrorCopyWith(
          AuthServerError value, $Res Function(AuthServerError) then) =
      _$AuthServerErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthServerErrorCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res>
    implements $AuthServerErrorCopyWith<$Res> {
  _$AuthServerErrorCopyWithImpl(
      AuthServerError _value, $Res Function(AuthServerError) _then)
      : super(_value, (v) => _then(v as AuthServerError));

  @override
  AuthServerError get _value => super._value as AuthServerError;
}

/// @nodoc
class _$AuthServerError implements AuthServerError {
  const _$AuthServerError();

  @override
  String toString() {
    return 'AuthFailure.serverError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthServerError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result serverError(),
    @required Result dataFormatError(),
    @required Result invalidUsernameAndPasswordCombination(),
  }) {
    assert(serverError != null);
    assert(dataFormatError != null);
    assert(invalidUsernameAndPasswordCombination != null);
    return serverError();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result serverError(),
    Result dataFormatError(),
    Result invalidUsernameAndPasswordCombination(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (serverError != null) {
      return serverError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result serverError(AuthServerError value),
    @required Result dataFormatError(AuthDataFormatError value),
    @required
        Result invalidUsernameAndPasswordCombination(
            InvalidUsernameAndPasswordCombination value),
  }) {
    assert(serverError != null);
    assert(dataFormatError != null);
    assert(invalidUsernameAndPasswordCombination != null);
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result serverError(AuthServerError value),
    Result dataFormatError(AuthDataFormatError value),
    Result invalidUsernameAndPasswordCombination(
        InvalidUsernameAndPasswordCombination value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class AuthServerError implements AuthFailure {
  const factory AuthServerError() = _$AuthServerError;
}

/// @nodoc
abstract class $AuthDataFormatErrorCopyWith<$Res> {
  factory $AuthDataFormatErrorCopyWith(
          AuthDataFormatError value, $Res Function(AuthDataFormatError) then) =
      _$AuthDataFormatErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthDataFormatErrorCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res>
    implements $AuthDataFormatErrorCopyWith<$Res> {
  _$AuthDataFormatErrorCopyWithImpl(
      AuthDataFormatError _value, $Res Function(AuthDataFormatError) _then)
      : super(_value, (v) => _then(v as AuthDataFormatError));

  @override
  AuthDataFormatError get _value => super._value as AuthDataFormatError;
}

/// @nodoc
class _$AuthDataFormatError implements AuthDataFormatError {
  const _$AuthDataFormatError();

  @override
  String toString() {
    return 'AuthFailure.dataFormatError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthDataFormatError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result serverError(),
    @required Result dataFormatError(),
    @required Result invalidUsernameAndPasswordCombination(),
  }) {
    assert(serverError != null);
    assert(dataFormatError != null);
    assert(invalidUsernameAndPasswordCombination != null);
    return dataFormatError();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result serverError(),
    Result dataFormatError(),
    Result invalidUsernameAndPasswordCombination(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (dataFormatError != null) {
      return dataFormatError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result serverError(AuthServerError value),
    @required Result dataFormatError(AuthDataFormatError value),
    @required
        Result invalidUsernameAndPasswordCombination(
            InvalidUsernameAndPasswordCombination value),
  }) {
    assert(serverError != null);
    assert(dataFormatError != null);
    assert(invalidUsernameAndPasswordCombination != null);
    return dataFormatError(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result serverError(AuthServerError value),
    Result dataFormatError(AuthDataFormatError value),
    Result invalidUsernameAndPasswordCombination(
        InvalidUsernameAndPasswordCombination value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (dataFormatError != null) {
      return dataFormatError(this);
    }
    return orElse();
  }
}

abstract class AuthDataFormatError implements AuthFailure {
  const factory AuthDataFormatError() = _$AuthDataFormatError;
}

/// @nodoc
abstract class $InvalidUsernameAndPasswordCombinationCopyWith<$Res> {
  factory $InvalidUsernameAndPasswordCombinationCopyWith(
          InvalidUsernameAndPasswordCombination value,
          $Res Function(InvalidUsernameAndPasswordCombination) then) =
      _$InvalidUsernameAndPasswordCombinationCopyWithImpl<$Res>;
}

/// @nodoc
class _$InvalidUsernameAndPasswordCombinationCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res>
    implements $InvalidUsernameAndPasswordCombinationCopyWith<$Res> {
  _$InvalidUsernameAndPasswordCombinationCopyWithImpl(
      InvalidUsernameAndPasswordCombination _value,
      $Res Function(InvalidUsernameAndPasswordCombination) _then)
      : super(_value, (v) => _then(v as InvalidUsernameAndPasswordCombination));

  @override
  InvalidUsernameAndPasswordCombination get _value =>
      super._value as InvalidUsernameAndPasswordCombination;
}

/// @nodoc
class _$InvalidUsernameAndPasswordCombination
    implements InvalidUsernameAndPasswordCombination {
  const _$InvalidUsernameAndPasswordCombination();

  @override
  String toString() {
    return 'AuthFailure.invalidUsernameAndPasswordCombination()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InvalidUsernameAndPasswordCombination);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result serverError(),
    @required Result dataFormatError(),
    @required Result invalidUsernameAndPasswordCombination(),
  }) {
    assert(serverError != null);
    assert(dataFormatError != null);
    assert(invalidUsernameAndPasswordCombination != null);
    return invalidUsernameAndPasswordCombination();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result serverError(),
    Result dataFormatError(),
    Result invalidUsernameAndPasswordCombination(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidUsernameAndPasswordCombination != null) {
      return invalidUsernameAndPasswordCombination();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result serverError(AuthServerError value),
    @required Result dataFormatError(AuthDataFormatError value),
    @required
        Result invalidUsernameAndPasswordCombination(
            InvalidUsernameAndPasswordCombination value),
  }) {
    assert(serverError != null);
    assert(dataFormatError != null);
    assert(invalidUsernameAndPasswordCombination != null);
    return invalidUsernameAndPasswordCombination(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result serverError(AuthServerError value),
    Result dataFormatError(AuthDataFormatError value),
    Result invalidUsernameAndPasswordCombination(
        InvalidUsernameAndPasswordCombination value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (invalidUsernameAndPasswordCombination != null) {
      return invalidUsernameAndPasswordCombination(this);
    }
    return orElse();
  }
}

abstract class InvalidUsernameAndPasswordCombination implements AuthFailure {
  const factory InvalidUsernameAndPasswordCombination() =
      _$InvalidUsernameAndPasswordCombination;
}

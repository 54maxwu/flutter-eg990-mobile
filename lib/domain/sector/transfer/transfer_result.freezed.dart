// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'transfer_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$TransferResultTearOff {
  const _$TransferResultTearOff();

// ignore: unused_element
  _TransferResult call(
      {int code,
      String status,
      dynamic data,
      @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
          String msg}) {
    return _TransferResult(
      code: code,
      status: status,
      data: data,
      msg: msg,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $TransferResult = _$TransferResultTearOff();

/// @nodoc
mixin _$TransferResult {
  int get code;
  String get status;
  dynamic get data;
  @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
  String get msg;

  $TransferResultCopyWith<TransferResult> get copyWith;
}

/// @nodoc
abstract class $TransferResultCopyWith<$Res> {
  factory $TransferResultCopyWith(
          TransferResult value, $Res Function(TransferResult) then) =
      _$TransferResultCopyWithImpl<$Res>;
  $Res call(
      {int code,
      String status,
      dynamic data,
      @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
          String msg});
}

/// @nodoc
class _$TransferResultCopyWithImpl<$Res>
    implements $TransferResultCopyWith<$Res> {
  _$TransferResultCopyWithImpl(this._value, this._then);

  final TransferResult _value;
  // ignore: unused_field
  final $Res Function(TransferResult) _then;

  @override
  $Res call({
    Object code = freezed,
    Object status = freezed,
    Object data = freezed,
    Object msg = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed ? _value.code : code as int,
      status: status == freezed ? _value.status : status as String,
      data: data == freezed ? _value.data : data as dynamic,
      msg: msg == freezed ? _value.msg : msg as String,
    ));
  }
}

/// @nodoc
abstract class _$TransferResultCopyWith<$Res>
    implements $TransferResultCopyWith<$Res> {
  factory _$TransferResultCopyWith(
          _TransferResult value, $Res Function(_TransferResult) then) =
      __$TransferResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {int code,
      String status,
      dynamic data,
      @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
          String msg});
}

/// @nodoc
class __$TransferResultCopyWithImpl<$Res>
    extends _$TransferResultCopyWithImpl<$Res>
    implements _$TransferResultCopyWith<$Res> {
  __$TransferResultCopyWithImpl(
      _TransferResult _value, $Res Function(_TransferResult) _then)
      : super(_value, (v) => _then(v as _TransferResult));

  @override
  _TransferResult get _value => super._value as _TransferResult;

  @override
  $Res call({
    Object code = freezed,
    Object status = freezed,
    Object data = freezed,
    Object msg = freezed,
  }) {
    return _then(_TransferResult(
      code: code == freezed ? _value.code : code as int,
      status: status == freezed ? _value.status : status as String,
      data: data == freezed ? _value.data : data as dynamic,
      msg: msg == freezed ? _value.msg : msg as String,
    ));
  }
}

/// @nodoc
class _$_TransferResult implements _TransferResult {
  _$_TransferResult(
      {this.code,
      this.status,
      this.data,
      @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
          this.msg});

  @override
  final int code;
  @override
  final String status;
  @override
  final dynamic data;
  @override
  @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
  final String msg;

  bool _didisSuccess = false;
  bool _isSuccess;

  @override
  bool get isSuccess {
    if (_didisSuccess == false) {
      _didisSuccess = true;
      _isSuccess = (code != null && code == 0) ||
          (status != null && status == 'success');
    }
    return _isSuccess;
  }

  @override
  String toString() {
    return 'TransferResult(code: $code, status: $status, data: $data, msg: $msg, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransferResult &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.msg, msg) ||
                const DeepCollectionEquality().equals(other.msg, msg)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(msg);

  @override
  _$TransferResultCopyWith<_TransferResult> get copyWith =>
      __$TransferResultCopyWithImpl<_TransferResult>(this, _$identity);
}

abstract class _TransferResult implements TransferResult {
  factory _TransferResult(
      {int code,
      String status,
      dynamic data,
      @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
          String msg}) = _$_TransferResult;

  @override
  int get code;
  @override
  String get status;
  @override
  dynamic get data;
  @override
  @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
  String get msg;
  @override
  _$TransferResultCopyWith<_TransferResult> get copyWith;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$WalletModelTearOff {
  const _$WalletModelTearOff();

// ignore: unused_element
  _WalletModel call(
      {String auto = '0',
      @JsonKey(name: 'creditlimit', defaultValue: '0.00') String credit}) {
    return _WalletModel(
      auto: auto,
      credit: credit,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $WalletModel = _$WalletModelTearOff();

/// @nodoc
mixin _$WalletModel {
  String get auto;
  @JsonKey(name: 'creditlimit', defaultValue: '0.00')
  String get credit;

  @JsonKey(ignore: true)
  $WalletModelCopyWith<WalletModel> get copyWith;
}

/// @nodoc
abstract class $WalletModelCopyWith<$Res> {
  factory $WalletModelCopyWith(
          WalletModel value, $Res Function(WalletModel) then) =
      _$WalletModelCopyWithImpl<$Res>;
  $Res call(
      {String auto,
      @JsonKey(name: 'creditlimit', defaultValue: '0.00') String credit});
}

/// @nodoc
class _$WalletModelCopyWithImpl<$Res> implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._value, this._then);

  final WalletModel _value;
  // ignore: unused_field
  final $Res Function(WalletModel) _then;

  @override
  $Res call({
    Object auto = freezed,
    Object credit = freezed,
  }) {
    return _then(_value.copyWith(
      auto: auto == freezed ? _value.auto : auto as String,
      credit: credit == freezed ? _value.credit : credit as String,
    ));
  }
}

/// @nodoc
abstract class _$WalletModelCopyWith<$Res>
    implements $WalletModelCopyWith<$Res> {
  factory _$WalletModelCopyWith(
          _WalletModel value, $Res Function(_WalletModel) then) =
      __$WalletModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String auto,
      @JsonKey(name: 'creditlimit', defaultValue: '0.00') String credit});
}

/// @nodoc
class __$WalletModelCopyWithImpl<$Res> extends _$WalletModelCopyWithImpl<$Res>
    implements _$WalletModelCopyWith<$Res> {
  __$WalletModelCopyWithImpl(
      _WalletModel _value, $Res Function(_WalletModel) _then)
      : super(_value, (v) => _then(v as _WalletModel));

  @override
  _WalletModel get _value => super._value as _WalletModel;

  @override
  $Res call({
    Object auto = freezed,
    Object credit = freezed,
  }) {
    return _then(_WalletModel(
      auto: auto == freezed ? _value.auto : auto as String,
      credit: credit == freezed ? _value.credit : credit as String,
    ));
  }
}

/// @nodoc
class _$_WalletModel implements _WalletModel {
  const _$_WalletModel(
      {this.auto = '0',
      @JsonKey(name: 'creditlimit', defaultValue: '0.00') this.credit})
      : assert(auto != null);

  @JsonKey(defaultValue: '0')
  @override
  final String auto;
  @override
  @JsonKey(name: 'creditlimit', defaultValue: '0.00')
  final String credit;

  @override
  String toString() {
    return 'WalletModel(auto: $auto, credit: $credit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletModel &&
            (identical(other.auto, auto) ||
                const DeepCollectionEquality().equals(other.auto, auto)) &&
            (identical(other.credit, credit) ||
                const DeepCollectionEquality().equals(other.credit, credit)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(auto) ^
      const DeepCollectionEquality().hash(credit);

  @JsonKey(ignore: true)
  @override
  _$WalletModelCopyWith<_WalletModel> get copyWith =>
      __$WalletModelCopyWithImpl<_WalletModel>(this, _$identity);
}

abstract class _WalletModel implements WalletModel {
  const factory _WalletModel(
          {String auto,
          @JsonKey(name: 'creditlimit', defaultValue: '0.00') String credit}) =
      _$_WalletModel;

  @override
  String get auto;
  @override
  @JsonKey(name: 'creditlimit', defaultValue: '0.00')
  String get credit;
  @override
  @JsonKey(ignore: true)
  _$WalletModelCopyWith<_WalletModel> get copyWith;
}

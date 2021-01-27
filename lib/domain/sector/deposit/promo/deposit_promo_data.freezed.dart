// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'deposit_promo_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DepositPromoDataTearOff {
  const _$DepositPromoDataTearOff();

// ignore: unused_element
  _DepositPromoData call(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc}) {
    return _DepositPromoData(
      promoId: promoId,
      promoDesc: promoDesc,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DepositPromoData = _$DepositPromoDataTearOff();

/// @nodoc
mixin _$DepositPromoData {
  @JsonKey(name: 'promoid', required: true)
  int get promoId;
  @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
  String get promoDesc;

  @JsonKey(ignore: true)
  $DepositPromoDataCopyWith<DepositPromoData> get copyWith;
}

/// @nodoc
abstract class $DepositPromoDataCopyWith<$Res> {
  factory $DepositPromoDataCopyWith(
          DepositPromoData value, $Res Function(DepositPromoData) then) =
      _$DepositPromoDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc});
}

/// @nodoc
class _$DepositPromoDataCopyWithImpl<$Res>
    implements $DepositPromoDataCopyWith<$Res> {
  _$DepositPromoDataCopyWithImpl(this._value, this._then);

  final DepositPromoData _value;
  // ignore: unused_field
  final $Res Function(DepositPromoData) _then;

  @override
  $Res call({
    Object promoId = freezed,
    Object promoDesc = freezed,
  }) {
    return _then(_value.copyWith(
      promoId: promoId == freezed ? _value.promoId : promoId as int,
      promoDesc: promoDesc == freezed ? _value.promoDesc : promoDesc as String,
    ));
  }
}

/// @nodoc
abstract class _$DepositPromoDataCopyWith<$Res>
    implements $DepositPromoDataCopyWith<$Res> {
  factory _$DepositPromoDataCopyWith(
          _DepositPromoData value, $Res Function(_DepositPromoData) then) =
      __$DepositPromoDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc});
}

/// @nodoc
class __$DepositPromoDataCopyWithImpl<$Res>
    extends _$DepositPromoDataCopyWithImpl<$Res>
    implements _$DepositPromoDataCopyWith<$Res> {
  __$DepositPromoDataCopyWithImpl(
      _DepositPromoData _value, $Res Function(_DepositPromoData) _then)
      : super(_value, (v) => _then(v as _DepositPromoData));

  @override
  _DepositPromoData get _value => super._value as _DepositPromoData;

  @override
  $Res call({
    Object promoId = freezed,
    Object promoDesc = freezed,
  }) {
    return _then(_DepositPromoData(
      promoId: promoId == freezed ? _value.promoId : promoId as int,
      promoDesc: promoDesc == freezed ? _value.promoDesc : promoDesc as String,
    ));
  }
}

/// @nodoc
class _$_DepositPromoData implements _DepositPromoData {
  const _$_DepositPromoData(
      {@JsonKey(name: 'promoid', required: true)
          this.promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          this.promoDesc});

  @override
  @JsonKey(name: 'promoid', required: true)
  final int promoId;
  @override
  @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
  final String promoDesc;

  @override
  String toString() {
    return 'DepositPromoData(promoId: $promoId, promoDesc: $promoDesc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DepositPromoData &&
            (identical(other.promoId, promoId) ||
                const DeepCollectionEquality()
                    .equals(other.promoId, promoId)) &&
            (identical(other.promoDesc, promoDesc) ||
                const DeepCollectionEquality()
                    .equals(other.promoDesc, promoDesc)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(promoId) ^
      const DeepCollectionEquality().hash(promoDesc);

  @JsonKey(ignore: true)
  @override
  _$DepositPromoDataCopyWith<_DepositPromoData> get copyWith =>
      __$DepositPromoDataCopyWithImpl<_DepositPromoData>(this, _$identity);
}

abstract class _DepositPromoData implements DepositPromoData {
  const factory _DepositPromoData(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc}) = _$_DepositPromoData;

  @override
  @JsonKey(name: 'promoid', required: true)
  int get promoId;
  @override
  @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
  String get promoDesc;
  @override
  @JsonKey(ignore: true)
  _$DepositPromoDataCopyWith<_DepositPromoData> get copyWith;
}

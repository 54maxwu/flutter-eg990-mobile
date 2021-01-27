// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bet_record_platform_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$BetRecordPlatformDataTearOff {
  const _$BetRecordPlatformDataTearOff();

// ignore: unused_element
  _BetRecordPlatformData call({num bet, num valid, num payout, dynamic key}) {
    return _BetRecordPlatformData(
      bet: bet,
      valid: valid,
      payout: payout,
      key: key,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $BetRecordPlatformData = _$BetRecordPlatformDataTearOff();

/// @nodoc
mixin _$BetRecordPlatformData {
  num get bet;
  num get valid;
  num get payout;
  dynamic get key;

  @JsonKey(ignore: true)
  $BetRecordPlatformDataCopyWith<BetRecordPlatformData> get copyWith;
}

/// @nodoc
abstract class $BetRecordPlatformDataCopyWith<$Res> {
  factory $BetRecordPlatformDataCopyWith(BetRecordPlatformData value,
          $Res Function(BetRecordPlatformData) then) =
      _$BetRecordPlatformDataCopyWithImpl<$Res>;
  $Res call({num bet, num valid, num payout, dynamic key});
}

/// @nodoc
class _$BetRecordPlatformDataCopyWithImpl<$Res>
    implements $BetRecordPlatformDataCopyWith<$Res> {
  _$BetRecordPlatformDataCopyWithImpl(this._value, this._then);

  final BetRecordPlatformData _value;
  // ignore: unused_field
  final $Res Function(BetRecordPlatformData) _then;

  @override
  $Res call({
    Object bet = freezed,
    Object valid = freezed,
    Object payout = freezed,
    Object key = freezed,
  }) {
    return _then(_value.copyWith(
      bet: bet == freezed ? _value.bet : bet as num,
      valid: valid == freezed ? _value.valid : valid as num,
      payout: payout == freezed ? _value.payout : payout as num,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$BetRecordPlatformDataCopyWith<$Res>
    implements $BetRecordPlatformDataCopyWith<$Res> {
  factory _$BetRecordPlatformDataCopyWith(_BetRecordPlatformData value,
          $Res Function(_BetRecordPlatformData) then) =
      __$BetRecordPlatformDataCopyWithImpl<$Res>;
  @override
  $Res call({num bet, num valid, num payout, dynamic key});
}

/// @nodoc
class __$BetRecordPlatformDataCopyWithImpl<$Res>
    extends _$BetRecordPlatformDataCopyWithImpl<$Res>
    implements _$BetRecordPlatformDataCopyWith<$Res> {
  __$BetRecordPlatformDataCopyWithImpl(_BetRecordPlatformData _value,
      $Res Function(_BetRecordPlatformData) _then)
      : super(_value, (v) => _then(v as _BetRecordPlatformData));

  @override
  _BetRecordPlatformData get _value => super._value as _BetRecordPlatformData;

  @override
  $Res call({
    Object bet = freezed,
    Object valid = freezed,
    Object payout = freezed,
    Object key = freezed,
  }) {
    return _then(_BetRecordPlatformData(
      bet: bet == freezed ? _value.bet : bet as num,
      valid: valid == freezed ? _value.valid : valid as num,
      payout: payout == freezed ? _value.payout : payout as num,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

/// @nodoc
class _$_BetRecordPlatformData implements _BetRecordPlatformData {
  const _$_BetRecordPlatformData({this.bet, this.valid, this.payout, this.key});

  @override
  final num bet;
  @override
  final num valid;
  @override
  final num payout;
  @override
  final dynamic key;

  @override
  String toString() {
    return 'BetRecordPlatformData(bet: $bet, valid: $valid, payout: $payout, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BetRecordPlatformData &&
            (identical(other.bet, bet) ||
                const DeepCollectionEquality().equals(other.bet, bet)) &&
            (identical(other.valid, valid) ||
                const DeepCollectionEquality().equals(other.valid, valid)) &&
            (identical(other.payout, payout) ||
                const DeepCollectionEquality().equals(other.payout, payout)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bet) ^
      const DeepCollectionEquality().hash(valid) ^
      const DeepCollectionEquality().hash(payout) ^
      const DeepCollectionEquality().hash(key);

  @JsonKey(ignore: true)
  @override
  _$BetRecordPlatformDataCopyWith<_BetRecordPlatformData> get copyWith =>
      __$BetRecordPlatformDataCopyWithImpl<_BetRecordPlatformData>(
          this, _$identity);
}

abstract class _BetRecordPlatformData implements BetRecordPlatformData {
  const factory _BetRecordPlatformData(
      {num bet, num valid, num payout, dynamic key}) = _$_BetRecordPlatformData;

  @override
  num get bet;
  @override
  num get valid;
  @override
  num get payout;
  @override
  dynamic get key;
  @override
  @JsonKey(ignore: true)
  _$BetRecordPlatformDataCopyWith<_BetRecordPlatformData> get copyWith;
}

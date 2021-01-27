// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bet_record_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$BetRecordDataTearOff {
  const _$BetRecordDataTearOff();

// ignore: unused_element
  _BetRecordData call(
      {@JsonKey(name: 'activebet') String activeBet,
      @JsonKey(name: 'validbet') String validBet,
      String bet,
      @JsonKey(name: 'betno') String betNo,
      String payout,
      String site,
      @JsonKey(name: 'starttime') String startTime,
      String type,
      dynamic key}) {
    return _BetRecordData(
      activeBet: activeBet,
      validBet: validBet,
      bet: bet,
      betNo: betNo,
      payout: payout,
      site: site,
      startTime: startTime,
      type: type,
      key: key,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $BetRecordData = _$BetRecordDataTearOff();

/// @nodoc
mixin _$BetRecordData {
  @JsonKey(name: 'activebet')
  String get activeBet;
  @JsonKey(name: 'validbet')
  String get validBet;
  String get bet;
  @JsonKey(name: 'betno')
  String get betNo;
  String get payout;
  String get site;
  @JsonKey(name: 'starttime')
  String get startTime;
  String get type;
  dynamic get key;

  @JsonKey(ignore: true)
  $BetRecordDataCopyWith<BetRecordData> get copyWith;
}

/// @nodoc
abstract class $BetRecordDataCopyWith<$Res> {
  factory $BetRecordDataCopyWith(
          BetRecordData value, $Res Function(BetRecordData) then) =
      _$BetRecordDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'activebet') String activeBet,
      @JsonKey(name: 'validbet') String validBet,
      String bet,
      @JsonKey(name: 'betno') String betNo,
      String payout,
      String site,
      @JsonKey(name: 'starttime') String startTime,
      String type,
      dynamic key});
}

/// @nodoc
class _$BetRecordDataCopyWithImpl<$Res>
    implements $BetRecordDataCopyWith<$Res> {
  _$BetRecordDataCopyWithImpl(this._value, this._then);

  final BetRecordData _value;
  // ignore: unused_field
  final $Res Function(BetRecordData) _then;

  @override
  $Res call({
    Object activeBet = freezed,
    Object validBet = freezed,
    Object bet = freezed,
    Object betNo = freezed,
    Object payout = freezed,
    Object site = freezed,
    Object startTime = freezed,
    Object type = freezed,
    Object key = freezed,
  }) {
    return _then(_value.copyWith(
      activeBet: activeBet == freezed ? _value.activeBet : activeBet as String,
      validBet: validBet == freezed ? _value.validBet : validBet as String,
      bet: bet == freezed ? _value.bet : bet as String,
      betNo: betNo == freezed ? _value.betNo : betNo as String,
      payout: payout == freezed ? _value.payout : payout as String,
      site: site == freezed ? _value.site : site as String,
      startTime: startTime == freezed ? _value.startTime : startTime as String,
      type: type == freezed ? _value.type : type as String,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$BetRecordDataCopyWith<$Res>
    implements $BetRecordDataCopyWith<$Res> {
  factory _$BetRecordDataCopyWith(
          _BetRecordData value, $Res Function(_BetRecordData) then) =
      __$BetRecordDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'activebet') String activeBet,
      @JsonKey(name: 'validbet') String validBet,
      String bet,
      @JsonKey(name: 'betno') String betNo,
      String payout,
      String site,
      @JsonKey(name: 'starttime') String startTime,
      String type,
      dynamic key});
}

/// @nodoc
class __$BetRecordDataCopyWithImpl<$Res>
    extends _$BetRecordDataCopyWithImpl<$Res>
    implements _$BetRecordDataCopyWith<$Res> {
  __$BetRecordDataCopyWithImpl(
      _BetRecordData _value, $Res Function(_BetRecordData) _then)
      : super(_value, (v) => _then(v as _BetRecordData));

  @override
  _BetRecordData get _value => super._value as _BetRecordData;

  @override
  $Res call({
    Object activeBet = freezed,
    Object validBet = freezed,
    Object bet = freezed,
    Object betNo = freezed,
    Object payout = freezed,
    Object site = freezed,
    Object startTime = freezed,
    Object type = freezed,
    Object key = freezed,
  }) {
    return _then(_BetRecordData(
      activeBet: activeBet == freezed ? _value.activeBet : activeBet as String,
      validBet: validBet == freezed ? _value.validBet : validBet as String,
      bet: bet == freezed ? _value.bet : bet as String,
      betNo: betNo == freezed ? _value.betNo : betNo as String,
      payout: payout == freezed ? _value.payout : payout as String,
      site: site == freezed ? _value.site : site as String,
      startTime: startTime == freezed ? _value.startTime : startTime as String,
      type: type == freezed ? _value.type : type as String,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

/// @nodoc
class _$_BetRecordData implements _BetRecordData {
  const _$_BetRecordData(
      {@JsonKey(name: 'activebet') this.activeBet,
      @JsonKey(name: 'validbet') this.validBet,
      this.bet,
      @JsonKey(name: 'betno') this.betNo,
      this.payout,
      this.site,
      @JsonKey(name: 'starttime') this.startTime,
      this.type,
      this.key});

  @override
  @JsonKey(name: 'activebet')
  final String activeBet;
  @override
  @JsonKey(name: 'validbet')
  final String validBet;
  @override
  final String bet;
  @override
  @JsonKey(name: 'betno')
  final String betNo;
  @override
  final String payout;
  @override
  final String site;
  @override
  @JsonKey(name: 'starttime')
  final String startTime;
  @override
  final String type;
  @override
  final dynamic key;

  @override
  String toString() {
    return 'BetRecordData(activeBet: $activeBet, validBet: $validBet, bet: $bet, betNo: $betNo, payout: $payout, site: $site, startTime: $startTime, type: $type, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BetRecordData &&
            (identical(other.activeBet, activeBet) ||
                const DeepCollectionEquality()
                    .equals(other.activeBet, activeBet)) &&
            (identical(other.validBet, validBet) ||
                const DeepCollectionEquality()
                    .equals(other.validBet, validBet)) &&
            (identical(other.bet, bet) ||
                const DeepCollectionEquality().equals(other.bet, bet)) &&
            (identical(other.betNo, betNo) ||
                const DeepCollectionEquality().equals(other.betNo, betNo)) &&
            (identical(other.payout, payout) ||
                const DeepCollectionEquality().equals(other.payout, payout)) &&
            (identical(other.site, site) ||
                const DeepCollectionEquality().equals(other.site, site)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(activeBet) ^
      const DeepCollectionEquality().hash(validBet) ^
      const DeepCollectionEquality().hash(bet) ^
      const DeepCollectionEquality().hash(betNo) ^
      const DeepCollectionEquality().hash(payout) ^
      const DeepCollectionEquality().hash(site) ^
      const DeepCollectionEquality().hash(startTime) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(key);

  @JsonKey(ignore: true)
  @override
  _$BetRecordDataCopyWith<_BetRecordData> get copyWith =>
      __$BetRecordDataCopyWithImpl<_BetRecordData>(this, _$identity);
}

abstract class _BetRecordData implements BetRecordData {
  const factory _BetRecordData(
      {@JsonKey(name: 'activebet') String activeBet,
      @JsonKey(name: 'validbet') String validBet,
      String bet,
      @JsonKey(name: 'betno') String betNo,
      String payout,
      String site,
      @JsonKey(name: 'starttime') String startTime,
      String type,
      dynamic key}) = _$_BetRecordData;

  @override
  @JsonKey(name: 'activebet')
  String get activeBet;
  @override
  @JsonKey(name: 'validbet')
  String get validBet;
  @override
  String get bet;
  @override
  @JsonKey(name: 'betno')
  String get betNo;
  @override
  String get payout;
  @override
  String get site;
  @override
  @JsonKey(name: 'starttime')
  String get startTime;
  @override
  String get type;
  @override
  dynamic get key;
  @override
  @JsonKey(ignore: true)
  _$BetRecordDataCopyWith<_BetRecordData> get copyWith;
}

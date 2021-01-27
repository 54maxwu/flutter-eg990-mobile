// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agent_ledger_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AgentLedgerFormTearOff {
  const _$AgentLedgerFormTearOff();

// ignore: unused_element
  _AgentLedgerForm call(
      {@required String startTime,
      @required String endTime,
      String account = '',
      bool depositOnly = false,
      int page = 1,
      String select = ''}) {
    return _AgentLedgerForm(
      startTime: startTime,
      endTime: endTime,
      account: account,
      depositOnly: depositOnly,
      page: page,
      select: select,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AgentLedgerForm = _$AgentLedgerFormTearOff();

/// @nodoc
mixin _$AgentLedgerForm {
  String get startTime;
  String get endTime;
  String get account;
  bool get depositOnly;
  int get page;
  String get select;

  $AgentLedgerFormCopyWith<AgentLedgerForm> get copyWith;
}

/// @nodoc
abstract class $AgentLedgerFormCopyWith<$Res> {
  factory $AgentLedgerFormCopyWith(
          AgentLedgerForm value, $Res Function(AgentLedgerForm) then) =
      _$AgentLedgerFormCopyWithImpl<$Res>;
  $Res call(
      {String startTime,
      String endTime,
      String account,
      bool depositOnly,
      int page,
      String select});
}

/// @nodoc
class _$AgentLedgerFormCopyWithImpl<$Res>
    implements $AgentLedgerFormCopyWith<$Res> {
  _$AgentLedgerFormCopyWithImpl(this._value, this._then);

  final AgentLedgerForm _value;
  // ignore: unused_field
  final $Res Function(AgentLedgerForm) _then;

  @override
  $Res call({
    Object startTime = freezed,
    Object endTime = freezed,
    Object account = freezed,
    Object depositOnly = freezed,
    Object page = freezed,
    Object select = freezed,
  }) {
    return _then(_value.copyWith(
      startTime: startTime == freezed ? _value.startTime : startTime as String,
      endTime: endTime == freezed ? _value.endTime : endTime as String,
      account: account == freezed ? _value.account : account as String,
      depositOnly:
          depositOnly == freezed ? _value.depositOnly : depositOnly as bool,
      page: page == freezed ? _value.page : page as int,
      select: select == freezed ? _value.select : select as String,
    ));
  }
}

/// @nodoc
abstract class _$AgentLedgerFormCopyWith<$Res>
    implements $AgentLedgerFormCopyWith<$Res> {
  factory _$AgentLedgerFormCopyWith(
          _AgentLedgerForm value, $Res Function(_AgentLedgerForm) then) =
      __$AgentLedgerFormCopyWithImpl<$Res>;
  @override
  $Res call(
      {String startTime,
      String endTime,
      String account,
      bool depositOnly,
      int page,
      String select});
}

/// @nodoc
class __$AgentLedgerFormCopyWithImpl<$Res>
    extends _$AgentLedgerFormCopyWithImpl<$Res>
    implements _$AgentLedgerFormCopyWith<$Res> {
  __$AgentLedgerFormCopyWithImpl(
      _AgentLedgerForm _value, $Res Function(_AgentLedgerForm) _then)
      : super(_value, (v) => _then(v as _AgentLedgerForm));

  @override
  _AgentLedgerForm get _value => super._value as _AgentLedgerForm;

  @override
  $Res call({
    Object startTime = freezed,
    Object endTime = freezed,
    Object account = freezed,
    Object depositOnly = freezed,
    Object page = freezed,
    Object select = freezed,
  }) {
    return _then(_AgentLedgerForm(
      startTime: startTime == freezed ? _value.startTime : startTime as String,
      endTime: endTime == freezed ? _value.endTime : endTime as String,
      account: account == freezed ? _value.account : account as String,
      depositOnly:
          depositOnly == freezed ? _value.depositOnly : depositOnly as bool,
      page: page == freezed ? _value.page : page as int,
      select: select == freezed ? _value.select : select as String,
    ));
  }
}

/// @nodoc
class _$_AgentLedgerForm implements _AgentLedgerForm {
  const _$_AgentLedgerForm(
      {@required this.startTime,
      @required this.endTime,
      this.account = '',
      this.depositOnly = false,
      this.page = 1,
      this.select = ''})
      : assert(startTime != null),
        assert(endTime != null),
        assert(account != null),
        assert(depositOnly != null),
        assert(page != null),
        assert(select != null);

  @override
  final String startTime;
  @override
  final String endTime;
  @JsonKey(defaultValue: '')
  @override
  final String account;
  @JsonKey(defaultValue: false)
  @override
  final bool depositOnly;
  @JsonKey(defaultValue: 1)
  @override
  final int page;
  @JsonKey(defaultValue: '')
  @override
  final String select;

  @override
  String toString() {
    return 'AgentLedgerForm(startTime: $startTime, endTime: $endTime, account: $account, depositOnly: $depositOnly, page: $page, select: $select)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgentLedgerForm &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)) &&
            (identical(other.endTime, endTime) ||
                const DeepCollectionEquality()
                    .equals(other.endTime, endTime)) &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.depositOnly, depositOnly) ||
                const DeepCollectionEquality()
                    .equals(other.depositOnly, depositOnly)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.select, select) ||
                const DeepCollectionEquality().equals(other.select, select)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(startTime) ^
      const DeepCollectionEquality().hash(endTime) ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(depositOnly) ^
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(select);

  @override
  _$AgentLedgerFormCopyWith<_AgentLedgerForm> get copyWith =>
      __$AgentLedgerFormCopyWithImpl<_AgentLedgerForm>(this, _$identity);
}

abstract class _AgentLedgerForm implements AgentLedgerForm {
  const factory _AgentLedgerForm(
      {@required String startTime,
      @required String endTime,
      String account,
      bool depositOnly,
      int page,
      String select}) = _$_AgentLedgerForm;

  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get account;
  @override
  bool get depositOnly;
  @override
  int get page;
  @override
  String get select;
  @override
  _$AgentLedgerFormCopyWith<_AgentLedgerForm> get copyWith;
}

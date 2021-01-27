// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AgentModelTearOff {
  const _$AgentModelTearOff();

// ignore: unused_element
  _AgentModel call(
      {@JsonKey(name: 'accountcode') String account,
      @JsonKey(name: 'creditlimit') String credit,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'success') String success,
      @JsonKey(name: 'vip') int vip,
      @JsonKey(name: 'vip_img') String vipImg,
      @JsonKey(name: 'vip_name') String vipName}) {
    return _AgentModel(
      account: account,
      credit: credit,
      status: status,
      success: success,
      vip: vip,
      vipImg: vipImg,
      vipName: vipName,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AgentModel = _$AgentModelTearOff();

/// @nodoc
mixin _$AgentModel {
  @JsonKey(name: 'accountcode')
  String get account;
  @JsonKey(name: 'creditlimit')
  String get credit;
  @JsonKey(name: 'status')
  String get status;
  @JsonKey(name: 'success')
  String get success;
  @JsonKey(name: 'vip')
  int get vip;
  @JsonKey(name: 'vip_img')
  String get vipImg;
  @JsonKey(name: 'vip_name')
  String get vipName;

  $AgentModelCopyWith<AgentModel> get copyWith;
}

/// @nodoc
abstract class $AgentModelCopyWith<$Res> {
  factory $AgentModelCopyWith(
          AgentModel value, $Res Function(AgentModel) then) =
      _$AgentModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'accountcode') String account,
      @JsonKey(name: 'creditlimit') String credit,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'success') String success,
      @JsonKey(name: 'vip') int vip,
      @JsonKey(name: 'vip_img') String vipImg,
      @JsonKey(name: 'vip_name') String vipName});
}

/// @nodoc
class _$AgentModelCopyWithImpl<$Res> implements $AgentModelCopyWith<$Res> {
  _$AgentModelCopyWithImpl(this._value, this._then);

  final AgentModel _value;
  // ignore: unused_field
  final $Res Function(AgentModel) _then;

  @override
  $Res call({
    Object account = freezed,
    Object credit = freezed,
    Object status = freezed,
    Object success = freezed,
    Object vip = freezed,
    Object vipImg = freezed,
    Object vipName = freezed,
  }) {
    return _then(_value.copyWith(
      account: account == freezed ? _value.account : account as String,
      credit: credit == freezed ? _value.credit : credit as String,
      status: status == freezed ? _value.status : status as String,
      success: success == freezed ? _value.success : success as String,
      vip: vip == freezed ? _value.vip : vip as int,
      vipImg: vipImg == freezed ? _value.vipImg : vipImg as String,
      vipName: vipName == freezed ? _value.vipName : vipName as String,
    ));
  }
}

/// @nodoc
abstract class _$AgentModelCopyWith<$Res> implements $AgentModelCopyWith<$Res> {
  factory _$AgentModelCopyWith(
          _AgentModel value, $Res Function(_AgentModel) then) =
      __$AgentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'accountcode') String account,
      @JsonKey(name: 'creditlimit') String credit,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'success') String success,
      @JsonKey(name: 'vip') int vip,
      @JsonKey(name: 'vip_img') String vipImg,
      @JsonKey(name: 'vip_name') String vipName});
}

/// @nodoc
class __$AgentModelCopyWithImpl<$Res> extends _$AgentModelCopyWithImpl<$Res>
    implements _$AgentModelCopyWith<$Res> {
  __$AgentModelCopyWithImpl(
      _AgentModel _value, $Res Function(_AgentModel) _then)
      : super(_value, (v) => _then(v as _AgentModel));

  @override
  _AgentModel get _value => super._value as _AgentModel;

  @override
  $Res call({
    Object account = freezed,
    Object credit = freezed,
    Object status = freezed,
    Object success = freezed,
    Object vip = freezed,
    Object vipImg = freezed,
    Object vipName = freezed,
  }) {
    return _then(_AgentModel(
      account: account == freezed ? _value.account : account as String,
      credit: credit == freezed ? _value.credit : credit as String,
      status: status == freezed ? _value.status : status as String,
      success: success == freezed ? _value.success : success as String,
      vip: vip == freezed ? _value.vip : vip as int,
      vipImg: vipImg == freezed ? _value.vipImg : vipImg as String,
      vipName: vipName == freezed ? _value.vipName : vipName as String,
    ));
  }
}

/// @nodoc
class _$_AgentModel implements _AgentModel {
  const _$_AgentModel(
      {@JsonKey(name: 'accountcode') this.account,
      @JsonKey(name: 'creditlimit') this.credit,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'success') this.success,
      @JsonKey(name: 'vip') this.vip,
      @JsonKey(name: 'vip_img') this.vipImg,
      @JsonKey(name: 'vip_name') this.vipName});

  @override
  @JsonKey(name: 'accountcode')
  final String account;
  @override
  @JsonKey(name: 'creditlimit')
  final String credit;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'success')
  final String success;
  @override
  @JsonKey(name: 'vip')
  final int vip;
  @override
  @JsonKey(name: 'vip_img')
  final String vipImg;
  @override
  @JsonKey(name: 'vip_name')
  final String vipName;

  @override
  String toString() {
    return 'AgentModel(account: $account, credit: $credit, status: $status, success: $success, vip: $vip, vipImg: $vipImg, vipName: $vipName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgentModel &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.credit, credit) ||
                const DeepCollectionEquality().equals(other.credit, credit)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.vip, vip) ||
                const DeepCollectionEquality().equals(other.vip, vip)) &&
            (identical(other.vipImg, vipImg) ||
                const DeepCollectionEquality().equals(other.vipImg, vipImg)) &&
            (identical(other.vipName, vipName) ||
                const DeepCollectionEquality().equals(other.vipName, vipName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(credit) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(vip) ^
      const DeepCollectionEquality().hash(vipImg) ^
      const DeepCollectionEquality().hash(vipName);

  @override
  _$AgentModelCopyWith<_AgentModel> get copyWith =>
      __$AgentModelCopyWithImpl<_AgentModel>(this, _$identity);
}

abstract class _AgentModel implements AgentModel {
  const factory _AgentModel(
      {@JsonKey(name: 'accountcode') String account,
      @JsonKey(name: 'creditlimit') String credit,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'success') String success,
      @JsonKey(name: 'vip') int vip,
      @JsonKey(name: 'vip_img') String vipImg,
      @JsonKey(name: 'vip_name') String vipName}) = _$_AgentModel;

  @override
  @JsonKey(name: 'accountcode')
  String get account;
  @override
  @JsonKey(name: 'creditlimit')
  String get credit;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'success')
  String get success;
  @override
  @JsonKey(name: 'vip')
  int get vip;
  @override
  @JsonKey(name: 'vip_img')
  String get vipImg;
  @override
  @JsonKey(name: 'vip_name')
  String get vipName;
  @override
  _$AgentModelCopyWith<_AgentModel> get copyWith;
}

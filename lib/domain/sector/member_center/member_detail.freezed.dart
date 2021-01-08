// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'member_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MemberDetailTearOff {
  const _$MemberDetailTearOff();

// ignore: unused_element
  _MemberDetail call(
      {String accountCode,
      int accountId,
      String birthDate,
      String phone,
      String gender,
      String email,
      String wechat,
      String zalo,
      String firstName,
      String autoTransfer}) {
    return _MemberDetail(
      accountCode: accountCode,
      accountId: accountId,
      birthDate: birthDate,
      phone: phone,
      gender: gender,
      email: email,
      wechat: wechat,
      zalo: zalo,
      firstName: firstName,
      autoTransfer: autoTransfer,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MemberDetail = _$MemberDetailTearOff();

/// @nodoc
mixin _$MemberDetail {
  String get accountCode;
  int get accountId;
  String get birthDate;
  String get phone;
  String get gender;
  String get email;
  String get wechat;
  String get zalo;
  String get firstName;
  String get autoTransfer;

  $MemberDetailCopyWith<MemberDetail> get copyWith;
}

/// @nodoc
abstract class $MemberDetailCopyWith<$Res> {
  factory $MemberDetailCopyWith(
          MemberDetail value, $Res Function(MemberDetail) then) =
      _$MemberDetailCopyWithImpl<$Res>;
  $Res call(
      {String accountCode,
      int accountId,
      String birthDate,
      String phone,
      String gender,
      String email,
      String wechat,
      String zalo,
      String firstName,
      String autoTransfer});
}

/// @nodoc
class _$MemberDetailCopyWithImpl<$Res> implements $MemberDetailCopyWith<$Res> {
  _$MemberDetailCopyWithImpl(this._value, this._then);

  final MemberDetail _value;
  // ignore: unused_field
  final $Res Function(MemberDetail) _then;

  @override
  $Res call({
    Object accountCode = freezed,
    Object accountId = freezed,
    Object birthDate = freezed,
    Object phone = freezed,
    Object gender = freezed,
    Object email = freezed,
    Object wechat = freezed,
    Object zalo = freezed,
    Object firstName = freezed,
    Object autoTransfer = freezed,
  }) {
    return _then(_value.copyWith(
      accountCode:
          accountCode == freezed ? _value.accountCode : accountCode as String,
      accountId: accountId == freezed ? _value.accountId : accountId as int,
      birthDate: birthDate == freezed ? _value.birthDate : birthDate as String,
      phone: phone == freezed ? _value.phone : phone as String,
      gender: gender == freezed ? _value.gender : gender as String,
      email: email == freezed ? _value.email : email as String,
      wechat: wechat == freezed ? _value.wechat : wechat as String,
      zalo: zalo == freezed ? _value.zalo : zalo as String,
      firstName: firstName == freezed ? _value.firstName : firstName as String,
      autoTransfer: autoTransfer == freezed
          ? _value.autoTransfer
          : autoTransfer as String,
    ));
  }
}

/// @nodoc
abstract class _$MemberDetailCopyWith<$Res>
    implements $MemberDetailCopyWith<$Res> {
  factory _$MemberDetailCopyWith(
          _MemberDetail value, $Res Function(_MemberDetail) then) =
      __$MemberDetailCopyWithImpl<$Res>;
  @override
  $Res call(
      {String accountCode,
      int accountId,
      String birthDate,
      String phone,
      String gender,
      String email,
      String wechat,
      String zalo,
      String firstName,
      String autoTransfer});
}

/// @nodoc
class __$MemberDetailCopyWithImpl<$Res> extends _$MemberDetailCopyWithImpl<$Res>
    implements _$MemberDetailCopyWith<$Res> {
  __$MemberDetailCopyWithImpl(
      _MemberDetail _value, $Res Function(_MemberDetail) _then)
      : super(_value, (v) => _then(v as _MemberDetail));

  @override
  _MemberDetail get _value => super._value as _MemberDetail;

  @override
  $Res call({
    Object accountCode = freezed,
    Object accountId = freezed,
    Object birthDate = freezed,
    Object phone = freezed,
    Object gender = freezed,
    Object email = freezed,
    Object wechat = freezed,
    Object zalo = freezed,
    Object firstName = freezed,
    Object autoTransfer = freezed,
  }) {
    return _then(_MemberDetail(
      accountCode:
          accountCode == freezed ? _value.accountCode : accountCode as String,
      accountId: accountId == freezed ? _value.accountId : accountId as int,
      birthDate: birthDate == freezed ? _value.birthDate : birthDate as String,
      phone: phone == freezed ? _value.phone : phone as String,
      gender: gender == freezed ? _value.gender : gender as String,
      email: email == freezed ? _value.email : email as String,
      wechat: wechat == freezed ? _value.wechat : wechat as String,
      zalo: zalo == freezed ? _value.zalo : zalo as String,
      firstName: firstName == freezed ? _value.firstName : firstName as String,
      autoTransfer: autoTransfer == freezed
          ? _value.autoTransfer
          : autoTransfer as String,
    ));
  }
}

/// @nodoc
class _$_MemberDetail implements _MemberDetail {
  const _$_MemberDetail(
      {this.accountCode,
      this.accountId,
      this.birthDate,
      this.phone,
      this.gender,
      this.email,
      this.wechat,
      this.zalo,
      this.firstName,
      this.autoTransfer});

  @override
  final String accountCode;
  @override
  final int accountId;
  @override
  final String birthDate;
  @override
  final String phone;
  @override
  final String gender;
  @override
  final String email;
  @override
  final String wechat;
  @override
  final String zalo;
  @override
  final String firstName;
  @override
  final String autoTransfer;

  @override
  String toString() {
    return 'MemberDetail(accountCode: $accountCode, accountId: $accountId, birthDate: $birthDate, phone: $phone, gender: $gender, email: $email, wechat: $wechat, zalo: $zalo, firstName: $firstName, autoTransfer: $autoTransfer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MemberDetail &&
            (identical(other.accountCode, accountCode) ||
                const DeepCollectionEquality()
                    .equals(other.accountCode, accountCode)) &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality()
                    .equals(other.accountId, accountId)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality()
                    .equals(other.birthDate, birthDate)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.wechat, wechat) ||
                const DeepCollectionEquality().equals(other.wechat, wechat)) &&
            (identical(other.zalo, zalo) ||
                const DeepCollectionEquality().equals(other.zalo, zalo)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.autoTransfer, autoTransfer) ||
                const DeepCollectionEquality()
                    .equals(other.autoTransfer, autoTransfer)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(accountCode) ^
      const DeepCollectionEquality().hash(accountId) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(wechat) ^
      const DeepCollectionEquality().hash(zalo) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(autoTransfer);

  @override
  _$MemberDetailCopyWith<_MemberDetail> get copyWith =>
      __$MemberDetailCopyWithImpl<_MemberDetail>(this, _$identity);
}

abstract class _MemberDetail implements MemberDetail {
  const factory _MemberDetail(
      {String accountCode,
      int accountId,
      String birthDate,
      String phone,
      String gender,
      String email,
      String wechat,
      String zalo,
      String firstName,
      String autoTransfer}) = _$_MemberDetail;

  @override
  String get accountCode;
  @override
  int get accountId;
  @override
  String get birthDate;
  @override
  String get phone;
  @override
  String get gender;
  @override
  String get email;
  @override
  String get wechat;
  @override
  String get zalo;
  @override
  String get firstName;
  @override
  String get autoTransfer;
  @override
  _$MemberDetailCopyWith<_MemberDetail> get copyWith;
}

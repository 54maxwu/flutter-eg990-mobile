// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agent_downline_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AgentDownlineFormTearOff {
  const _$AgentDownlineFormTearOff();

// ignore: unused_element
  _AgentDownlineForm call(
      {@required String username,
      @required String password,
      @required String confirmPassword,
      @required String phone,
      @required String appContact}) {
    return _AgentDownlineForm(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      appContact: appContact,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AgentDownlineForm = _$AgentDownlineFormTearOff();

/// @nodoc
mixin _$AgentDownlineForm {
  String get username;
  String get password;
  String get confirmPassword;
  String get phone;
  String get appContact;

  $AgentDownlineFormCopyWith<AgentDownlineForm> get copyWith;
}

/// @nodoc
abstract class $AgentDownlineFormCopyWith<$Res> {
  factory $AgentDownlineFormCopyWith(
          AgentDownlineForm value, $Res Function(AgentDownlineForm) then) =
      _$AgentDownlineFormCopyWithImpl<$Res>;
  $Res call(
      {String username,
      String password,
      String confirmPassword,
      String phone,
      String appContact});
}

/// @nodoc
class _$AgentDownlineFormCopyWithImpl<$Res>
    implements $AgentDownlineFormCopyWith<$Res> {
  _$AgentDownlineFormCopyWithImpl(this._value, this._then);

  final AgentDownlineForm _value;
  // ignore: unused_field
  final $Res Function(AgentDownlineForm) _then;

  @override
  $Res call({
    Object username = freezed,
    Object password = freezed,
    Object confirmPassword = freezed,
    Object phone = freezed,
    Object appContact = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed ? _value.username : username as String,
      password: password == freezed ? _value.password : password as String,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword as String,
      phone: phone == freezed ? _value.phone : phone as String,
      appContact:
          appContact == freezed ? _value.appContact : appContact as String,
    ));
  }
}

/// @nodoc
abstract class _$AgentDownlineFormCopyWith<$Res>
    implements $AgentDownlineFormCopyWith<$Res> {
  factory _$AgentDownlineFormCopyWith(
          _AgentDownlineForm value, $Res Function(_AgentDownlineForm) then) =
      __$AgentDownlineFormCopyWithImpl<$Res>;
  @override
  $Res call(
      {String username,
      String password,
      String confirmPassword,
      String phone,
      String appContact});
}

/// @nodoc
class __$AgentDownlineFormCopyWithImpl<$Res>
    extends _$AgentDownlineFormCopyWithImpl<$Res>
    implements _$AgentDownlineFormCopyWith<$Res> {
  __$AgentDownlineFormCopyWithImpl(
      _AgentDownlineForm _value, $Res Function(_AgentDownlineForm) _then)
      : super(_value, (v) => _then(v as _AgentDownlineForm));

  @override
  _AgentDownlineForm get _value => super._value as _AgentDownlineForm;

  @override
  $Res call({
    Object username = freezed,
    Object password = freezed,
    Object confirmPassword = freezed,
    Object phone = freezed,
    Object appContact = freezed,
  }) {
    return _then(_AgentDownlineForm(
      username: username == freezed ? _value.username : username as String,
      password: password == freezed ? _value.password : password as String,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword as String,
      phone: phone == freezed ? _value.phone : phone as String,
      appContact:
          appContact == freezed ? _value.appContact : appContact as String,
    ));
  }
}

/// @nodoc
class _$_AgentDownlineForm implements _AgentDownlineForm {
  const _$_AgentDownlineForm(
      {@required this.username,
      @required this.password,
      @required this.confirmPassword,
      @required this.phone,
      @required this.appContact})
      : assert(username != null),
        assert(password != null),
        assert(confirmPassword != null),
        assert(phone != null),
        assert(appContact != null);

  @override
  final String username;
  @override
  final String password;
  @override
  final String confirmPassword;
  @override
  final String phone;
  @override
  final String appContact;

  @override
  String toString() {
    return 'AgentDownlineForm(username: $username, password: $password, confirmPassword: $confirmPassword, phone: $phone, appContact: $appContact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgentDownlineForm &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.confirmPassword, confirmPassword) ||
                const DeepCollectionEquality()
                    .equals(other.confirmPassword, confirmPassword)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.appContact, appContact) ||
                const DeepCollectionEquality()
                    .equals(other.appContact, appContact)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(confirmPassword) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(appContact);

  @override
  _$AgentDownlineFormCopyWith<_AgentDownlineForm> get copyWith =>
      __$AgentDownlineFormCopyWithImpl<_AgentDownlineForm>(this, _$identity);
}

abstract class _AgentDownlineForm implements AgentDownlineForm {
  const factory _AgentDownlineForm(
      {@required String username,
      @required String password,
      @required String confirmPassword,
      @required String phone,
      @required String appContact}) = _$_AgentDownlineForm;

  @override
  String get username;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  String get phone;
  @override
  String get appContact;
  @override
  _$AgentDownlineFormCopyWith<_AgentDownlineForm> get copyWith;
}

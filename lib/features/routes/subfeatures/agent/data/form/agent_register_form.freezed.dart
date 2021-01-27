// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agent_register_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AgentRegisterFormTearOff {
  const _$AgentRegisterFormTearOff();

// ignore: unused_element
  _AgentRegisterForm call(
      {@required String username,
      @required String password,
      @required String confirmPassword,
      @required String phone,
      @required String email,
      @required String appContact}) {
    return _AgentRegisterForm(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      email: email,
      appContact: appContact,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AgentRegisterForm = _$AgentRegisterFormTearOff();

/// @nodoc
mixin _$AgentRegisterForm {
  String get username;
  String get password;
  String get confirmPassword;
  String get phone;
  String get email;
  String get appContact;

  $AgentRegisterFormCopyWith<AgentRegisterForm> get copyWith;
}

/// @nodoc
abstract class $AgentRegisterFormCopyWith<$Res> {
  factory $AgentRegisterFormCopyWith(
          AgentRegisterForm value, $Res Function(AgentRegisterForm) then) =
      _$AgentRegisterFormCopyWithImpl<$Res>;
  $Res call(
      {String username,
      String password,
      String confirmPassword,
      String phone,
      String email,
      String appContact});
}

/// @nodoc
class _$AgentRegisterFormCopyWithImpl<$Res>
    implements $AgentRegisterFormCopyWith<$Res> {
  _$AgentRegisterFormCopyWithImpl(this._value, this._then);

  final AgentRegisterForm _value;
  // ignore: unused_field
  final $Res Function(AgentRegisterForm) _then;

  @override
  $Res call({
    Object username = freezed,
    Object password = freezed,
    Object confirmPassword = freezed,
    Object phone = freezed,
    Object email = freezed,
    Object appContact = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed ? _value.username : username as String,
      password: password == freezed ? _value.password : password as String,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword as String,
      phone: phone == freezed ? _value.phone : phone as String,
      email: email == freezed ? _value.email : email as String,
      appContact:
          appContact == freezed ? _value.appContact : appContact as String,
    ));
  }
}

/// @nodoc
abstract class _$AgentRegisterFormCopyWith<$Res>
    implements $AgentRegisterFormCopyWith<$Res> {
  factory _$AgentRegisterFormCopyWith(
          _AgentRegisterForm value, $Res Function(_AgentRegisterForm) then) =
      __$AgentRegisterFormCopyWithImpl<$Res>;
  @override
  $Res call(
      {String username,
      String password,
      String confirmPassword,
      String phone,
      String email,
      String appContact});
}

/// @nodoc
class __$AgentRegisterFormCopyWithImpl<$Res>
    extends _$AgentRegisterFormCopyWithImpl<$Res>
    implements _$AgentRegisterFormCopyWith<$Res> {
  __$AgentRegisterFormCopyWithImpl(
      _AgentRegisterForm _value, $Res Function(_AgentRegisterForm) _then)
      : super(_value, (v) => _then(v as _AgentRegisterForm));

  @override
  _AgentRegisterForm get _value => super._value as _AgentRegisterForm;

  @override
  $Res call({
    Object username = freezed,
    Object password = freezed,
    Object confirmPassword = freezed,
    Object phone = freezed,
    Object email = freezed,
    Object appContact = freezed,
  }) {
    return _then(_AgentRegisterForm(
      username: username == freezed ? _value.username : username as String,
      password: password == freezed ? _value.password : password as String,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword as String,
      phone: phone == freezed ? _value.phone : phone as String,
      email: email == freezed ? _value.email : email as String,
      appContact:
          appContact == freezed ? _value.appContact : appContact as String,
    ));
  }
}

/// @nodoc
class _$_AgentRegisterForm implements _AgentRegisterForm {
  const _$_AgentRegisterForm(
      {@required this.username,
      @required this.password,
      @required this.confirmPassword,
      @required this.phone,
      @required this.email,
      @required this.appContact})
      : assert(username != null),
        assert(password != null),
        assert(confirmPassword != null),
        assert(phone != null),
        assert(email != null),
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
  final String email;
  @override
  final String appContact;

  @override
  String toString() {
    return 'AgentRegisterForm(username: $username, password: $password, confirmPassword: $confirmPassword, phone: $phone, email: $email, appContact: $appContact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgentRegisterForm &&
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
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
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
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(appContact);

  @override
  _$AgentRegisterFormCopyWith<_AgentRegisterForm> get copyWith =>
      __$AgentRegisterFormCopyWithImpl<_AgentRegisterForm>(this, _$identity);
}

abstract class _AgentRegisterForm implements AgentRegisterForm {
  const factory _AgentRegisterForm(
      {@required String username,
      @required String password,
      @required String confirmPassword,
      @required String phone,
      @required String email,
      @required String appContact}) = _$_AgentRegisterForm;

  @override
  String get username;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  String get phone;
  @override
  String get email;
  @override
  String get appContact;
  @override
  _$AgentRegisterFormCopyWith<_AgentRegisterForm> get copyWith;
}

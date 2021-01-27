// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agent_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AgentEntityTearOff {
  const _$AgentEntityTearOff();

// ignore: unused_element
  _AgentEntity call(
      {String account = '',
      bool hasValidToken = false,
      AgentLevel level = AgentLevel.UNKNOWN}) {
    return _AgentEntity(
      account: account,
      hasValidToken: hasValidToken,
      level: level,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AgentEntity = _$AgentEntityTearOff();

/// @nodoc
mixin _$AgentEntity {
  String get account;
  bool get hasValidToken;
  AgentLevel get level;

  $AgentEntityCopyWith<AgentEntity> get copyWith;
}

/// @nodoc
abstract class $AgentEntityCopyWith<$Res> {
  factory $AgentEntityCopyWith(
          AgentEntity value, $Res Function(AgentEntity) then) =
      _$AgentEntityCopyWithImpl<$Res>;
  $Res call({String account, bool hasValidToken, AgentLevel level});
}

/// @nodoc
class _$AgentEntityCopyWithImpl<$Res> implements $AgentEntityCopyWith<$Res> {
  _$AgentEntityCopyWithImpl(this._value, this._then);

  final AgentEntity _value;
  // ignore: unused_field
  final $Res Function(AgentEntity) _then;

  @override
  $Res call({
    Object account = freezed,
    Object hasValidToken = freezed,
    Object level = freezed,
  }) {
    return _then(_value.copyWith(
      account: account == freezed ? _value.account : account as String,
      hasValidToken: hasValidToken == freezed
          ? _value.hasValidToken
          : hasValidToken as bool,
      level: level == freezed ? _value.level : level as AgentLevel,
    ));
  }
}

/// @nodoc
abstract class _$AgentEntityCopyWith<$Res>
    implements $AgentEntityCopyWith<$Res> {
  factory _$AgentEntityCopyWith(
          _AgentEntity value, $Res Function(_AgentEntity) then) =
      __$AgentEntityCopyWithImpl<$Res>;
  @override
  $Res call({String account, bool hasValidToken, AgentLevel level});
}

/// @nodoc
class __$AgentEntityCopyWithImpl<$Res> extends _$AgentEntityCopyWithImpl<$Res>
    implements _$AgentEntityCopyWith<$Res> {
  __$AgentEntityCopyWithImpl(
      _AgentEntity _value, $Res Function(_AgentEntity) _then)
      : super(_value, (v) => _then(v as _AgentEntity));

  @override
  _AgentEntity get _value => super._value as _AgentEntity;

  @override
  $Res call({
    Object account = freezed,
    Object hasValidToken = freezed,
    Object level = freezed,
  }) {
    return _then(_AgentEntity(
      account: account == freezed ? _value.account : account as String,
      hasValidToken: hasValidToken == freezed
          ? _value.hasValidToken
          : hasValidToken as bool,
      level: level == freezed ? _value.level : level as AgentLevel,
    ));
  }
}

/// @nodoc
class _$_AgentEntity implements _AgentEntity {
  const _$_AgentEntity(
      {this.account = '',
      this.hasValidToken = false,
      this.level = AgentLevel.UNKNOWN})
      : assert(account != null),
        assert(hasValidToken != null),
        assert(level != null);

  @JsonKey(defaultValue: '')
  @override
  final String account;
  @JsonKey(defaultValue: false)
  @override
  final bool hasValidToken;
  @JsonKey(defaultValue: AgentLevel.UNKNOWN)
  @override
  final AgentLevel level;

  @override
  String toString() {
    return 'AgentEntity(account: $account, hasValidToken: $hasValidToken, level: ${level.value})';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgentEntity &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.hasValidToken, hasValidToken) ||
                const DeepCollectionEquality()
                    .equals(other.hasValidToken, hasValidToken)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(hasValidToken) ^
      const DeepCollectionEquality().hash(level);

  @override
  _$AgentEntityCopyWith<_AgentEntity> get copyWith =>
      __$AgentEntityCopyWithImpl<_AgentEntity>(this, _$identity);
}

abstract class _AgentEntity implements AgentEntity {
  const factory _AgentEntity(
      {String account, bool hasValidToken, AgentLevel level}) = _$_AgentEntity;

  @override
  String get account;
  @override
  bool get hasValidToken;
  @override
  AgentLevel get level;
  @override
  _$AgentEntityCopyWith<_AgentEntity> get copyWith;
}

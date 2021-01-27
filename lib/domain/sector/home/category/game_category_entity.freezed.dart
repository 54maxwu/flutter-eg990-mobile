// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'game_category_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GameCategoryEntityTearOff {
  const _$GameCategoryEntityTearOff();

// ignore: unused_element
  _GameCategoryEntity call(
      {@required @HiveField(0) String type, GameCategory info}) {
    return _GameCategoryEntity(
      type: type,
      info: info,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GameCategoryEntity = _$GameCategoryEntityTearOff();

/// @nodoc
mixin _$GameCategoryEntity {
  @HiveField(0)
  String get type;
  GameCategory get info;

  @JsonKey(ignore: true)
  $GameCategoryEntityCopyWith<GameCategoryEntity> get copyWith;
}

/// @nodoc
abstract class $GameCategoryEntityCopyWith<$Res> {
  factory $GameCategoryEntityCopyWith(
          GameCategoryEntity value, $Res Function(GameCategoryEntity) then) =
      _$GameCategoryEntityCopyWithImpl<$Res>;
  $Res call({@HiveField(0) String type, GameCategory info});
}

/// @nodoc
class _$GameCategoryEntityCopyWithImpl<$Res>
    implements $GameCategoryEntityCopyWith<$Res> {
  _$GameCategoryEntityCopyWithImpl(this._value, this._then);

  final GameCategoryEntity _value;
  // ignore: unused_field
  final $Res Function(GameCategoryEntity) _then;

  @override
  $Res call({
    Object type = freezed,
    Object info = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as String,
      info: info == freezed ? _value.info : info as GameCategory,
    ));
  }
}

/// @nodoc
abstract class _$GameCategoryEntityCopyWith<$Res>
    implements $GameCategoryEntityCopyWith<$Res> {
  factory _$GameCategoryEntityCopyWith(
          _GameCategoryEntity value, $Res Function(_GameCategoryEntity) then) =
      __$GameCategoryEntityCopyWithImpl<$Res>;
  @override
  $Res call({@HiveField(0) String type, GameCategory info});
}

/// @nodoc
class __$GameCategoryEntityCopyWithImpl<$Res>
    extends _$GameCategoryEntityCopyWithImpl<$Res>
    implements _$GameCategoryEntityCopyWith<$Res> {
  __$GameCategoryEntityCopyWithImpl(
      _GameCategoryEntity _value, $Res Function(_GameCategoryEntity) _then)
      : super(_value, (v) => _then(v as _GameCategoryEntity));

  @override
  _GameCategoryEntity get _value => super._value as _GameCategoryEntity;

  @override
  $Res call({
    Object type = freezed,
    Object info = freezed,
  }) {
    return _then(_GameCategoryEntity(
      type: type == freezed ? _value.type : type as String,
      info: info == freezed ? _value.info : info as GameCategory,
    ));
  }
}

@HiveType(typeId: 111)

/// @nodoc
class _$_GameCategoryEntity extends _GameCategoryEntity {
  const _$_GameCategoryEntity({@required @HiveField(0) this.type, this.info})
      : assert(type != null),
        super._();

  @override
  @HiveField(0)
  final String type;
  @override
  final GameCategory info;

  @override
  String toString() {
    return 'GameCategoryEntity(type: $type, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GameCategoryEntity &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  _$GameCategoryEntityCopyWith<_GameCategoryEntity> get copyWith =>
      __$GameCategoryEntityCopyWithImpl<_GameCategoryEntity>(this, _$identity);
}

abstract class _GameCategoryEntity extends GameCategoryEntity {
  const _GameCategoryEntity._() : super._();
  const factory _GameCategoryEntity(
      {@required @HiveField(0) String type,
      GameCategory info}) = _$_GameCategoryEntity;

  @override
  @HiveField(0)
  String get type;
  @override
  GameCategory get info;
  @override
  @JsonKey(ignore: true)
  _$GameCategoryEntityCopyWith<_GameCategoryEntity> get copyWith;
}

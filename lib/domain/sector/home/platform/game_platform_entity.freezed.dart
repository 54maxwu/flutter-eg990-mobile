// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'game_platform_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GamePlatformEntityTearOff {
  const _$GamePlatformEntityTearOff();

// ignore: unused_element
  _GamePlatformEntity call(
      {@required
      @HiveField(0)
          int id,
      @HiveField(1)
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @HiveField(2)
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      @required
      @HiveField(3)
          String site,
      @HiveField(4)
      @JsonKey(name: 'type', required: true)
          String category,
      String favorite = '0'}) {
    return _GamePlatformEntity(
      id: id,
      className: className,
      ch: ch,
      site: site,
      category: category,
      favorite: favorite,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GamePlatformEntity = _$GamePlatformEntityTearOff();

/// @nodoc
mixin _$GamePlatformEntity {
  @HiveField(0)
  int get id;
  @HiveField(1)
  @JsonKey(name: 'class', fromJson: decodePlatformClassName)
  String get className;
  @HiveField(2)
  @JsonKey(fromJson: decodePlatformChName)
  String get ch;
  @HiveField(3)
  String get site;
  @HiveField(4)
  @JsonKey(name: 'type', required: true)
  String get category;
  String get favorite;

  @JsonKey(ignore: true)
  $GamePlatformEntityCopyWith<GamePlatformEntity> get copyWith;
}

/// @nodoc
abstract class $GamePlatformEntityCopyWith<$Res> {
  factory $GamePlatformEntityCopyWith(
          GamePlatformEntity value, $Res Function(GamePlatformEntity) then) =
      _$GamePlatformEntityCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0)
          int id,
      @HiveField(1)
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @HiveField(2)
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      @HiveField(3)
          String site,
      @HiveField(4)
      @JsonKey(name: 'type', required: true)
          String category,
      String favorite});
}

/// @nodoc
class _$GamePlatformEntityCopyWithImpl<$Res>
    implements $GamePlatformEntityCopyWith<$Res> {
  _$GamePlatformEntityCopyWithImpl(this._value, this._then);

  final GamePlatformEntity _value;
  // ignore: unused_field
  final $Res Function(GamePlatformEntity) _then;

  @override
  $Res call({
    Object id = freezed,
    Object className = freezed,
    Object ch = freezed,
    Object site = freezed,
    Object category = freezed,
    Object favorite = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      className: className == freezed ? _value.className : className as String,
      ch: ch == freezed ? _value.ch : ch as String,
      site: site == freezed ? _value.site : site as String,
      category: category == freezed ? _value.category : category as String,
      favorite: favorite == freezed ? _value.favorite : favorite as String,
    ));
  }
}

/// @nodoc
abstract class _$GamePlatformEntityCopyWith<$Res>
    implements $GamePlatformEntityCopyWith<$Res> {
  factory _$GamePlatformEntityCopyWith(
          _GamePlatformEntity value, $Res Function(_GamePlatformEntity) then) =
      __$GamePlatformEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0)
          int id,
      @HiveField(1)
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @HiveField(2)
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      @HiveField(3)
          String site,
      @HiveField(4)
      @JsonKey(name: 'type', required: true)
          String category,
      String favorite});
}

/// @nodoc
class __$GamePlatformEntityCopyWithImpl<$Res>
    extends _$GamePlatformEntityCopyWithImpl<$Res>
    implements _$GamePlatformEntityCopyWith<$Res> {
  __$GamePlatformEntityCopyWithImpl(
      _GamePlatformEntity _value, $Res Function(_GamePlatformEntity) _then)
      : super(_value, (v) => _then(v as _GamePlatformEntity));

  @override
  _GamePlatformEntity get _value => super._value as _GamePlatformEntity;

  @override
  $Res call({
    Object id = freezed,
    Object className = freezed,
    Object ch = freezed,
    Object site = freezed,
    Object category = freezed,
    Object favorite = freezed,
  }) {
    return _then(_GamePlatformEntity(
      id: id == freezed ? _value.id : id as int,
      className: className == freezed ? _value.className : className as String,
      ch: ch == freezed ? _value.ch : ch as String,
      site: site == freezed ? _value.site : site as String,
      category: category == freezed ? _value.category : category as String,
      favorite: favorite == freezed ? _value.favorite : favorite as String,
    ));
  }
}

@HiveType(typeId: 112)

/// @nodoc
class _$_GamePlatformEntity extends _GamePlatformEntity {
  const _$_GamePlatformEntity(
      {@required
      @HiveField(0)
          this.id,
      @HiveField(1)
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          this.className,
      @HiveField(2)
      @JsonKey(fromJson: decodePlatformChName)
          this.ch,
      @required
      @HiveField(3)
          this.site,
      @HiveField(4)
      @JsonKey(name: 'type', required: true)
          this.category,
      this.favorite = '0'})
      : assert(id != null),
        assert(site != null),
        assert(favorite != null),
        super._();

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  @JsonKey(name: 'class', fromJson: decodePlatformClassName)
  final String className;
  @override
  @HiveField(2)
  @JsonKey(fromJson: decodePlatformChName)
  final String ch;
  @override
  @HiveField(3)
  final String site;
  @override
  @HiveField(4)
  @JsonKey(name: 'type', required: true)
  final String category;
  @JsonKey(defaultValue: '0')
  @override
  final String favorite;

  @override
  String toString() {
    return 'GamePlatformEntity(id: $id, className: $className, ch: $ch, site: $site, category: $category, favorite: $favorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GamePlatformEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.className, className) ||
                const DeepCollectionEquality()
                    .equals(other.className, className)) &&
            (identical(other.ch, ch) ||
                const DeepCollectionEquality().equals(other.ch, ch)) &&
            (identical(other.site, site) ||
                const DeepCollectionEquality().equals(other.site, site)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.favorite, favorite) ||
                const DeepCollectionEquality()
                    .equals(other.favorite, favorite)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(className) ^
      const DeepCollectionEquality().hash(ch) ^
      const DeepCollectionEquality().hash(site) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(favorite);

  @JsonKey(ignore: true)
  @override
  _$GamePlatformEntityCopyWith<_GamePlatformEntity> get copyWith =>
      __$GamePlatformEntityCopyWithImpl<_GamePlatformEntity>(this, _$identity);
}

abstract class _GamePlatformEntity extends GamePlatformEntity {
  const _GamePlatformEntity._() : super._();
  const factory _GamePlatformEntity(
      {@required
      @HiveField(0)
          int id,
      @HiveField(1)
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @HiveField(2)
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      @required
      @HiveField(3)
          String site,
      @HiveField(4)
      @JsonKey(name: 'type', required: true)
          String category,
      String favorite}) = _$_GamePlatformEntity;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  @JsonKey(name: 'class', fromJson: decodePlatformClassName)
  String get className;
  @override
  @HiveField(2)
  @JsonKey(fromJson: decodePlatformChName)
  String get ch;
  @override
  @HiveField(3)
  String get site;
  @override
  @HiveField(4)
  @JsonKey(name: 'type', required: true)
  String get category;
  @override
  String get favorite;
  @override
  @JsonKey(ignore: true)
  _$GamePlatformEntityCopyWith<_GamePlatformEntity> get copyWith;
}

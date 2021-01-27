// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'game_platform_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GamePlatformModelTearOff {
  const _$GamePlatformModelTearOff();

// ignore: unused_element
  _GamePlatformModel call(
      {@required
          int id,
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      int cid,
      @required
          String site,
      String site2,
      @JsonKey(name: 'type', required: true)
          String category,
      int sort,
      String status,
      String favorite = '0'}) {
    return _GamePlatformModel(
      id: id,
      className: className,
      ch: ch,
      cid: cid,
      site: site,
      site2: site2,
      category: category,
      sort: sort,
      status: status,
      favorite: favorite,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GamePlatformModel = _$GamePlatformModelTearOff();

/// @nodoc
mixin _$GamePlatformModel {
  int get id;
  @JsonKey(name: 'class', fromJson: decodePlatformClassName)
  String get className;
  @JsonKey(fromJson: decodePlatformChName)
  String get ch;
  int get cid;
  String get site;
  String get site2;
  @JsonKey(name: 'type', required: true)
  String get category;
  int get sort;
  String get status;
  String get favorite;

  @JsonKey(ignore: true)
  $GamePlatformModelCopyWith<GamePlatformModel> get copyWith;
}

/// @nodoc
abstract class $GamePlatformModelCopyWith<$Res> {
  factory $GamePlatformModelCopyWith(
          GamePlatformModel value, $Res Function(GamePlatformModel) then) =
      _$GamePlatformModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      int cid,
      String site,
      String site2,
      @JsonKey(name: 'type', required: true)
          String category,
      int sort,
      String status,
      String favorite});
}

/// @nodoc
class _$GamePlatformModelCopyWithImpl<$Res>
    implements $GamePlatformModelCopyWith<$Res> {
  _$GamePlatformModelCopyWithImpl(this._value, this._then);

  final GamePlatformModel _value;
  // ignore: unused_field
  final $Res Function(GamePlatformModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object className = freezed,
    Object ch = freezed,
    Object cid = freezed,
    Object site = freezed,
    Object site2 = freezed,
    Object category = freezed,
    Object sort = freezed,
    Object status = freezed,
    Object favorite = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      className: className == freezed ? _value.className : className as String,
      ch: ch == freezed ? _value.ch : ch as String,
      cid: cid == freezed ? _value.cid : cid as int,
      site: site == freezed ? _value.site : site as String,
      site2: site2 == freezed ? _value.site2 : site2 as String,
      category: category == freezed ? _value.category : category as String,
      sort: sort == freezed ? _value.sort : sort as int,
      status: status == freezed ? _value.status : status as String,
      favorite: favorite == freezed ? _value.favorite : favorite as String,
    ));
  }
}

/// @nodoc
abstract class _$GamePlatformModelCopyWith<$Res>
    implements $GamePlatformModelCopyWith<$Res> {
  factory _$GamePlatformModelCopyWith(
          _GamePlatformModel value, $Res Function(_GamePlatformModel) then) =
      __$GamePlatformModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      int cid,
      String site,
      String site2,
      @JsonKey(name: 'type', required: true)
          String category,
      int sort,
      String status,
      String favorite});
}

/// @nodoc
class __$GamePlatformModelCopyWithImpl<$Res>
    extends _$GamePlatformModelCopyWithImpl<$Res>
    implements _$GamePlatformModelCopyWith<$Res> {
  __$GamePlatformModelCopyWithImpl(
      _GamePlatformModel _value, $Res Function(_GamePlatformModel) _then)
      : super(_value, (v) => _then(v as _GamePlatformModel));

  @override
  _GamePlatformModel get _value => super._value as _GamePlatformModel;

  @override
  $Res call({
    Object id = freezed,
    Object className = freezed,
    Object ch = freezed,
    Object cid = freezed,
    Object site = freezed,
    Object site2 = freezed,
    Object category = freezed,
    Object sort = freezed,
    Object status = freezed,
    Object favorite = freezed,
  }) {
    return _then(_GamePlatformModel(
      id: id == freezed ? _value.id : id as int,
      className: className == freezed ? _value.className : className as String,
      ch: ch == freezed ? _value.ch : ch as String,
      cid: cid == freezed ? _value.cid : cid as int,
      site: site == freezed ? _value.site : site as String,
      site2: site2 == freezed ? _value.site2 : site2 as String,
      category: category == freezed ? _value.category : category as String,
      sort: sort == freezed ? _value.sort : sort as int,
      status: status == freezed ? _value.status : status as String,
      favorite: favorite == freezed ? _value.favorite : favorite as String,
    ));
  }
}

/// @nodoc
class _$_GamePlatformModel extends _GamePlatformModel {
  const _$_GamePlatformModel(
      {@required this.id,
      @JsonKey(name: 'class', fromJson: decodePlatformClassName) this.className,
      @JsonKey(fromJson: decodePlatformChName) this.ch,
      this.cid,
      @required this.site,
      this.site2,
      @JsonKey(name: 'type', required: true) this.category,
      this.sort,
      this.status,
      this.favorite = '0'})
      : assert(id != null),
        assert(site != null),
        assert(favorite != null),
        super._();

  @override
  final int id;
  @override
  @JsonKey(name: 'class', fromJson: decodePlatformClassName)
  final String className;
  @override
  @JsonKey(fromJson: decodePlatformChName)
  final String ch;
  @override
  final int cid;
  @override
  final String site;
  @override
  final String site2;
  @override
  @JsonKey(name: 'type', required: true)
  final String category;
  @override
  final int sort;
  @override
  final String status;
  @JsonKey(defaultValue: '0')
  @override
  final String favorite;

  @override
  String toString() {
    return 'GamePlatformModel(id: $id, className: $className, ch: $ch, cid: $cid, site: $site, site2: $site2, category: $category, sort: $sort, status: $status, favorite: $favorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GamePlatformModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.className, className) ||
                const DeepCollectionEquality()
                    .equals(other.className, className)) &&
            (identical(other.ch, ch) ||
                const DeepCollectionEquality().equals(other.ch, ch)) &&
            (identical(other.cid, cid) ||
                const DeepCollectionEquality().equals(other.cid, cid)) &&
            (identical(other.site, site) ||
                const DeepCollectionEquality().equals(other.site, site)) &&
            (identical(other.site2, site2) ||
                const DeepCollectionEquality().equals(other.site2, site2)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
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
      const DeepCollectionEquality().hash(cid) ^
      const DeepCollectionEquality().hash(site) ^
      const DeepCollectionEquality().hash(site2) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(favorite);

  @JsonKey(ignore: true)
  @override
  _$GamePlatformModelCopyWith<_GamePlatformModel> get copyWith =>
      __$GamePlatformModelCopyWithImpl<_GamePlatformModel>(this, _$identity);
}

abstract class _GamePlatformModel extends GamePlatformModel {
  const _GamePlatformModel._() : super._();
  const factory _GamePlatformModel(
      {@required
          int id,
      @JsonKey(name: 'class', fromJson: decodePlatformClassName)
          String className,
      @JsonKey(fromJson: decodePlatformChName)
          String ch,
      int cid,
      @required
          String site,
      String site2,
      @JsonKey(name: 'type', required: true)
          String category,
      int sort,
      String status,
      String favorite}) = _$_GamePlatformModel;

  @override
  int get id;
  @override
  @JsonKey(name: 'class', fromJson: decodePlatformClassName)
  String get className;
  @override
  @JsonKey(fromJson: decodePlatformChName)
  String get ch;
  @override
  int get cid;
  @override
  String get site;
  @override
  String get site2;
  @override
  @JsonKey(name: 'type', required: true)
  String get category;
  @override
  int get sort;
  @override
  String get status;
  @override
  String get favorite;
  @override
  @JsonKey(ignore: true)
  _$GamePlatformModelCopyWith<_GamePlatformModel> get copyWith;
}

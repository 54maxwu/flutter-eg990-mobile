// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'member_grid_item_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MemberGridItemDataTearOff {
  const _$MemberGridItemDataTearOff();

// ignore: unused_element
  _MemberGridItemData call(
      {@required RouteEnum id,
      @required IconData iconData,
      String imageUrl,
      String assetPath,
      Gradient Function() createLinearGradient,
      RoutePage route}) {
    return _MemberGridItemData(
      id: id,
      iconData: iconData,
      imageUrl: imageUrl,
      assetPath: assetPath,
      createLinearGradient: createLinearGradient,
      route: route,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MemberGridItemData = _$MemberGridItemDataTearOff();

/// @nodoc
mixin _$MemberGridItemData {
  RouteEnum get id;
  IconData get iconData;
  String get imageUrl;
  String get assetPath;
  Gradient Function() get createLinearGradient;
  RoutePage get route;

  @JsonKey(ignore: true)
  $MemberGridItemDataCopyWith<MemberGridItemData> get copyWith;
}

/// @nodoc
abstract class $MemberGridItemDataCopyWith<$Res> {
  factory $MemberGridItemDataCopyWith(
          MemberGridItemData value, $Res Function(MemberGridItemData) then) =
      _$MemberGridItemDataCopyWithImpl<$Res>;
  $Res call(
      {RouteEnum id,
      IconData iconData,
      String imageUrl,
      String assetPath,
      Gradient Function() createLinearGradient,
      RoutePage route});
}

/// @nodoc
class _$MemberGridItemDataCopyWithImpl<$Res>
    implements $MemberGridItemDataCopyWith<$Res> {
  _$MemberGridItemDataCopyWithImpl(this._value, this._then);

  final MemberGridItemData _value;
  // ignore: unused_field
  final $Res Function(MemberGridItemData) _then;

  @override
  $Res call({
    Object id = freezed,
    Object iconData = freezed,
    Object imageUrl = freezed,
    Object assetPath = freezed,
    Object createLinearGradient = freezed,
    Object route = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as RouteEnum,
      iconData: iconData == freezed ? _value.iconData : iconData as IconData,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      assetPath: assetPath == freezed ? _value.assetPath : assetPath as String,
      createLinearGradient: createLinearGradient == freezed
          ? _value.createLinearGradient
          : createLinearGradient as Gradient Function(),
      route: route == freezed ? _value.route : route as RoutePage,
    ));
  }
}

/// @nodoc
abstract class _$MemberGridItemDataCopyWith<$Res>
    implements $MemberGridItemDataCopyWith<$Res> {
  factory _$MemberGridItemDataCopyWith(
          _MemberGridItemData value, $Res Function(_MemberGridItemData) then) =
      __$MemberGridItemDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {RouteEnum id,
      IconData iconData,
      String imageUrl,
      String assetPath,
      Gradient Function() createLinearGradient,
      RoutePage route});
}

/// @nodoc
class __$MemberGridItemDataCopyWithImpl<$Res>
    extends _$MemberGridItemDataCopyWithImpl<$Res>
    implements _$MemberGridItemDataCopyWith<$Res> {
  __$MemberGridItemDataCopyWithImpl(
      _MemberGridItemData _value, $Res Function(_MemberGridItemData) _then)
      : super(_value, (v) => _then(v as _MemberGridItemData));

  @override
  _MemberGridItemData get _value => super._value as _MemberGridItemData;

  @override
  $Res call({
    Object id = freezed,
    Object iconData = freezed,
    Object imageUrl = freezed,
    Object assetPath = freezed,
    Object createLinearGradient = freezed,
    Object route = freezed,
  }) {
    return _then(_MemberGridItemData(
      id: id == freezed ? _value.id : id as RouteEnum,
      iconData: iconData == freezed ? _value.iconData : iconData as IconData,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      assetPath: assetPath == freezed ? _value.assetPath : assetPath as String,
      createLinearGradient: createLinearGradient == freezed
          ? _value.createLinearGradient
          : createLinearGradient as Gradient Function(),
      route: route == freezed ? _value.route : route as RoutePage,
    ));
  }
}

/// @nodoc
class _$_MemberGridItemData implements _MemberGridItemData {
  const _$_MemberGridItemData(
      {@required this.id,
      @required this.iconData,
      this.imageUrl,
      this.assetPath,
      this.createLinearGradient,
      this.route})
      : assert(id != null),
        assert(iconData != null);

  @override
  final RouteEnum id;
  @override
  final IconData iconData;
  @override
  final String imageUrl;
  @override
  final String assetPath;
  @override
  final Gradient Function() createLinearGradient;
  @override
  final RoutePage route;

  @override
  String toString() {
    return 'MemberGridItemData(id: $id, iconData: $iconData, imageUrl: $imageUrl, assetPath: $assetPath, createLinearGradient: $createLinearGradient, route: $route)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MemberGridItemData &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.iconData, iconData) ||
                const DeepCollectionEquality()
                    .equals(other.iconData, iconData)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.assetPath, assetPath) ||
                const DeepCollectionEquality()
                    .equals(other.assetPath, assetPath)) &&
            (identical(other.createLinearGradient, createLinearGradient) ||
                const DeepCollectionEquality().equals(
                    other.createLinearGradient, createLinearGradient)) &&
            (identical(other.route, route) ||
                const DeepCollectionEquality().equals(other.route, route)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(iconData) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(assetPath) ^
      const DeepCollectionEquality().hash(createLinearGradient) ^
      const DeepCollectionEquality().hash(route);

  @JsonKey(ignore: true)
  @override
  _$MemberGridItemDataCopyWith<_MemberGridItemData> get copyWith =>
      __$MemberGridItemDataCopyWithImpl<_MemberGridItemData>(this, _$identity);
}

abstract class _MemberGridItemData implements MemberGridItemData {
  const factory _MemberGridItemData(
      {@required RouteEnum id,
      @required IconData iconData,
      String imageUrl,
      String assetPath,
      Gradient Function() createLinearGradient,
      RoutePage route}) = _$_MemberGridItemData;

  @override
  RouteEnum get id;
  @override
  IconData get iconData;
  @override
  String get imageUrl;
  @override
  String get assetPath;
  @override
  Gradient Function() get createLinearGradient;
  @override
  RoutePage get route;
  @override
  @JsonKey(ignore: true)
  _$MemberGridItemDataCopyWith<_MemberGridItemData> get copyWith;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'member_shortcut_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MemberShortcutDataTearOff {
  const _$MemberShortcutDataTearOff();

// ignore: unused_element
  _MemberShortcutData call(
      {@required RouteEnum id,
      RoutePage route,
      @required String assetPath,
      @required MemberShortcutType sType,
      String hintText,
      int section}) {
    return _MemberShortcutData(
      id: id,
      route: route,
      assetPath: assetPath,
      sType: sType,
      hintText: hintText,
      section: section,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MemberShortcutData = _$MemberShortcutDataTearOff();

/// @nodoc
mixin _$MemberShortcutData {
  RouteEnum get id;
  RoutePage get route;
  String get assetPath;
  MemberShortcutType get sType;
  String get hintText;
  int get section;

  @JsonKey(ignore: true)
  $MemberShortcutDataCopyWith<MemberShortcutData> get copyWith;
}

/// @nodoc
abstract class $MemberShortcutDataCopyWith<$Res> {
  factory $MemberShortcutDataCopyWith(
          MemberShortcutData value, $Res Function(MemberShortcutData) then) =
      _$MemberShortcutDataCopyWithImpl<$Res>;
  $Res call(
      {RouteEnum id,
      RoutePage route,
      String assetPath,
      MemberShortcutType sType,
      String hintText,
      int section});
}

/// @nodoc
class _$MemberShortcutDataCopyWithImpl<$Res>
    implements $MemberShortcutDataCopyWith<$Res> {
  _$MemberShortcutDataCopyWithImpl(this._value, this._then);

  final MemberShortcutData _value;
  // ignore: unused_field
  final $Res Function(MemberShortcutData) _then;

  @override
  $Res call({
    Object id = freezed,
    Object route = freezed,
    Object assetPath = freezed,
    Object sType = freezed,
    Object hintText = freezed,
    Object section = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as RouteEnum,
      route: route == freezed ? _value.route : route as RoutePage,
      assetPath: assetPath == freezed ? _value.assetPath : assetPath as String,
      sType: sType == freezed ? _value.sType : sType as MemberShortcutType,
      hintText: hintText == freezed ? _value.hintText : hintText as String,
      section: section == freezed ? _value.section : section as int,
    ));
  }
}

/// @nodoc
abstract class _$MemberShortcutDataCopyWith<$Res>
    implements $MemberShortcutDataCopyWith<$Res> {
  factory _$MemberShortcutDataCopyWith(
          _MemberShortcutData value, $Res Function(_MemberShortcutData) then) =
      __$MemberShortcutDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {RouteEnum id,
      RoutePage route,
      String assetPath,
      MemberShortcutType sType,
      String hintText,
      int section});
}

/// @nodoc
class __$MemberShortcutDataCopyWithImpl<$Res>
    extends _$MemberShortcutDataCopyWithImpl<$Res>
    implements _$MemberShortcutDataCopyWith<$Res> {
  __$MemberShortcutDataCopyWithImpl(
      _MemberShortcutData _value, $Res Function(_MemberShortcutData) _then)
      : super(_value, (v) => _then(v as _MemberShortcutData));

  @override
  _MemberShortcutData get _value => super._value as _MemberShortcutData;

  @override
  $Res call({
    Object id = freezed,
    Object route = freezed,
    Object assetPath = freezed,
    Object sType = freezed,
    Object hintText = freezed,
    Object section = freezed,
  }) {
    return _then(_MemberShortcutData(
      id: id == freezed ? _value.id : id as RouteEnum,
      route: route == freezed ? _value.route : route as RoutePage,
      assetPath: assetPath == freezed ? _value.assetPath : assetPath as String,
      sType: sType == freezed ? _value.sType : sType as MemberShortcutType,
      hintText: hintText == freezed ? _value.hintText : hintText as String,
      section: section == freezed ? _value.section : section as int,
    ));
  }
}

/// @nodoc
class _$_MemberShortcutData implements _MemberShortcutData {
  const _$_MemberShortcutData(
      {@required this.id,
      this.route,
      @required this.assetPath,
      @required this.sType,
      this.hintText,
      this.section})
      : assert(id != null),
        assert(assetPath != null),
        assert(sType != null);

  @override
  final RouteEnum id;
  @override
  final RoutePage route;
  @override
  final String assetPath;
  @override
  final MemberShortcutType sType;
  @override
  final String hintText;
  @override
  final int section;

  @override
  String toString() {
    return 'MemberShortcutData(id: $id, route: $route, assetPath: $assetPath, sType: $sType, hintText: $hintText, section: $section)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MemberShortcutData &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.route, route) ||
                const DeepCollectionEquality().equals(other.route, route)) &&
            (identical(other.assetPath, assetPath) ||
                const DeepCollectionEquality()
                    .equals(other.assetPath, assetPath)) &&
            (identical(other.sType, sType) ||
                const DeepCollectionEquality().equals(other.sType, sType)) &&
            (identical(other.hintText, hintText) ||
                const DeepCollectionEquality()
                    .equals(other.hintText, hintText)) &&
            (identical(other.section, section) ||
                const DeepCollectionEquality().equals(other.section, section)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(route) ^
      const DeepCollectionEquality().hash(assetPath) ^
      const DeepCollectionEquality().hash(sType) ^
      const DeepCollectionEquality().hash(hintText) ^
      const DeepCollectionEquality().hash(section);

  @JsonKey(ignore: true)
  @override
  _$MemberShortcutDataCopyWith<_MemberShortcutData> get copyWith =>
      __$MemberShortcutDataCopyWithImpl<_MemberShortcutData>(this, _$identity);
}

abstract class _MemberShortcutData implements MemberShortcutData {
  const factory _MemberShortcutData(
      {@required RouteEnum id,
      RoutePage route,
      @required String assetPath,
      @required MemberShortcutType sType,
      String hintText,
      int section}) = _$_MemberShortcutData;

  @override
  RouteEnum get id;
  @override
  RoutePage get route;
  @override
  String get assetPath;
  @override
  MemberShortcutType get sType;
  @override
  String get hintText;
  @override
  int get section;
  @override
  @JsonKey(ignore: true)
  _$MemberShortcutDataCopyWith<_MemberShortcutData> get copyWith;
}

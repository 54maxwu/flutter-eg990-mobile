// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'shortcut_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ShortcutDataTearOff {
  const _$ShortcutDataTearOff();

// ignore: unused_element
  _ShortcutData call(
      {@required RouteEnum id,
      @required IconData iconData,
      Color iconDecorColor,
      Color iconDecorColorStart,
      Color iconDecorColorEnd,
      RoutePage route,
      bool isUserOnly = true}) {
    return _ShortcutData(
      id: id,
      iconData: iconData,
      iconDecorColor: iconDecorColor,
      iconDecorColorStart: iconDecorColorStart,
      iconDecorColorEnd: iconDecorColorEnd,
      route: route,
      isUserOnly: isUserOnly,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ShortcutData = _$ShortcutDataTearOff();

/// @nodoc
mixin _$ShortcutData {
  RouteEnum get id;
  IconData get iconData;
  Color get iconDecorColor;
  Color get iconDecorColorStart;
  Color get iconDecorColorEnd;
  RoutePage get route;
  bool get isUserOnly;

  $ShortcutDataCopyWith<ShortcutData> get copyWith;
}

/// @nodoc
abstract class $ShortcutDataCopyWith<$Res> {
  factory $ShortcutDataCopyWith(
          ShortcutData value, $Res Function(ShortcutData) then) =
      _$ShortcutDataCopyWithImpl<$Res>;
  $Res call(
      {RouteEnum id,
      IconData iconData,
      Color iconDecorColor,
      Color iconDecorColorStart,
      Color iconDecorColorEnd,
      RoutePage route,
      bool isUserOnly});
}

/// @nodoc
class _$ShortcutDataCopyWithImpl<$Res> implements $ShortcutDataCopyWith<$Res> {
  _$ShortcutDataCopyWithImpl(this._value, this._then);

  final ShortcutData _value;
  // ignore: unused_field
  final $Res Function(ShortcutData) _then;

  @override
  $Res call({
    Object id = freezed,
    Object iconData = freezed,
    Object iconDecorColor = freezed,
    Object iconDecorColorStart = freezed,
    Object iconDecorColorEnd = freezed,
    Object route = freezed,
    Object isUserOnly = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as RouteEnum,
      iconData: iconData == freezed ? _value.iconData : iconData as IconData,
      iconDecorColor: iconDecorColor == freezed
          ? _value.iconDecorColor
          : iconDecorColor as Color,
      iconDecorColorStart: iconDecorColorStart == freezed
          ? _value.iconDecorColorStart
          : iconDecorColorStart as Color,
      iconDecorColorEnd: iconDecorColorEnd == freezed
          ? _value.iconDecorColorEnd
          : iconDecorColorEnd as Color,
      route: route == freezed ? _value.route : route as RoutePage,
      isUserOnly:
          isUserOnly == freezed ? _value.isUserOnly : isUserOnly as bool,
    ));
  }
}

/// @nodoc
abstract class _$ShortcutDataCopyWith<$Res>
    implements $ShortcutDataCopyWith<$Res> {
  factory _$ShortcutDataCopyWith(
          _ShortcutData value, $Res Function(_ShortcutData) then) =
      __$ShortcutDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {RouteEnum id,
      IconData iconData,
      Color iconDecorColor,
      Color iconDecorColorStart,
      Color iconDecorColorEnd,
      RoutePage route,
      bool isUserOnly});
}

/// @nodoc
class __$ShortcutDataCopyWithImpl<$Res> extends _$ShortcutDataCopyWithImpl<$Res>
    implements _$ShortcutDataCopyWith<$Res> {
  __$ShortcutDataCopyWithImpl(
      _ShortcutData _value, $Res Function(_ShortcutData) _then)
      : super(_value, (v) => _then(v as _ShortcutData));

  @override
  _ShortcutData get _value => super._value as _ShortcutData;

  @override
  $Res call({
    Object id = freezed,
    Object iconData = freezed,
    Object iconDecorColor = freezed,
    Object iconDecorColorStart = freezed,
    Object iconDecorColorEnd = freezed,
    Object route = freezed,
    Object isUserOnly = freezed,
  }) {
    return _then(_ShortcutData(
      id: id == freezed ? _value.id : id as RouteEnum,
      iconData: iconData == freezed ? _value.iconData : iconData as IconData,
      iconDecorColor: iconDecorColor == freezed
          ? _value.iconDecorColor
          : iconDecorColor as Color,
      iconDecorColorStart: iconDecorColorStart == freezed
          ? _value.iconDecorColorStart
          : iconDecorColorStart as Color,
      iconDecorColorEnd: iconDecorColorEnd == freezed
          ? _value.iconDecorColorEnd
          : iconDecorColorEnd as Color,
      route: route == freezed ? _value.route : route as RoutePage,
      isUserOnly:
          isUserOnly == freezed ? _value.isUserOnly : isUserOnly as bool,
    ));
  }
}

/// @nodoc
class _$_ShortcutData with DiagnosticableTreeMixin implements _ShortcutData {
  const _$_ShortcutData(
      {@required this.id,
      @required this.iconData,
      this.iconDecorColor,
      this.iconDecorColorStart,
      this.iconDecorColorEnd,
      this.route,
      this.isUserOnly = true})
      : assert(id != null),
        assert(iconData != null),
        assert(isUserOnly != null);

  @override
  final RouteEnum id;
  @override
  final IconData iconData;
  @override
  final Color iconDecorColor;
  @override
  final Color iconDecorColorStart;
  @override
  final Color iconDecorColorEnd;
  @override
  final RoutePage route;
  @JsonKey(defaultValue: true)
  @override
  final bool isUserOnly;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShortcutData(id: $id, iconData: $iconData, iconDecorColor: $iconDecorColor, iconDecorColorStart: $iconDecorColorStart, iconDecorColorEnd: $iconDecorColorEnd, route: $route, isUserOnly: $isUserOnly)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShortcutData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('iconData', iconData))
      ..add(DiagnosticsProperty('iconDecorColor', iconDecorColor))
      ..add(DiagnosticsProperty('iconDecorColorStart', iconDecorColorStart))
      ..add(DiagnosticsProperty('iconDecorColorEnd', iconDecorColorEnd))
      ..add(DiagnosticsProperty('route', route))
      ..add(DiagnosticsProperty('isUserOnly', isUserOnly));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ShortcutData &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.iconData, iconData) ||
                const DeepCollectionEquality()
                    .equals(other.iconData, iconData)) &&
            (identical(other.iconDecorColor, iconDecorColor) ||
                const DeepCollectionEquality()
                    .equals(other.iconDecorColor, iconDecorColor)) &&
            (identical(other.iconDecorColorStart, iconDecorColorStart) ||
                const DeepCollectionEquality()
                    .equals(other.iconDecorColorStart, iconDecorColorStart)) &&
            (identical(other.iconDecorColorEnd, iconDecorColorEnd) ||
                const DeepCollectionEquality()
                    .equals(other.iconDecorColorEnd, iconDecorColorEnd)) &&
            (identical(other.route, route) ||
                const DeepCollectionEquality().equals(other.route, route)) &&
            (identical(other.isUserOnly, isUserOnly) ||
                const DeepCollectionEquality()
                    .equals(other.isUserOnly, isUserOnly)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(iconData) ^
      const DeepCollectionEquality().hash(iconDecorColor) ^
      const DeepCollectionEquality().hash(iconDecorColorStart) ^
      const DeepCollectionEquality().hash(iconDecorColorEnd) ^
      const DeepCollectionEquality().hash(route) ^
      const DeepCollectionEquality().hash(isUserOnly);

  @override
  _$ShortcutDataCopyWith<_ShortcutData> get copyWith =>
      __$ShortcutDataCopyWithImpl<_ShortcutData>(this, _$identity);
}

abstract class _ShortcutData implements ShortcutData {
  const factory _ShortcutData(
      {@required RouteEnum id,
      @required IconData iconData,
      Color iconDecorColor,
      Color iconDecorColorStart,
      Color iconDecorColorEnd,
      RoutePage route,
      bool isUserOnly}) = _$_ShortcutData;

  @override
  RouteEnum get id;
  @override
  IconData get iconData;
  @override
  Color get iconDecorColor;
  @override
  Color get iconDecorColorStart;
  @override
  Color get iconDecorColorEnd;
  @override
  RoutePage get route;
  @override
  bool get isUserOnly;
  @override
  _$ShortcutDataCopyWith<_ShortcutData> get copyWith;
}

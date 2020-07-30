// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'route_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$RouteListItemTearOff {
  const _$RouteListItemTearOff();

// ignore: unused_element
  _RouteListItem call(
      {String replaceTitle,
      IconData iconData,
      String imageName,
      RoutePage route,
      String webUrl,
      bool isUserOnly = false}) {
    return _RouteListItem(
      replaceTitle: replaceTitle,
      iconData: iconData,
      imageName: imageName,
      route: route,
      webUrl: webUrl,
      isUserOnly: isUserOnly,
    );
  }
}

// ignore: unused_element
const $RouteListItem = _$RouteListItemTearOff();

mixin _$RouteListItem {
  String get replaceTitle;
  IconData get iconData;
  String get imageName;
  RoutePage get route;
  String get webUrl;
  bool get isUserOnly;

  $RouteListItemCopyWith<RouteListItem> get copyWith;
}

abstract class $RouteListItemCopyWith<$Res> {
  factory $RouteListItemCopyWith(
          RouteListItem value, $Res Function(RouteListItem) then) =
      _$RouteListItemCopyWithImpl<$Res>;
  $Res call(
      {String replaceTitle,
      IconData iconData,
      String imageName,
      RoutePage route,
      String webUrl,
      bool isUserOnly});
}

class _$RouteListItemCopyWithImpl<$Res>
    implements $RouteListItemCopyWith<$Res> {
  _$RouteListItemCopyWithImpl(this._value, this._then);

  final RouteListItem _value;
  // ignore: unused_field
  final $Res Function(RouteListItem) _then;

  @override
  $Res call({
    Object replaceTitle = freezed,
    Object iconData = freezed,
    Object imageName = freezed,
    Object route = freezed,
    Object webUrl = freezed,
    Object isUserOnly = freezed,
  }) {
    return _then(_value.copyWith(
      replaceTitle: replaceTitle == freezed
          ? _value.replaceTitle
          : replaceTitle as String,
      iconData: iconData == freezed ? _value.iconData : iconData as IconData,
      imageName: imageName == freezed ? _value.imageName : imageName as String,
      route: route == freezed ? _value.route : route as RoutePage,
      webUrl: webUrl == freezed ? _value.webUrl : webUrl as String,
      isUserOnly:
          isUserOnly == freezed ? _value.isUserOnly : isUserOnly as bool,
    ));
  }
}

abstract class _$RouteListItemCopyWith<$Res>
    implements $RouteListItemCopyWith<$Res> {
  factory _$RouteListItemCopyWith(
          _RouteListItem value, $Res Function(_RouteListItem) then) =
      __$RouteListItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String replaceTitle,
      IconData iconData,
      String imageName,
      RoutePage route,
      String webUrl,
      bool isUserOnly});
}

class __$RouteListItemCopyWithImpl<$Res>
    extends _$RouteListItemCopyWithImpl<$Res>
    implements _$RouteListItemCopyWith<$Res> {
  __$RouteListItemCopyWithImpl(
      _RouteListItem _value, $Res Function(_RouteListItem) _then)
      : super(_value, (v) => _then(v as _RouteListItem));

  @override
  _RouteListItem get _value => super._value as _RouteListItem;

  @override
  $Res call({
    Object replaceTitle = freezed,
    Object iconData = freezed,
    Object imageName = freezed,
    Object route = freezed,
    Object webUrl = freezed,
    Object isUserOnly = freezed,
  }) {
    return _then(_RouteListItem(
      replaceTitle: replaceTitle == freezed
          ? _value.replaceTitle
          : replaceTitle as String,
      iconData: iconData == freezed ? _value.iconData : iconData as IconData,
      imageName: imageName == freezed ? _value.imageName : imageName as String,
      route: route == freezed ? _value.route : route as RoutePage,
      webUrl: webUrl == freezed ? _value.webUrl : webUrl as String,
      isUserOnly:
          isUserOnly == freezed ? _value.isUserOnly : isUserOnly as bool,
    ));
  }
}

class _$_RouteListItem with DiagnosticableTreeMixin implements _RouteListItem {
  const _$_RouteListItem(
      {this.replaceTitle,
      this.iconData,
      this.imageName,
      this.route,
      this.webUrl,
      this.isUserOnly = false})
      : assert(isUserOnly != null);

  @override
  final String replaceTitle;
  @override
  final IconData iconData;
  @override
  final String imageName;
  @override
  final RoutePage route;
  @override
  final String webUrl;
  @JsonKey(defaultValue: false)
  @override
  final bool isUserOnly;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteListItem(replaceTitle: $replaceTitle, iconData: $iconData, imageName: $imageName, route: $route, webUrl: $webUrl, isUserOnly: $isUserOnly)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteListItem'))
      ..add(DiagnosticsProperty('replaceTitle', replaceTitle))
      ..add(DiagnosticsProperty('iconData', iconData))
      ..add(DiagnosticsProperty('imageName', imageName))
      ..add(DiagnosticsProperty('route', route))
      ..add(DiagnosticsProperty('webUrl', webUrl))
      ..add(DiagnosticsProperty('isUserOnly', isUserOnly));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RouteListItem &&
            (identical(other.replaceTitle, replaceTitle) ||
                const DeepCollectionEquality()
                    .equals(other.replaceTitle, replaceTitle)) &&
            (identical(other.iconData, iconData) ||
                const DeepCollectionEquality()
                    .equals(other.iconData, iconData)) &&
            (identical(other.imageName, imageName) ||
                const DeepCollectionEquality()
                    .equals(other.imageName, imageName)) &&
            (identical(other.route, route) ||
                const DeepCollectionEquality().equals(other.route, route)) &&
            (identical(other.webUrl, webUrl) ||
                const DeepCollectionEquality().equals(other.webUrl, webUrl)) &&
            (identical(other.isUserOnly, isUserOnly) ||
                const DeepCollectionEquality()
                    .equals(other.isUserOnly, isUserOnly)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(replaceTitle) ^
      const DeepCollectionEquality().hash(iconData) ^
      const DeepCollectionEquality().hash(imageName) ^
      const DeepCollectionEquality().hash(route) ^
      const DeepCollectionEquality().hash(webUrl) ^
      const DeepCollectionEquality().hash(isUserOnly);

  @override
  _$RouteListItemCopyWith<_RouteListItem> get copyWith =>
      __$RouteListItemCopyWithImpl<_RouteListItem>(this, _$identity);
}

abstract class _RouteListItem implements RouteListItem {
  const factory _RouteListItem(
      {String replaceTitle,
      IconData iconData,
      String imageName,
      RoutePage route,
      String webUrl,
      bool isUserOnly}) = _$_RouteListItem;

  @override
  String get replaceTitle;
  @override
  IconData get iconData;
  @override
  String get imageName;
  @override
  RoutePage get route;
  @override
  String get webUrl;
  @override
  bool get isUserOnly;
  @override
  _$RouteListItemCopyWith<_RouteListItem> get copyWith;
}

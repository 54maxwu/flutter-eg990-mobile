// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'route_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RouteInfoTearOff {
  const _$RouteInfoTearOff();

// ignore: unused_element
  _RouteInfo call(
      {@required RouteEnum id,
      @required String route,
      Object routeArg,
      String root = MainScreenRoutes.homeRoute,
      MainScreenAppBarTypes appBarType = MainScreenAppBarTypes.BACK_AND_TITLE,
      MainScreenNavBarTypes navBarType = MainScreenNavBarTypes.HIDE,
      int bottomNavIndex = -1,
      String webPageName,
      String title = ''}) {
    return _RouteInfo(
      id: id,
      route: route,
      routeArg: routeArg,
      root: root,
      appBarType: appBarType,
      navBarType: navBarType,
      bottomNavIndex: bottomNavIndex,
      webPageName: webPageName,
      title: title,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RouteInfo = _$RouteInfoTearOff();

/// @nodoc
mixin _$RouteInfo {
  RouteEnum get id;
  String get route;
  Object get routeArg;
  String get root;

  /// if true, shows the widget on the right side (logout, register...etc)
  MainScreenAppBarTypes get appBarType;

  /// if true, shows the widget on the right side (logout, register...etc)
  MainScreenNavBarTypes get navBarType;

  /// 1. sets the bottom navigator index to highlight icon
  /// 2. effect the navigation action
  /// 3. if value > -1, shows the side menu action bar
  int get bottomNavIndex;

  /// for promo and banner to find nav destination
  String get webPageName;

  /// override page title
  String get title;

  $RouteInfoCopyWith<RouteInfo> get copyWith;
}

/// @nodoc
abstract class $RouteInfoCopyWith<$Res> {
  factory $RouteInfoCopyWith(RouteInfo value, $Res Function(RouteInfo) then) =
      _$RouteInfoCopyWithImpl<$Res>;
  $Res call(
      {RouteEnum id,
      String route,
      Object routeArg,
      String root,
      MainScreenAppBarTypes appBarType,
      MainScreenNavBarTypes navBarType,
      int bottomNavIndex,
      String webPageName,
      String title});
}

/// @nodoc
class _$RouteInfoCopyWithImpl<$Res> implements $RouteInfoCopyWith<$Res> {
  _$RouteInfoCopyWithImpl(this._value, this._then);

  final RouteInfo _value;
  // ignore: unused_field
  final $Res Function(RouteInfo) _then;

  @override
  $Res call({
    Object id = freezed,
    Object route = freezed,
    Object routeArg = freezed,
    Object root = freezed,
    Object appBarType = freezed,
    Object navBarType = freezed,
    Object bottomNavIndex = freezed,
    Object webPageName = freezed,
    Object title = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as RouteEnum,
      route: route == freezed ? _value.route : route as String,
      routeArg: routeArg == freezed ? _value.routeArg : routeArg,
      root: root == freezed ? _value.root : root as String,
      appBarType: appBarType == freezed
          ? _value.appBarType
          : appBarType as MainScreenAppBarTypes,
      navBarType: navBarType == freezed
          ? _value.navBarType
          : navBarType as MainScreenNavBarTypes,
      bottomNavIndex: bottomNavIndex == freezed
          ? _value.bottomNavIndex
          : bottomNavIndex as int,
      webPageName:
          webPageName == freezed ? _value.webPageName : webPageName as String,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

/// @nodoc
abstract class _$RouteInfoCopyWith<$Res> implements $RouteInfoCopyWith<$Res> {
  factory _$RouteInfoCopyWith(
          _RouteInfo value, $Res Function(_RouteInfo) then) =
      __$RouteInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {RouteEnum id,
      String route,
      Object routeArg,
      String root,
      MainScreenAppBarTypes appBarType,
      MainScreenNavBarTypes navBarType,
      int bottomNavIndex,
      String webPageName,
      String title});
}

/// @nodoc
class __$RouteInfoCopyWithImpl<$Res> extends _$RouteInfoCopyWithImpl<$Res>
    implements _$RouteInfoCopyWith<$Res> {
  __$RouteInfoCopyWithImpl(_RouteInfo _value, $Res Function(_RouteInfo) _then)
      : super(_value, (v) => _then(v as _RouteInfo));

  @override
  _RouteInfo get _value => super._value as _RouteInfo;

  @override
  $Res call({
    Object id = freezed,
    Object route = freezed,
    Object routeArg = freezed,
    Object root = freezed,
    Object appBarType = freezed,
    Object navBarType = freezed,
    Object bottomNavIndex = freezed,
    Object webPageName = freezed,
    Object title = freezed,
  }) {
    return _then(_RouteInfo(
      id: id == freezed ? _value.id : id as RouteEnum,
      route: route == freezed ? _value.route : route as String,
      routeArg: routeArg == freezed ? _value.routeArg : routeArg,
      root: root == freezed ? _value.root : root as String,
      appBarType: appBarType == freezed
          ? _value.appBarType
          : appBarType as MainScreenAppBarTypes,
      navBarType: navBarType == freezed
          ? _value.navBarType
          : navBarType as MainScreenNavBarTypes,
      bottomNavIndex: bottomNavIndex == freezed
          ? _value.bottomNavIndex
          : bottomNavIndex as int,
      webPageName:
          webPageName == freezed ? _value.webPageName : webPageName as String,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

/// @nodoc
class _$_RouteInfo implements _RouteInfo {
  const _$_RouteInfo(
      {@required this.id,
      @required this.route,
      this.routeArg,
      this.root = MainScreenRoutes.homeRoute,
      this.appBarType = MainScreenAppBarTypes.BACK_AND_TITLE,
      this.navBarType = MainScreenNavBarTypes.HIDE,
      this.bottomNavIndex = -1,
      this.webPageName,
      this.title = ''})
      : assert(id != null),
        assert(route != null),
        assert(root != null),
        assert(appBarType != null),
        assert(navBarType != null),
        assert(bottomNavIndex != null),
        assert(title != null);

  @override
  final RouteEnum id;
  @override
  final String route;
  @override
  final Object routeArg;
  @JsonKey(defaultValue: MainScreenRoutes.homeRoute)
  @override
  final String root;
  @JsonKey(defaultValue: MainScreenAppBarTypes.BACK_AND_TITLE)
  @override

  /// if true, shows the widget on the right side (logout, register...etc)
  final MainScreenAppBarTypes appBarType;
  @JsonKey(defaultValue: MainScreenNavBarTypes.HIDE)
  @override

  /// if true, shows the widget on the right side (logout, register...etc)
  final MainScreenNavBarTypes navBarType;
  @JsonKey(defaultValue: -1)
  @override

  /// 1. sets the bottom navigator index to highlight icon
  /// 2. effect the navigation action
  /// 3. if value > -1, shows the side menu action bar
  final int bottomNavIndex;
  @override

  /// for promo and banner to find nav destination
  final String webPageName;
  @JsonKey(defaultValue: '')
  @override

  /// override page title
  final String title;

  @override
  String toString() {
    return 'RouteInfo(id: $id, route: $route, routeArg: $routeArg, root: $root, appBarType: $appBarType, navBarType: $navBarType, bottomNavIndex: $bottomNavIndex, webPageName: $webPageName, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RouteInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.route, route) ||
                const DeepCollectionEquality().equals(other.route, route)) &&
            (identical(other.routeArg, routeArg) ||
                const DeepCollectionEquality()
                    .equals(other.routeArg, routeArg)) &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)) &&
            (identical(other.appBarType, appBarType) ||
                const DeepCollectionEquality()
                    .equals(other.appBarType, appBarType)) &&
            (identical(other.navBarType, navBarType) ||
                const DeepCollectionEquality()
                    .equals(other.navBarType, navBarType)) &&
            (identical(other.bottomNavIndex, bottomNavIndex) ||
                const DeepCollectionEquality()
                    .equals(other.bottomNavIndex, bottomNavIndex)) &&
            (identical(other.webPageName, webPageName) ||
                const DeepCollectionEquality()
                    .equals(other.webPageName, webPageName)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(route) ^
      const DeepCollectionEquality().hash(routeArg) ^
      const DeepCollectionEquality().hash(root) ^
      const DeepCollectionEquality().hash(appBarType) ^
      const DeepCollectionEquality().hash(navBarType) ^
      const DeepCollectionEquality().hash(bottomNavIndex) ^
      const DeepCollectionEquality().hash(webPageName) ^
      const DeepCollectionEquality().hash(title);

  @override
  _$RouteInfoCopyWith<_RouteInfo> get copyWith =>
      __$RouteInfoCopyWithImpl<_RouteInfo>(this, _$identity);
}

abstract class _RouteInfo implements RouteInfo {
  const factory _RouteInfo(
      {@required RouteEnum id,
      @required String route,
      Object routeArg,
      String root,
      MainScreenAppBarTypes appBarType,
      MainScreenNavBarTypes navBarType,
      int bottomNavIndex,
      String webPageName,
      String title}) = _$_RouteInfo;

  @override
  RouteEnum get id;
  @override
  String get route;
  @override
  Object get routeArg;
  @override
  String get root;
  @override

  /// if true, shows the widget on the right side (logout, register...etc)
  MainScreenAppBarTypes get appBarType;
  @override

  /// if true, shows the widget on the right side (logout, register...etc)
  MainScreenNavBarTypes get navBarType;
  @override

  /// 1. sets the bottom navigator index to highlight icon
  /// 2. effect the navigation action
  /// 3. if value > -1, shows the side menu action bar
  int get bottomNavIndex;
  @override

  /// for promo and banner to find nav destination
  String get webPageName;
  @override

  /// override page title
  String get title;
  @override
  _$RouteInfoCopyWith<_RouteInfo> get copyWith;
}

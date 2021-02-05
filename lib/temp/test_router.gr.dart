// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import 'test_home_size_calc.dart';
import 'test_input_route.dart';
import 'test_nested_nav_screen_view.dart';
import 'test_permission_screen.dart';

class TestRouterRoutes {
  static const String testNestedNavScreenView = '/';
  static const String testPermissionScreen = '/test-permission-screen';
  static const String testInputRoute = '/test-input-route';
  static const String testHomeSizeCalc = '/test-home-size-calc';
  static const all = <String>{
    testNestedNavScreenView,
    testPermissionScreen,
    testInputRoute,
    testHomeSizeCalc,
  };
}

class TestRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(TestRouterRoutes.testNestedNavScreenView,
        page: TestNestedNavScreenView),
    RouteDef(TestRouterRoutes.testPermissionScreen, page: TestPermissionScreen),
    RouteDef(TestRouterRoutes.testInputRoute, page: TestInputRoute),
    RouteDef(TestRouterRoutes.testHomeSizeCalc, page: TestHomeSizeCalc),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    TestNestedNavScreenView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TestNestedNavScreenView(),
        settings: data,
      );
    },
    TestPermissionScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TestPermissionScreen(),
        settings: data,
      );
    },
    TestInputRoute: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TestInputRoute(),
        settings: data,
      );
    },
    TestHomeSizeCalc: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TestHomeSizeCalc(),
        settings: data,
      );
    },
  };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_eg990_mobile/temp/test_nested_nav_screen_view.dart';
import 'package:flutter_eg990_mobile/temp/test_permission_screen.dart';
import 'package:flutter_eg990_mobile/temp/test_input_route.dart';

abstract class TestRoutes {
  static const testScreenInnerView = '/test-screen-inner-view';
  static const testPermissionScreen = '/test-permission-screen';
  static const testInputRoute = '/test-input-route';
  static const all = {
    testScreenInnerView,
    testPermissionScreen,
    testInputRoute,
  };
}

class TestRouter extends RouterBase {
  @override
  Set<String> get allRoutes => TestRoutes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<TestRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TestRoutes.testScreenInnerView:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => TestNestedNavScreenView(),
          settings: settings,
        );
      case TestRoutes.testPermissionScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => TestPermissionScreen(),
          settings: settings,
        );
      case TestRoutes.testInputRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => TestInputRoute(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

ExtendedNavigatorState get testNavigator =>
    ExtendedNavigator.ofRouter<TestRouter>();

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/main_startup.dart';
import '../features/home/presentation/home_route.dart';
import '../features/member/member_route.dart';
import '../screens/main_screen.dart';

class Routes {
  static const String mainStartup = '/';
  static const all = <String>{
    mainStartup,
  };
}

class AutoRouter2 extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      Routes.mainStartup,
      page: MainStartup,
      generator: MainStartupRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    MainStartup: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MainStartup(),
        settings: data,
        maintainState: true,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension AutoRouter2ExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushMainStartup() => push<dynamic>(Routes.mainStartup);
}

class MainStartupRoutes {
  static const String mainScreen = '/';
  static const all = <String>{
    mainScreen,
  };
}

class MainStartupRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      MainStartupRoutes.mainScreen,
      page: MainScreen,
      generator: MainScreenRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    MainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainScreen(),
        settings: data,
        maintainState: true,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension MainStartupRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushMainScreen() =>
      push<dynamic>(MainStartupRoutes.mainScreen);
}

class MainScreenRoutes {
  static const String homeRoute = '/';
  static const String memberRoute = '/member-route';
  static const all = <String>{
    homeRoute,
    memberRoute,
  };
}

class MainScreenRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(MainScreenRoutes.homeRoute, page: HomeRoute),
    RouteDef(MainScreenRoutes.memberRoute, page: MemberRoute),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeRoute(),
        settings: data,
        maintainState: true,
      );
    },
    MemberRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberRoute(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension MainScreenRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushHomeRoute() => push<dynamic>(MainScreenRoutes.homeRoute);

  Future<dynamic> pushMemberRoute() =>
      push<dynamic>(MainScreenRoutes.memberRoute);
}

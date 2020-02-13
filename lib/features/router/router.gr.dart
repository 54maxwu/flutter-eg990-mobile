// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/router_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/home/presentation/home_route.dart';
import 'package:flutter_ty_mobile/features/users/presentation/login_route.dart';

class Router {
  static const homeRoute = '/';
  static const loginRoute = '/login-route';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeRoute(),
          settings: settings,
        );
      case Router.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginRoute(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

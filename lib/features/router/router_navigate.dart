import 'dart:async';

import 'package:flutter_ty_mobile/core/error/exceptions.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:meta/meta.dart' show required;

import '../../injection_container.dart' show sl;
import 'router.gr.dart';

part 'router_page.dart';
part 'router_widget_streams.dart';

class RouterNavigate {
  static final routerStreams = getRouterStreams;

  static final String _tag = 'Router';
  static String _currentRoute = '/';
  static String _previousRoute = '/';

  static get current => _currentRoute;

  static _setPath(String route, {String parentRoute = ''}) {
    _previousRoute = parentRoute.isEmpty ? _currentRoute : parentRoute;
    _currentRoute = route;
  }

  static _updateAppBar(RouterPage page) {
    print('updating app bar...page: $page');
    var info = page.info;
    routerStreams.updateTitle(info.title, hideActions: info.hideAppbarActions);
    routerStreams.updateLeading(!(info.isFeature));
  }

  static navigateToPage(RouterPage page, {bool cleanStack = true}) {
    var info = page.info;
    if (info.route == Router.homeRoute) {
      navigateClean();
      return;
    }
    try {
      if ((_currentRoute != Router.homeRoute && info.isFeature)) {
        print('navigate feature, from:$_currentRoute to:${info.route}');
        Router.navigator.pushNamedAndRemoveUntil(
            Router.homeRoute,
            (route) =>
                route.settings.name == info.route ||
                route.settings.name == Router.homeRoute);
      } else {
        print('navigate page, from:$_currentRoute to:${info.route}');
        Router.navigator.pushNamed(info.route);
      }
    } catch (e) {
      MyLogger.error(
          msg:
              'navigate to page has exception!! Router current: $_currentRoute, previous: $_previousRoute',
          error: e,
          tag: _tag);
    }

    if (cleanStack)
      _setPath(info.route, parentRoute: info.parentRoute);
    else
      _setPath(info.route);

    routerStreams.updateTitle(info.title, hideActions: info.hideAppbarActions);
    routerStreams.updateLeading(!(info.isFeature));
  }

  static navigateBack() {
    print(
        'Router current: $_currentRoute, previous: $_previousRoute ,canPop: ${Router.navigator.canPop()}');
    try {
      if (_previousRoute == Router.homeRoute)
        navigateClean();
      else if (_currentRoute != Router.homeRoute && Router.navigator.canPop())
        Router.navigator
            .popUntil((route) => route.settings.name == _previousRoute);
    } catch (e) {
      MyLogger.error(
          msg:
              'navigate back has exception!! Router current: $_currentRoute, previous: $_previousRoute',
          error: e,
          tag: _tag);
      // TODO restart app when router fails.
    }

    _setPath(_previousRoute, parentRoute: Router.homeRoute);

    var info = _previousRoute.toRouteInfo;
    routerStreams.updateTitle(info.title, hideActions: info.hideAppbarActions);
    routerStreams.updateLeading(!(info.isFeature));
  }

  static navigateClean() {
    print('navigate to home, from:$_currentRoute');
    if (_currentRoute != Router.homeRoute) {
      try {
//        Router.navigator.pushNamedAndRemoveUntil(Router.homeRoute, (route) => false);
        Router.navigator
            .popUntil((route) => route.settings.name == Router.homeRoute);
        routerStreams.updateUser(true);
      } catch (e) {
        MyLogger.error(
            msg:
                'navigate clean has exception!! Router current: $_currentRoute, previous: $_previousRoute',
            error: e,
            tag: _tag);
      }
    }
    _setPath(Router.homeRoute, parentRoute: Router.homeRoute);
    print('update home app bar on clean');
    _updateAppBar(RouterPage.HomeRoute);
  }

  static resetCheckUser() => routerStreams.updateUser(false);
}

import 'dart:async' show StreamController;

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/application/device/orientation_helper.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/utils/platform_util.dart';

import 'auto_router.dart';
import 'auto_router.gr.dart';
import 'route_page.dart';

class AppNavigator {
  static final String _tag = 'AppNavigator';
  static final homeName = MainScreenRoutes.homeRoute;
  static final refreshList = [
    // FeatureScreenRoutes.depositRoute,
    // FeatureScreenRoutes.transferRoute,
    // FeatureScreenRoutes.balanceRoute,
    // FeatureScreenRoutes.walletRoute,
    // FeatureScreenRoutes.messageRoute
  ];

  static int screenIndex = 0;
  static String _current = homeName;
  static String _previous = homeName;
  static bool _isWeb = false;

  static String get current => _current;

  static bool get loginToHomePage => _previous == homeName;

  static bool get isAtHome => _current == homeName;

  static bool get isWebRoute => _isWeb;

  static StreamController<Either<String, RouteInfo>> _routeInfo =
      StreamController<Either<String, RouteInfo>>.broadcast();

  static Stream<Either<String, RouteInfo>> get routeStream => _routeInfo.stream;

  static dispose() {
    MyLogger.warn(msg: 'disposing router stream!!', tag: _tag);
    _routeInfo.close();
  }

  static ExtendedNavigatorState get screenNavigate =>
      ExtendedNavigator.named('MainStartupRouter');

  static ExtendedNavigatorState get mainNavigate =>
      ExtendedNavigator.named('MainScreenRouter');

  static ExtendedNavigatorState get testNavigate =>
      ExtendedNavigator.named('TestRouter');

  static switchScreen(Screens screen, {Object webUrl, bool force = false}) {
    try {
      switch (screen) {
        // case Screens.Game:
        //   screenNavigate.pushWebGameScreen(startUrl: webUrl);
        //   OrientationHelper.disabledSystemUIOverlays();
        //   screenIndex = 1;
        //   break;
        // case Screens.Test:
        //   screenNavigate.pushTestScreen();
        //   screenIndex = 2;
        //   break;
        // case Screens.TestNav:
        //   screenNavigate.pushTestNestedNavScreen();
        //   screenIndex = 2;
        //   break;
        default:
          if (screenIndex == 0 && screenNavigate.canPop()) {
            screenNavigate.popUntil((route) {
              debugPrint('popping to feature screen: $route');
              return false;
            });
          } else {
            if (force) {
              screenNavigate.popUntilRoot();
              screenNavigate.replace(MainStartupRoutes.mainScreen);
            } else {
              screenNavigate.popUntilPath(homeName);
            }
            screenIndex = 0;
          }
          break;
      }
    } catch (e, s) {
      debugPrint('stack trace: $s');
      if (force) {
        MyLogger.error(
            msg:
                'force switch screen has exception, restarting app!! ERROR: $e',
            tag: _tag);
        // restart app
        Future.delayed(Duration(milliseconds: 200), () {
          if (Global.device.isIos) {
            _routeInfo.sink.add(Left(
                'Encountered a fatal error!! Please restart your app manually'));
          } else {
            _routeInfo.sink
                .add(Left('Encountered a fatal error, restarting in 2s...'));
            Future.delayed(
              Duration(milliseconds: 2000),
              () => PlatformUtil.restart(),
            );
          }
        });
      } else {
        MyLogger.error(
            msg:
                'switch screen has exception, resetting home screen!! ERROR: $e',
            tag: _tag);
        // reset nested navigator by replace home screen with a new one
        switchScreen(Screens.Main, force: true);
      }
    } finally {
      if (screenIndex != 1) {
        debugPrint('restoring screen orientation...');
        OrientationHelper.restoreUI();
      }
    }
  }

  static navigateTo(RoutePage page, {Object arg}) {
    // check current route, skip navigate if on same page
    if (page.pageName == _current) {
      MyLogger.debug(
          msg: 'should be on the same page. '
              'current: $_current, request: ${page.pageName}',
          tag: _tag);
      return;
    }
    // if target is HOME, call returnToHome()
    if (page.pageId == RouteEnum.HOME) {
      returnToHome();
      return;
    }

    debugPrint(
        'navigating: $_current -> ${page.pageId}, bottom index:${page.navIndex}');
    try {
      final arguments = arg ?? page.value.routeArg;
      // _isWeb = arguments != null && arguments is WebRouteArguments;
      // if (_isWeb) {
      //   debugPrint('web arg: $arguments');
      //   featureNavigate.push(FeatureScreenRoutes.webRoute,
      //       arguments: arguments);
      // } else {
      mainNavigate.push(
        page.pageName.replaceAll(ROUTE_POSTFIX_SIDE, ''),
        arguments: arguments,
      );
      // }
      updateNavigateRoute(page, parent: (_isWeb) ? page.pageRoot : _current);
    } catch (e) {
      MyLogger.error(
          msg: 'navigate to ${page.pageName} has exception!! Error: $e',
          tag: _tag);
      _isWeb = false;

      // retry navigate
      returnToHome(force: true);
      if (mainNavigate != null) {
        navigateTo(page, arg: arg ?? page.value.routeArg);
      }
    }
  }

  static replaceWith(RoutePage page, {Object arg}) {
    // check current route, skip navigate if on same page
    if (page.pageName == _current) {
      MyLogger.debug(
          msg: 'should be on the same page. '
              'current: $_current, request: ${page.pageName}',
          tag: _tag);
      return;
    }
    // if current route is home, then push the page
    if (_current == homeName) {
      debugPrint('cannot replace home route, switch to navigate...');
      navigateTo(page, arg: arg);
      return;
    }
    // if the page does not have the same parent, then push the page
    if (_previous != page.pageRoot) {
      debugPrint('route does not have the same parent, switch to navigate...');
      navigateTo(page, arg: arg);
      return;
    }

    try {
      debugPrint(
          'replacing: $_current -> ${page.pageId}, bottom index:${page.navIndex}');
      final arguments = arg ?? page.value.routeArg;
      // _isWeb = arguments != null && arguments is WebRouteArguments;
      // if (_isWeb) {
      //   debugPrint('web arg: $arguments');
      //   mainNavigate.replace(FeatureScreenRoutes.webRoute,
      //       arguments: arguments);
      // } else {
      mainNavigate.replace(
        page.pageName.replaceAll(ROUTE_POSTFIX_SIDE, ''),
        arguments: arguments,
      );
      // }

      updateNavigateRoute(
        page,
        parent: current,
        // parent:
        // (page.hasBottomNav || current != FeatureScreenRoutes.memberRoute)
        //     ? page.pageRoot
        //     : current,
      );
    } catch (e) {
      MyLogger.error(
          msg: 'replace $current to ${page.pageId} has exception!! Error: $e',
          tag: _tag);
      _isWeb = false;

      // retry navigate
      returnToHome(force: true);
      if (mainNavigate != null) {
        navigateTo(page, arg: arg ?? page.value.routeArg);
      }
    }
  }

  static back({bool usePreviousAsRoot = false}) async {
    final from = _current.toRoutePage;
    if (from == null) {
      debugPrint('route page not found');
      returnToHome();
    }

    try {
      if (AppNavigator.screenIndex != 0) {
        AppNavigator.switchScreen(Screens.Main);
      } else if (_previous == homeName) {
        returnToHome();
      } else if (mainNavigate.canPop()) {
        final dest = (usePreviousAsRoot || from.pageRoot == '-1')
            ? _previous.toRoutePage
            : from.pageRoot.toRoutePage;
        if (dest != null) {
          debugPrint('popping route until: ${dest.pageName}');
          mainNavigate.popUntilPath(dest.pageName);
          updateNavigateRoute(dest);
        } else {
          MyLogger.warn(msg: 'destination error, returning home', tag: _tag);
          // debugPrint('debug route from root: ${from.pageRoot}');
          // if (usePreviousAsRoot || from.pageRoot == '-1') {
          //   debugPrint('debug route previous: ${_previous}');
          //   debugPrint('debug route previous route: ${_previous.toRoutePage}');
          // } else {
          //   debugPrint('debug root page: ${from.pageRoot.toRoutePage}');
          // }
          returnToHome();
        }
        _isWeb = false;
      }
    } catch (e) {
      MyLogger.error(
          msg: 'navigate back from $_current has exception!! Error: $e',
          tag: _tag);
      _isWeb = false;
    }
  }

  static returnToHome({bool force = false}) {
    debugPrint('returning to home, from: $_current');
    try {
      if (force && _current == homeName) {
        switchScreen(Screens.Main);
      } else {
        mainNavigate.popUntilPath(homeName);
        // featureNavigate.popUntilRoot();
        // featureNavigate.replace(homeName);
      }
    } catch (e) {
      MyLogger.error(msg: 'navigate home has exception!! Error: $e', tag: _tag);
      switchScreen(Screens.Main);
    }
    _isWeb = false;

    final dest = RoutePage.home;
    updateNavigateRoute(dest);
  }

  static updateNavigateRoute(RoutePage page,
      {String parent, bool updateParent = true}) {
    _setPath(page, parent: (updateParent) ? parent : _previous);
    _streamRouteInfo(page.value);
  }

  static _streamRouteInfo(RouteInfo pageInfo) =>
      _routeInfo.sink.add(Right(pageInfo));

  static _setPath(RoutePage route, {String parent}) {
    if (route == null) {
      MyLogger.error(msg: 'set navigate path error!!', tag: _tag);
    }
    _previous = parent ?? route.pageRoot;
    _current = route.pageName;
    debugPrint(
        'update navigate path, current: $_current, previous: $_previous');
  }

  static testNavigateTo(RoutePage page) {
    debugPrint('test navigate...page: ${page.value}');
    _setPath(page);
    _streamRouteInfo(page.value);
  }
}

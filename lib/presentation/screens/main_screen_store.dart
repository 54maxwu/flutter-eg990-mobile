import 'dart:async';

import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/presentation/router/app_navigator_export.dart';

part 'main_screen_store.g.dart';

class MainScreenStore = _MainScreenStore with _$MainScreenStore;

abstract class _MainScreenStore with Store {
  _MainScreenStore() {
    // initialize route observe
    routeSubscript = AppNavigator.routeStream.listen((route) {
      currentPage = route;
    });
    currentPage ??= RoutePage.home.value;
  }

  /// Route
  StreamSubscription<RouteInfo> routeSubscript;
  @observable
  RouteInfo currentPage;

  Future<void> cancelStreams() {
    try {
      return Future.wait([
        routeSubscript.cancel(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close feature stream error', error: e, tag: 'MainScreenStore');
      return null;
    }
  }
}

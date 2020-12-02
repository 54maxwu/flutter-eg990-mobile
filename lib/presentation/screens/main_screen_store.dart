import 'dart:async';

import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';

part 'main_screen_store.g.dart';

class MainScreenStore = _MainScreenStore with _$MainScreenStore;

abstract class _MainScreenStore with Store {
  _MainScreenStore() {
    // initialize route observe
    routeSubscript = AppNavigator.routeStream.listen((e) => e.fold(
          (error) => setErrorMsg(msg: error),
          (route) => currentPage = route,
        ));
    currentPage ??= RoutePage.home.value;
  }

  /// Route
  StreamSubscription<Either<String, RouteInfo>> routeSubscript;

  @observable
  RouteInfo currentPage;

  /// Error
  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.NAVIGATOR,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

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

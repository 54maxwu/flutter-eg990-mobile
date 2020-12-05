import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../router/data/route_info.dart';
import 'event/ads/state/ads_store.dart';
import 'main_screen_store.dart';
import 'user/user_info_store.dart';

export 'package:provider/provider.dart';

abstract class MainScreenProviderInterface with ChangeNotifier {
  GlobalKey<NavigatorState> get getNavigatorKey;

  GlobalKey<ScaffoldState> get getScaffoldKey;

  set update(MainScreenProvider provider);

  RouteInfo get getPageInfo;

  void notifyUserInfoUpdated();
}

class MainScreenProvider
    with ChangeNotifier
    implements MainScreenProviderInterface {
  final MainScreenStore screenStore;
  final AdStore adStore;
  final UserInfoStore userInfoStore;

  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<NavigatorState> _navigatorKey;

  MainScreenProvider({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required GlobalKey<NavigatorState> navigatorKey,
    @required this.screenStore,
    @required this.adStore,
    @required this.userInfoStore,
  }) {
    _scaffoldKey = scaffoldKey;
    _navigatorKey = navigatorKey;
  }

  @override
  GlobalKey<NavigatorState> get getNavigatorKey => _navigatorKey;

  @override
  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;

  @override
  set update(MainScreenProvider provider) {
    bool notify = false;
    if (provider.getScaffoldKey != _scaffoldKey) {
      _scaffoldKey = provider.getScaffoldKey;
      debugPrint('feature screen provider - scaffold key updated');
      notify = true;
    }
    if (provider.getNavigatorKey != _navigatorKey) {
      _navigatorKey = provider.getNavigatorKey;
      debugPrint('feature screen provider - navigate key updated');
      notify = true;
    }
    if (notify) notifyListeners();
  }

  @override
  RouteInfo get getPageInfo => screenStore.currentPage;

  @override
  void notifyUserInfoUpdated() => userInfoStore.setRecheck = true;
}

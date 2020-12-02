import 'dart:async' show StreamSubscription;

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/infrastructure/core/network_info.dart';
import 'package:flutter_eg990_mobile/presentation/common/window/network_changed_dialog.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/state/home_store.dart';
import 'package:flutter_eg990_mobile/presentation/screens/streams/app_preference_streams.dart';
import 'package:flutter_eg990_mobile/utils/platform_util.dart';
import 'package:provider/provider.dart';

import 'main_screen_provider.dart';
import 'main_screen_store.dart';
import 'menu/screen_menu_bar.dart';
import 'navbar/screen_navigation_bar.dart';

///
/// Main app screen
///
/// Include [MainScreenStore] which holds current page info and user data.
///
/// Creates the app scaffold with:
/// top navigation bar [ScreenMenuBar]
/// bottom navigation bar [ScreenNavigationBar]
/// body [ExtendedNavigator] to show nested [MainScreenRouter] page
///
class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AfterLayoutMixin {
  final String tag = 'FeatureScreenNew';
  final MainScreenStore _store = sl();
  final GlobalKey<NavigatorState> featureNavKey =
      new GlobalKey(debugLabel: 'featureNavKey');
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  StreamSubscription<ConnectivityResult> networkSubscript;
  ConnectivityResult _currentNetworkType;
  bool _showingNetworkChangeDialog = false;

  MainScreenProvider _screenProvider;
  String _locale;
  int _closeAppCount = 0;

  /// Bind Network listener and listen to network status change.
  /// Shows a dialog that allows user to refresh current view.
  void setNetworkListener() {
    try {
      networkSubscript = sl
          .get<NetworkInfo>()
          .onChangedStream
          .listen((ConnectivityResult result) {
        debugPrint('feature screen connectivity result: $result');
        if (_currentNetworkType != null &&
            mounted &&
            !_showingNetworkChangeDialog) {
          try {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => NetworkChangedDialog(
                onRefreshClick: () => updateScreen(),
                onClose: () => _showingNetworkChangeDialog = false,
              ),
            );
            _showingNetworkChangeDialog = true;
          } catch (e) {
            MyLogger.error(msg: 'connectivity dialog has error: $e');
          }
        } else {
          _currentNetworkType = result;
        }
      });
    } catch (e) {
      MyLogger.warn(msg: 'connectivity listener has error: $e');
      networkSubscript = null;
    }
  }

  void updateScreen() {
    debugPrint('reassembling feature screen...');
    try {
      sl?.get<HomeStore>()?.getInitializeData(force: true);
      Future.delayed(
          Duration(milliseconds: (AppNavigator.isAtHome) ? 2000 : 100), () {
        // refresh widget under scaffold (ex. menu bar, nav bar...)
        _scaffoldKey?.currentState?.setState(() {});
        // refresh current route widget
        ExtendedNavigator.root.reassemble();
      });
    } catch (e) {
      MyLogger.error(msg: 'update feature screen has error: $e');
      PlatformUtil.restart();
    }
  }

  @override
  void initState() {
    MyLogger.debug(msg: 'init feature screen', tag: tag);
    _locale = Global.lang;
    super.initState();
    setNetworkListener();
  }

  @override
  void didUpdateWidget(MainScreen oldWidget) {
    MyLogger.debug(msg: 'update feature screen', tag: tag);
    super.didUpdateWidget(oldWidget);
    if (networkSubscript == null) setNetworkListener();
  }

  @override
  void didChangeDependencies() {
    MyLogger.debug(msg: 'change feature screen', tag: tag);
    if (_screenProvider != null) {
      _screenProvider.update = MainScreenProvider(
        scaffoldKey: _scaffoldKey,
        navigatorKey: featureNavKey,
        screenStore: _store,
        adStore: sl(),
        userInfoStore: sl(),
      );
    }
    _screenProvider ??= MainScreenProvider(
      scaffoldKey: _scaffoldKey,
      navigatorKey: featureNavKey,
      screenStore: _store,
      adStore: sl(),
      userInfoStore: sl(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MyLogger.debug(msg: 'build feature screen', tag: tag);
    return WillPopScope(
      onWillPop: () async {
        MyLogger.debug(msg: 'pop feature screen', tag: 'FeatureScreenNew');
        _closeAppCount += 1;
        Future.delayed(Duration(milliseconds: 500), () => _closeAppCount = 0);
        if (_closeAppCount > 1)
          return Future(() => true); // exit app
        else if (_closeAppCount == 1) callToast(localeStr.exitAppHint);
        return Future(() => false);
      },
      child: StreamBuilder<String>(
          stream: appPreference.languageStream,
          initialData: Global.lang,
          builder: (ctx, snapshot) {
            _locale ??= snapshot.data;
            if (snapshot.data != _locale) {
              _locale = snapshot.data;
              debugPrint('feature screen language changed: ${snapshot.data}');
              updateScreen();
            }
            return ChangeNotifierProvider.value(
              value: _screenProvider,
              child: Scaffold(
                key: _scaffoldKey,
                appBar: ScreenMenuBar(),
                bottomNavigationBar: ScreenNavigationBar(),
                body: ExtendedNavigator(
                  key: featureNavKey,
                  initialRoute: MainScreenRoutes.homeRoute,
                  router: MainScreenRouter(),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    MyLogger.warn(msg: 'disposing feature screen', tag: tag);
    try {
      Global.initLocale = false;
      _store.cancelStreams();
    } on Exception {}
    super.dispose();
    networkSubscript?.cancel();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (_screenProvider != null) {
      // _screenProvider.eventStore.getAds();
    }
  }
}

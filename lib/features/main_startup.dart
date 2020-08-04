import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../core/internal/device.dart';
import '../core/internal/global.dart';
import '../core/internal/local_strings.dart';
import '../injection_container.dart' show sl;
import '../mylogger.dart';
import 'general/toast_widget_export.dart';
import 'router/app_navigate.dart';
import 'screen/web_game_screen_store.dart';

///
/// Build the main ui using [ScreenRouter] and
/// add [WillPopScope] to intercept back button action.
///
/// @author H.C.CHIANG
/// @version 2020/2/5
///
class MainStartup extends StatefulWidget {
  @override
  _MainStartupState createState() => _MainStartupState();
}

class _MainStartupState extends State<MainStartup> {
  final String keyId = 'Navi';

  int closeAppCount = 0;

  void registerLocale(BuildContext context) {
    try {
      sl.registerSingleton<LocalStrings>(LocalStrings(context));
//      print('test locale:${sl.get<LocalStrings>().res.pageTitleHome}');
    } catch (e) {
      MyLogger.warn(msg: 'locale file has exception: $e');
    } finally {
      Global.regLocale = true;
    }
//    print('test locale res:${localeStr.pageTitleHome}');
//    sl.get<LocalStrings>().init().then((value) {
//      print('test locale res1:${S.of(context).pageHomeRoute}');
//      print('test locale res2:${sl.get<LocalStrings>().res.pageHomeRoute}');
//    });
  }

  void getDeviceInfo(BuildContext context) {
    Global.device = Device(MediaQuery.of(context), Platform.isIOS);
    print('Device Size: ${Global.device}');
  }

  @override
  Widget build(BuildContext context) {
    if (Global.device == null) getDeviceInfo(context);
    if (Global.regLocale == false) registerLocale(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          MyLogger.debug(
              msg: 'pop screen ${ScreenNavigate.screenIndex}',
              tag: 'MainStartup');
          if (ScreenNavigate.screenIndex == 1) {
            // Stop rotate sensor and clear web view cache
            sl.get<WebGameScreenStore>()?.stopSensor();
            ScreenNavigate.switchScreen(screen: ScreenEnum.Feature);
          } else if (ScreenNavigate.screenIndex == 2) {
            ScreenNavigate.switchScreen();
          } else if (RouterNavigate.current == Routes.homeRoute) {
            closeAppCount += 1;
            Future.delayed(
                Duration(milliseconds: 500), () => closeAppCount = 0);
            if (closeAppCount > 1)
              return Future(() => true); // exit app
            else if (closeAppCount == 1) callToast(localeStr.exitAppHint);
          } else {
            RouterNavigate.navigateBack();
          }
          return Future(() => false);
        },
        child: Scaffold(
          body: ExtendedNavigator<ScreenRouter>(
            initialRoute: ScreenRoutes.featureScreen,
            router: ScreenRouter(),
          ),
        ),
//        body: Navigator(
//          key: ScreenRouter.navigator.key,
//          onGenerateRoute: ScreenRouter.onGenerateRoute,
//          initialRoute: ScreenRouter.featureScreen,
//        ),
      ),
    );
  }
}

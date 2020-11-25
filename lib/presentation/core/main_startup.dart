import 'dart:io' show Platform;

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/device/device.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/presentation/features/event/update/state/update_store.dart';
import 'package:flutter_eg990_mobile/presentation/screens/game/web_game_screen_store.dart';
import 'package:provider/provider.dart';

import '../router/app_navigator.dart';
import '../router/auto_router.dart';
import '../router/auto_router.gr.dart';
import '../router/navigate_provider.dart';

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

class _MainStartupState extends State<MainStartup> with AfterLayoutMixin {
  final String keyId = 'Navi';
  final GlobalKey<NavigatorState> screenNavKey =
      new GlobalKey(debugLabel: 'screenNavKey');
  final GlobalKey<NavigatorState> _navKey = new GlobalKey(debugLabel: 'navKey');

  bool _isIos;

  void registerLocale(BuildContext context) {
    try {
      sl.registerSingleton<LocalStrings>(LocalStrings(context));
//      debugPrint('test locale:${sl.get<LocalStrings>().res.pageTitleHome}');
    } catch (e) {
      MyLogger.warn(msg: 'locale file has exception: $e');
    } finally {
      Global.initLocale = true;
    }
//    debugPrint('test locale res:${localeStr.pageTitleHome}');
//    sl.get<LocalStrings>().init().then((value) {
//      debugPrint('test locale res1:${S.of(context).pageHomeRoute}');
//      debugPrint('test locale res2:${sl.get<LocalStrings>().res.pageHomeRoute}');
//    });
  }

  void getDeviceInfo(BuildContext context) {
    _isIos = Platform.isIOS;
    Global.device = Device(MediaQuery.of(context), _isIos);
    debugPrint('Device:\n----------\n${Global.device}\n----------');
  }

  @override
  Widget build(BuildContext context) {
    if (Global.device == null) getDeviceInfo(context);
    if (Global.initLocale == false) registerLocale(context);
    return SafeArea(
      top: !_isIos,
      child: WillPopScope(
        onWillPop: () async {
          MyLogger.debug(
              msg: 'pop screen ${AppNavigator.screenIndex}'
                  ' route: ${AppNavigator.current}',
              tag: 'MainStartup');
          if (AppNavigator.screenIndex != 0) {
            // Stop rotate sensor and clear web view cache
            if (AppNavigator.screenIndex == 1) {
              sl.get<WebGameScreenStore>()?.stopSensor();
            }
            AppNavigator.switchScreen(Screens.Main);
          } else if (AppNavigator.isAtHome) {
            return Future(() => true);
          } else {
            AppNavigator.back();
          }
          return Future(() => false);
        },
        child: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => NavigateProvider(initKey: _navKey),
            child: ExtendedNavigator(
              key: screenNavKey,
              navigatorKey: _navKey,
              initialRoute: MainStartupRoutes.mainScreen,
              router: MainStartupRouter(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    /// TODO move the update check to app resume
    final updateStore = sl.get<UpdateStore>();
    if (updateStore != null) {
      updateStore.dialogClosed();
      // final Future<bool> updateFuture =
//          Future.delayed(Duration(seconds: 5), () => updateStore.getVersion());
//      updateFuture.then((hasUpdate) {
//        if (hasUpdate) {
//          showDialog(
//            context: context,
//            barrierDismissible: false,
//            builder: (context) => UpdateDialog(
//              newVersion: updateStore.serverAppVersion,
//              onUpdateClick: () {
//                String url = updateStore.serverAppUrl;
//                if (url == null || url.isEmpty || url.isUrl == false)
//                  callToastError(localeStr.updateDialogErrorUrl);
//                else
//                  launch(updateStore.serverAppUrl);
//              },
//              onDialogClose: () => updateStore.dialogClosed(),
//            ),
//          );
//        } else {
//          updateStore.dialogClosed();
//        }
//      });
    }
  }
}

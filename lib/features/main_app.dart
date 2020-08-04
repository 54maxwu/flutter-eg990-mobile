import 'dart:io' show Platform;

import 'package:after_layout/after_layout.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/generated/l10n.dart';
import 'package:flutter_ty_mobile/injection_container.dart';
import 'package:flutter_ty_mobile/mylogger.dart';

import 'home/presentation/state/home_store.dart';
import 'main_startup.dart';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>
    with WidgetsBindingObserver, AfterLayoutMixin {
  final String tag = 'Main';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        MyLogger.info(msg: 'app paused', tag: tag);
//        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
//        exit(0); // exit the app on paused
        break;
      case AppLifecycleState.resumed:
        MyLogger.info(msg: 'app resumed', tag: tag);
        break;
      case AppLifecycleState.inactive:
        MyLogger.info(msg: 'app inactive', tag: tag);
        break;
      case AppLifecycleState.detached:
        MyLogger.info(msg: 'app detached', tag: tag);
        break;
    }
  }

  @override
  void initState() {
    MyLogger.info(msg: 'app init', tag: tag);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    MyLogger.info(msg: 'app dependencies', tag: tag);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    sl.get<RouteUserStreams>().dispose();
    sl.get<HomeStore>().closeStreams();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLogger.info(msg: 'app build', tag: tag);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (Platform.isAndroid) {
          for (var supp in supportedLocales) {
            if (supp.languageCode == deviceLocale.languageCode) return supp;
          }
        }
        return const Locale.fromSubtags(languageCode: 'zh');
      },
      localeListResolutionCallback: (deviceLocales, supportedLocales) {
        print('device locales: $deviceLocales');
        print('supported locales: $supportedLocales');
        if (Platform.isAndroid) {
          for (var loc in deviceLocales) {
            for (var supp in supportedLocales) {
              if (supp.languageCode == loc.languageCode) return supp;
            }
          }
        }
        return const Locale.fromSubtags(languageCode: 'zh');
      },
      theme: appTheme.defaultTheme,
      title: 'TY Mobile',
      // Tell MaterialApp to use our ExtendedNavigator instead of
      // the native one by assigning it to it's builder
//    builder: ExtendedNavigator<ScreenRouter>(router: ScreenRouter()),
      builder: BotToastInit(),
//            builder: (context, child) {
//              child = myBuilder(context,child);  //do something
//              child = botToastBuilder(context,child);
//              return child;
//            },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: new MainStartup(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
//    if (permissionException != null) {
//      showDialog(
//          context: context,
//          builder: (context) {
//            return AlertDialog(
//              title: Text('Permission'),
//              content: Column(
//                children: <Widget>[
//                  Text('We are sorry that something went wrong, '
//                      'please turn on location permission manually.\n'
//                      '$permissionException'),
//                  // NOTICE: delete this on release
//                  Container(
//                    height: 200,
//                    child: SingleChildScrollView(
//                      child: RichText(
//                        text: TextSpan(text: '$permissionStackTrace'),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('Settings'),
//                  onPressed: () => openAppSettings(),
//                ),
//                FlatButton(
//                  child: Text('OK'),
//                  onPressed: () => Navigator.of(context).pop(),
//                ),
//              ],
//            );
//          });
//    }
  }
}

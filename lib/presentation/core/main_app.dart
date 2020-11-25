import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/data/app_cache.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_color_enum.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/generated/l10n.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/state/home_store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'main_startup.dart';
import '../streams/app_preference_streams.dart';
import '../router/auto_router.gr.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final String tag = 'Main';

  final botToastBuilder = BotToastInit();
  final navBuilder = ExtendedNavigator.builder<AutoRouter2>(
    router: AutoRouter2(),
    observers: [BotToastNavigatorObserver()],
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        MyLogger.info(msg: 'app detached', tag: tag);
        break;
      case AppLifecycleState.resumed:
        MyLogger.info(msg: 'app resumed', tag: tag);
        break;
      case AppLifecycleState.inactive:
        MyLogger.info(msg: 'app inactive', tag: tag);
        break;
      case AppLifecycleState.paused:
        MyLogger.info(msg: 'app paused', tag: tag);
        AppCache.closeBox();
//        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
//        exit(0); // exit the app on paused
        break;
    }
  }

  @override
  void initState() {
    MyLogger.debug(msg: 'app init', tag: tag);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    MyLogger.debug(msg: 'app changed', tag: tag);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MainApp oldWidget) {
    MyLogger.debug(msg: 'app update', tag: tag);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    MyLogger.debug(msg: 'app dispose', tag: tag);
    sl.get<AppPreferenceStreams>().dispose();
    sl.get<HomeStore>().closeStreams();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyLogger.debug(msg: 'app build', tag: tag);
    return StreamBuilder<ThemeColorEnum>(
        stream: appPreference.themeStream,
        initialData: ThemeInterface.theme.colorEnum,
        builder: (context, snapshot) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              // if (Platform.isAndroid) {
              //   for (var supp in supportedLocales) {
              //     if (supp.languageCode == deviceLocale.languageCode)
              //       return supp;
              //   }
              // }
              return Locale.fromSubtags(languageCode: Global.lang);
            },
            localeListResolutionCallback: (deviceLocales, supportedLocales) {
              // debugPrint('device locales: $deviceLocales');
              // debugPrint('supported locales: $supportedLocales');
              // if (Platform.isAndroid) {
              //   for (var loc in deviceLocales) {
              //     for (var supp in supportedLocales) {
              //       if (supp.languageCode == loc.languageCode) return supp;
              //     }
              //   }
              // }
              return Locale.fromSubtags(languageCode: Global.lang);
            },
            theme: ThemeInterface.theme.data,
            // builder: ExtendedNavigator<ScreenRouter>(router: ScreenRouter()),
            // builder: BotToastInit(),
            // navigatorObservers: (firebaseObserver != null)
            //     ? [BotToastNavigatorObserver(), firebaseObserver]
            //     : [BotToastNavigatorObserver()],
            builder: (context, child) {
              child = navBuilder(context, child);
              child = botToastBuilder(context, child);
              return child;
            },
            home: new MainStartup(),
          );
        });
  }
}

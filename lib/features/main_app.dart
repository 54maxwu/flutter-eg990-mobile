import 'dart:io' show Platform, exit;

import 'package:after_layout/after_layout.dart';
import 'package:flui/flui.dart' show FLToastDefaults, FLToastProvider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ty_mobile/core/data/hive_adapters_export.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/home/home_inject.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/generated/l10n.dart';
import 'package:flutter_ty_mobile/injection_container.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:super_enum/super_enum.dart';

import 'main_startup.dart';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>
    with WidgetsBindingObserver, AfterLayoutMixin {
  final String tag = 'Main';
  final FLToastDefaults _toastDefaults = FLToastDefaults();
  List<Permission> permissionList;
  Exception permissionException;
  StackTrace permissionStackTrace;
  var _hiveInitialized = false;

  Future<void> _initPermissionList() async {
    try {
      return await permissionList.request().then((map) async {
        StringBuffer result = new StringBuffer();
        map.forEach((key, value) {
          result.write('permission: $key is ${value.isGranted}');
          if (key != map.keys.last) result.write('\n');
        });
        MyLogger.log(msg: 'Permissions: ${result.toString()}', tag: tag);
      });
    } catch (e, s) {
      permissionException = e;
      // NOTICE: delete this on release
      permissionStackTrace = s;
    }
  }

  Future<void> _initHive() async {
    if (!_hiveInitialized) {
      final docDir = await getApplicationDocumentsDirectory();
      Hive.init(docDir.path);
      MyLogger.debug(msg: 'Hive initialized, location: $docDir', tag: tag);

      //TODO: Register data adapters here
      try {
        Hive.registerAdapter(BannerEntityAdapter());
        Hive.registerAdapter(MarqueeEntityAdapter());
        Hive.registerAdapter(GameCategoryModelAdapter());
        Hive.registerAdapter(GamePlatformEntityAdapter());
        Hive.registerAdapter(CookieAdapter());
        Hive.registerAdapter(HiveCookieEntityAdapter());
        Hive.registerAdapter(PromoEntityAdapter());
        Hive.registerAdapter(LoginHiveFormAdapter());
      } catch (e) {
        MyLogger.warn(
            msg: 'register hive adapter has error!!', tag: tag, error: e);
      }
      _hiveInitialized = true;
      return await Future.delayed(
          Duration(milliseconds: 200),
          () => MyLogger.debug(
              msg: 'Hive adapters had been registered', tag: tag));
    }

    /// Rebuild the app if Hive had been initialized
    MyLogger.debug(msg: 'Hive already initialized!!', tag: tag);
    return await Future.value();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        MyLogger.info(msg: 'app paused', tag: tag);
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        exit(0); // exit the app on paused
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
    if (Platform.isIOS)
      permissionList = [Permission.location, Permission.storage];
    else
      permissionList = Permission.values;

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
    Hive.close().then((value) => _hiveInitialized = false);
    sl.get<RouteUserStreams>().dispose();
    sl.get<HomeStore>().closeStreams();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLogger.info(msg: 'app build', tag: tag);
    return FutureBuilder(
      future: Future.wait([_initPermissionList(), _initHive()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: Themes.defaultBackgroundColor,
          );
        } else {
          return FLToastProvider(
            defaults: _toastDefaults,
            child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                S.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (Platform.isAndroid) {
                  for (var supp in supportedLocales) {
                    if (supp.languageCode == deviceLocale.languageCode)
                      return supp;
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
//              builder: ExtendedNavigator<ScreenRouter>(router: ScreenRouter()),
              home: new MainStartup(),
            ),
          );
        }
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (permissionException != null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Permission'),
              content: Column(
                children: <Widget>[
                  Text('We are sorry that something went wrong, '
                      'please turn on location permission manually.\n'
                      '$permissionException'),
                  // NOTICE: delete this on release
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      child: RichText(
                        text: TextSpan(text: '$permissionStackTrace'),
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Settings'),
                  onPressed: () => openAppSettings(),
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }
  }
}

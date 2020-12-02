import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'application/device/orientation_helper.dart';
import 'application/global.dart';
import 'application/themes/theme_color_enum.dart';
import 'application/themes/theme_interface.dart';
import 'domain/auth/hive_cookie.dart';
import 'domain/domain_hive_adapters_export.dart';
import 'env/config_reader.dart';
import 'env/environment.dart';
import 'infrastructure/hive/hive_actions.dart';
import 'injection_container.dart' as di;
import 'mylogger.dart';
import 'presentation/core/main_app.dart';

Future<void> mainCommon(Environment env) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();
  // Load the JSON config into memory
  await ConfigReader.initialize();

  switch (env) {
    case Environment.DEV:
      debugPrint('App Config Debug Version: ${ConfigReader.getVersion()}');
      break;
    case Environment.RELEASE:
      MyLogger.log(msg: 'App Config Version: ${ConfigReader.getVersion()}');
      break;
  }

  // request permission
  if (Platform.isIOS)
    await _initPermissionList([Permission.location, Permission.storage]);
  else
    await _initPermissionList(Permission.values);

  // setup log
  _setupLogging();

  // setup orientation
  OrientationHelper.setPreferredOrientations();
  OrientationHelper.enabledSystemUIOverlays();

  // setup injector
  await di.init();

  // init hive database
  final docDir = await getApplicationDocumentsDirectory();
  Hive.init(docDir.path);
  debugPrint('Hive initialized, location: $docDir');
  try {
    Hive.registerAdapter(CookieAdapter());
    Hive.registerAdapter(HiveCookieEntityAdapter());
    Hive.registerAdapter(BannerEntityAdapter());
    Hive.registerAdapter(MarqueeEntityAdapter());
    Hive.registerAdapter(GameCategoryEntityAdapter());
    Hive.registerAdapter(GamePlatformEntityAdapter());
    Hive.registerAdapter(GameEntityAdapter());
    Hive.registerAdapter(LoginFormHiveAdapter());
    Hive.registerAdapter(PromoEntityAdapter());
  } catch (e) {
    debugPrint('register hive adapter has error!! $e');
  }

  // check app language setting
  try {
    Box box = await Future.value(getHiveBox(Global.CACHE_APP_DATA));
    if (box.containsKey(Global.CACHE_APP_DATA_KEY_LANG)) {
      Global.setLanguage =
          box.get(Global.CACHE_APP_DATA_KEY_LANG, defaultValue: 'zh');
    } else {
      box.put(Global.CACHE_APP_DATA_KEY_LANG, Global.lang);
    }
    if (box.containsKey(Global.CACHE_APP_DATA_KEY_THEME)) {
      String themeValue = box.get(Global.CACHE_APP_DATA_KEY_THEME,
          defaultValue: ThemeColorEnum.DEFAULT.value);
      ThemeInterface.theme
          .setTheme(ThemeColorEnum.getByValue(themeValue), notify: false);
    } else {
      box.put(Global.CACHE_APP_DATA_KEY_THEME, ThemeColorEnum.DEFAULT.value);
    }
  } catch (e) {
    debugPrint('read app setting has error!! $e');
  } finally {
    debugPrint('app language: ${Global.lang}');
    debugPrint('app theme: ${ThemeInterface.theme.colorEnum.value}');
  }

  // hide keyboard and wait for 500ms to get the correct viewInset
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  await Future.delayed(Duration(milliseconds: 500));

  // run application
  runApp(new MainApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.loggerName}: [${rec.level.name}] ${rec.message}');
  });
}

Future<void> _initPermissionList(List<Permission> permissions) async {
  try {
    return await permissions.request().then((map) async {
      StringBuffer result = new StringBuffer();
      map.forEach((key, value) {
        result.write('permission: $key is ${value.isGranted}');
        if (key != map.keys.last) result.write('\n');
      });
      debugPrint('Permissions: ${result.toString()}');
    });
  } catch (e) {
    debugPrint('permission request has exception: $e');
  }
}

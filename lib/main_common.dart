import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'application/data/app_cache.dart';
import 'application/device/orientation_helper.dart';
import 'application/global.dart';
import 'application/internal/language_code.dart';
import 'application/themes/theme_interface.dart';
import 'domain/auth/hive_cookie.dart';
import 'domain/domain_hive_adapters_export.dart';
import 'env/config_reader.dart';
import 'env/environment.dart';
import 'injection_container.dart' as di;
import 'mylogger.dart';
import 'presentation/core/main_app.dart';

Future<void> mainCommon(Environment env) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();
  // Load the JSON config into memory
  await ConfigReader.initialize();

  switch (env) {
    default:
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

  // initialize hive database
  await _initHive();

  // initialize app settings
  await _readAppSettings();

  // hide keyboard and wait for 500ms to get the correct viewInset
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  await Future.delayed(Duration(milliseconds: 500));

  // run application
  runApp(new MainApp());
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

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.loggerName}: [${rec.level.name}] ${rec.message}');
  });
}

Future<void> _initHive() async {
  final docDir = await getApplicationDocumentsDirectory();
  Hive.init(docDir.path);
  debugPrint('Hive initialized, location: $docDir');
  try {
    Hive.registerAdapter(CookieAdapter());
    Hive.registerAdapter(HiveCookieEntityAdapter());
    Hive.registerAdapter(HiveJsonCacheAdapter());
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
}

Future<void> _readAppSettings() async {
  try {
    // debugPrint('test app hive ${AppCache.testHive()}');
    // debugPrint('test app cache language: ${AppCache.getAppLanguage()}');
    // debugPrint('test app cache theme: ${AppCache.getAppTheme()}');
    /// check app locale setting
    if (!Global.lockLanguage) {
      // set language as user preference
      final lang = await AppCache.getAppLanguage();
      debugPrint('last app language: ${lang.value}');
      Global.setLocale = lang;
    } else {
      // override language if language is locked and different as default
      AppCache.resetToDefaultLocale();
      Global.setLocale = defaultLocale;
    }

    /// check app theme setting
    ThemeInterface.theme
        .setTheme(ThemeInterface.theme.colorEnum, notify: false);
    // final theme = await AppCache.getAppTheme();
    // debugPrint('last app theme: $theme');
    // ThemeInterface.theme.setTheme(theme, notify: false);
  } catch (e) {
    debugPrint('read app cache has error!! $e');
  }
}

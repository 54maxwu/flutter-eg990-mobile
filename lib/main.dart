import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ty_mobile/core/data/hive_adapters.dart';
import 'package:flutter_ty_mobile/core/internal/permission_item.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'generated/l10n.dart';
import 'injection_container.dart' as di;
import 'main_startup.dart';
import 'mylogger.dart';

void main() async {
  // setup log
  _setupLogging();
  // setup injector
  await di.init();
  // run application
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.loggerName}: [${rec.level.name}] ${rec.message}');
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Logger _logger = new Logger('MyApp');
  final List<PermissionItem> permissions = List<PermissionItem>();

  Future<Box> _initHive() async {
    final docDir = await getApplicationDocumentsDirectory();
    Hive.init(docDir.path);
    _logger.fine('Hive initialized, location: $docDir');

    /// register data adapters here
    try {
      Hive.registerAdapter(BannerEntityAdapter());
      Hive.registerAdapter(MarqueeEntityAdapter());
      Hive.registerAdapter(GameCategoryModelAdapter());
      Hive.registerAdapter(GamePlatformEntityAdapter());
    } catch (e) {
      MyLogger.warn(
          msg: 'register hive adapter has error!!', tag: 'MAIN', error: e);
    }
    return Hive.openBox('mobile');
  }

  void _initPermissionList() async {
    permissions.clear();
    await Future.forEach(
        PermissionGroup.values,
        (value) =>
            permissions.add(PermissionItem(value, PermissionStatus.unknown)));
    return _resolvePermissionState();
  }

  Future<void> _resolvePermissionState() async {
    await Future.forEach(permissions, (item) async {
      int index = permissions.indexOf(item);
      await (PermissionHandler().checkPermissionStatus(item.group))
          .then((status) => permissions[index].status = status);
    });
    if (permissions.isNotEmpty) permissions.requestPermission();
  }

  @override
  void initState() {
    _initPermissionList();
    _initHive();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: appTheme.defaultTheme,
      title: 'TY Mobile',
      home: MainStartup(),
    );
    return app;
  }

  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }
}

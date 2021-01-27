import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/application/internal/language_code.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_color_enum.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_json_cache.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';

const String _BOX_NAME = 'HIVE_APP_CACHE';
const String _CACHE_KEY_LANG = 'lang';
const String _CACHE_KEY_THEME = 'theme';
const String _CACHE_KEY_AD = 'ads';

class AppCache {
  // static Future<Box> testHive() async => (!Hive.isBoxOpen(_BOX_NAME))
  //     ? await Hive.openBox<HiveJsonCache>(_BOX_NAME)
  //     : Hive.box<HiveJsonCache>(_BOX_NAME);

  static void closeBox() => closeHiveBox(_BOX_NAME);

  static void save(HiveJsonCache cache, String key) =>
      _save(MapEntry(key, cache));

  static void delete(String key) => _delete(key);

  static Future<HiveJsonCache> retrieve(String key) => retrieve(key);

  /// APP Locale Settings
  static void saveAppLocale(LanguageCode lang) => _save(MapEntry(
        _CACHE_KEY_LANG,
        HiveJsonCache(cacheMap: {'code': lang.value.code}, hasData: true),
      ));

  static void resetToDefaultLocale() => _save(MapEntry(
        _CACHE_KEY_LANG,
        HiveJsonCache(
          cacheMap: {'code': defaultLocale.value.code},
          hasData: true,
        ),
      ));

  static Future<LanguageCode> getAppLanguage() async =>
      await _retrieve(_CACHE_KEY_LANG).then((HiveJsonCache value) {
        if (value.hasData &&
            value.cacheMap != null &&
            value.cacheMap.containsKey('code')) {
          final String code = value.cacheMap['code'];
          return LanguageCode.getByCode(code);
        } else {
          saveAppLocale(defaultLocale);
          return defaultLocale;
        }
      });

  /// APP Theme Settings
  static void saveAppTheme(ThemeColorEnum theme) => _save(MapEntry(
        _CACHE_KEY_THEME,
        HiveJsonCache(cacheMap: {'name': theme.value}, hasData: true),
      ));

  static Future<ThemeColorEnum> getAppTheme() async =>
      await _retrieve(_CACHE_KEY_LANG).then((HiveJsonCache value) {
        if (value.hasData &&
            value.cacheMap != null &&
            value.cacheMap.containsKey('name')) {
          final String name = value.cacheMap['name'];
          return ThemeColorEnum.getByValue(name);
        } else {
          saveAppTheme(ThemeInterface.theme.colorEnum);
          return ThemeInterface.theme.colorEnum;
        }
      });

  /// APP Ad Settings
  static void saveSkipAd(bool skip) => _save(MapEntry(
        _CACHE_KEY_AD,
        HiveJsonCache(cacheMap: {'skip': skip}, hasData: true),
      ));

  static Future<bool> getSkipAd() async =>
      await _retrieve(_CACHE_KEY_AD).then((HiveJsonCache value) {
        if (value.hasData &&
            value.cacheMap != null &&
            value.cacheMap.containsKey('skip')) {
          final bool skip = value.cacheMap['skip'];
          return skip;
        } else {
          saveSkipAd(false);
          return false;
        }
      });

  /// HIVE ACTIONS
  static void _save(MapEntry<String, HiveJsonCache> data) => Future.microtask(
        () => getHiveBox<HiveJsonCache>(_BOX_NAME).then(
          (box) {
            // save data
            if (box.containsKey(data.key)) {
              var _cache = box.get(data.key);
              debugPrint('cached data: $_cache');
              if (_cache != data.value) {
                _cache = data.value;
                _cache.save();
                debugPrint('updated cached data: $_cache');
              }
            } else {
              box.put(data.key, data.value);
              debugPrint('add cached data: ${data.key}');
            }
          },
        ).catchError(
            (e) => MyLogger.warn(msg: 'save cache data has error!! $e')),
      ).whenComplete(
          () => MyLogger.print(msg: 'cache data saved: ${data.key}'));

  static Future<void> _delete(String key) async => Future.microtask(
        () => getHiveBox<HiveJsonCache>(_BOX_NAME)
            .then((box) => box.delete(key))
            .catchError(
                (e) => MyLogger.warn(msg: 'save cache data has error!! $e')),
      ).whenComplete(() => MyLogger.print(msg: 'cached data deleted: $key'));

  static Future<HiveJsonCache> _retrieve(String key) async => Future.sync(
        () => getHiveBox<HiveJsonCache>(_BOX_NAME).then((box) {
          debugPrint('retrieving cache: $key');
          return box.get(key, defaultValue: HiveJsonCache(hasData: false));
        }),
      ).catchError(
          (e) => MyLogger.warn(msg: 'retrieve cache data $key has error!! $e'));
}

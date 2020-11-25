import 'package:flutter/foundation.dart' show compute, debugPrint;
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_json_cache.dart';

class AppCache {
  static void closeBox() => closeHiveBox(_BOX_NAME);

  static void save(HiveJsonCache cache, String key) =>
      compute(_save, MapEntry(key, cache));

  static void delete(String key) => compute(_delete, key);

  static Future<HiveJsonCache> retrieve(String key) => compute(_retrieve, key);
}

const String _BOX_NAME = 'HIVE_APP_CACHE';

Future<void> _save(MapEntry<String, HiveJsonCache> data) async {
  final Box<HiveJsonCache> _box = await getHiveBox(_BOX_NAME);
  // save data
  if (_box.containsKey(data.key)) {
    var _cache = _box.get(data.key);
    debugPrint('old cache data: $_cache');
    _cache = data.value;
    _cache.save();
    debugPrint('updated cache data: $_cache');
  } else {
    _box.put(data.key, data.value);
    debugPrint('new cache added: ${data.key}');
  }
}

Future<void> _delete(String key) async => getHiveBox(_BOX_NAME)
    .then((box) => box.delete(key))
    .whenComplete(() => debugPrint('cache deleted: $key'));

Future<HiveJsonCache> _retrieve(String key) =>
    getHiveBox(_BOX_NAME).then((box) {
      debugPrint('retrieving cache: $key');
      return box.get(key, defaultValue: HiveJsonCache(hasData: false));
    });

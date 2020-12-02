import 'package:flutter/foundation.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';

import 'promo_entity.dart';

abstract class PromoLocalStorage {
  void closeBox();

  /// Check the last cache time, return false if expired or no record.
  Future<bool> usePromoCache();

  /// Gets the cached [PromoEntity] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [HiveDataException] if no cached data is present.
  Future<List<PromoEntity>> getCachedPromos();

  /// Stores [PromoEntity] to [Hive]
  Future<void> cachePromos(List<PromoEntity> promoList);
}

const CACHED_BOX_PROMO = 'CACHED_PROMO';

class PromoLocalStorageImpl implements PromoLocalStorage {
  final tag = 'PromoLocalDataSource';
  final logKey = 'promo';

  Box _cacheBox;

  @override
  void closeBox() => closeHiveBox(CACHED_BOX_PROMO);

  @override
  Future<bool> usePromoCache() async {
    try {
      if (_cacheBox == null) {
        _cacheBox = await getHiveBox(Global.CACHE_APP_DATA);
      }
      final String lastCacheTime =
          _cacheBox?.get('promos-cache', defaultValue: '') ?? '';
      debugPrint('promos last cache time: $lastCacheTime');
      if (lastCacheTime.isEmpty) return false;
      return !lastCacheTime.toDatetime().isAfterHours(24);
    } catch (e) {
      MyLogger.error(
          msg: 'box get cache time has exception: $e', error: e, stackTrace: e);
      return false;
    }
  }

  @override
  Future<List<PromoEntity>> getCachedPromos() async {
    try {
      var box = await getHiveBox(CACHED_BOX_PROMO);
      return box.getData<PromoEntity>(logKeyword: logKey);
    } on HiveDataException {
      return [];
    } catch (e) {
      MyLogger.error(msg: 'box get data has exception: $e', tag: tag, error: e);
      return [];
    }
  }

  @override
  Future<void> cachePromos(List<PromoEntity> promos) async {
    if (promos.isEmpty) return;
    var box = await getHiveBox(CACHED_BOX_PROMO);
    if (box.hasData()) {
      promos.addNewToHive(box: box, identifier: logKey, filterKey: 'id');
    } else {
      promos.addAllToHive(box: box, identifier: logKey);
    }
    MyLogger.print(
        msg: 'cached promos in HIVE: ${box.values.length}', tag: tag);
    box.compact();
    return _cacheBox.put('promos-cache', getDateTime());
  }
}

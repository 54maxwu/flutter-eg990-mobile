import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/application/data/hive_actions.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/domain/core/exceptions.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';
import 'package:hive/hive.dart';

import '../entity/banner_entity.dart';
import '../entity/game_category_entity.dart';
import '../entity/game_entity.dart';
import '../entity/game_platform_entity.dart';
import '../entity/marquee_entity.dart';
import '../models/game_types.dart';

abstract class HomeLocalStorage {
  Future<void> init();
  void closeBox(HomeBox homeBox);

  /// Gets the cached [BannerEntity] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [HiveDataException] if no cached data is present.
  Future<bool> useBannerCache();
  Future<List<BannerEntity>> getCachedBanners();
  Future<void> cacheBanners(List<BannerEntity> bannersToCache);

  /// Gets the cached [MarqueeEntity] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [HiveDataException] if no cached data is present.
  Future<bool> useMarqueeCache();
  Future<List<MarqueeEntity>> getCachedMarquees();
  Future<void> cacheMarquees(List<MarqueeEntity> marqueesToCache);

  /// Gets the cached [GameTypes] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [HiveDataException] if no cached data is present.
  Future<bool> useGameTypesCache();
  Future<GameTypes> getCachedGameTypes();
  Future<void> cacheGameTypes(GameTypes typesToCache);

  /// Gets the cached [MarqueeEntity] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [HiveDataException] if no cached data is present.
  Future<bool> useGamesCache(String classname);
  Future<List<GameEntity>> getCachedGames(String classname);
  Future<void> cacheGames(List<GameEntity> gamesToCache, String classname);
}

const CACHED_HOME_BANNER = 'CACHED_BANNER';
const CACHED_HOME_MARQUEE = 'CACHED_MARQUEE';
const CACHED_HOME_GAME_CATEGORY = 'CACHED_CATEGORY';
const CACHED_HOME_GAME_PLATFORM = 'CACHED_PLATFORM';
const CACHED_HOME_GAME_GAMES = 'CACHED_GAMES';

enum HomeBox { Banner, Marquee, Category, Platform, Games, Time }

class HomeLocalStorageImpl implements HomeLocalStorage {
  final tag = 'HomeLocalStorage';
  final timeKey = 'last-check';

  Box _cacheBox;

  String _getBoxName(HomeBox homeBox, {String classname}) {
    String boxName;
    switch (homeBox) {
      case HomeBox.Banner:
        boxName = CACHED_HOME_BANNER;
        break;
      case HomeBox.Marquee:
        boxName = CACHED_HOME_MARQUEE;
        break;
      case HomeBox.Category:
        boxName = CACHED_HOME_GAME_CATEGORY;
        break;
      case HomeBox.Platform:
        boxName = CACHED_HOME_GAME_PLATFORM;
        break;
      case HomeBox.Games:
        boxName = CACHED_HOME_GAME_GAMES + classname;
        break;
      case HomeBox.Time:
        boxName = Global.CACHE_APP_DATA;
        break;
    }
    return boxName;
  }

  Future<Box> _getHiveBox(HomeBox homeBox, {String classname}) async {
    return getHiveBox(_getBoxName(homeBox, classname: classname));
  }

  @override
  Future<void> init() async => _cacheBox = await _getHiveBox(HomeBox.Time);

  @override
  void closeBox(HomeBox homeBox) => closeHiveBox(_getBoxName(homeBox));

  @override
  Future<bool> useBannerCache() async {
    try {
      if (_cacheBox == null) _cacheBox = await _getHiveBox(HomeBox.Time);
      final String lastCacheTime =
          _cacheBox?.get('banners-cache', defaultValue: '') ?? '';
      debugPrint('banners last cache time: $lastCacheTime');
      if (lastCacheTime.isEmpty) return false;
      return !lastCacheTime.toDatetime().isAfterHours(72);
    } catch (e) {
      MyLogger.error(
          msg: 'box get cache time has exception: $e', error: e, stackTrace: e);
      return false;
    }
  }

  @override
  Future<List<BannerEntity>> getCachedBanners() async {
    try {
      var box = await _getHiveBox(HomeBox.Banner);
      return box.getData<BannerEntity>(logKeyword: 'banner');
    } on HiveDataException {
      return [];
    } catch (e) {
      MyLogger.error(
          msg: 'box get data has exception: $e', error: e, stackTrace: e);
      return [];
    }
  }

  @override
  Future<void> cacheBanners(List<BannerEntity> bannersToCache) async {
    if (bannersToCache.isEmpty) return;
    var box = await _getHiveBox(HomeBox.Banner);
    if (box.hasData()) {
      bannersToCache.addNewToHive(
          box: box, identifier: 'banner', filterKey: 'id');
    } else {
      bannersToCache.addAllToHive(box: box, identifier: 'banner');
    }
    MyLogger.print(
        msg: 'cached banners in HIVE: ${box.values.length}', tag: tag);
    box.compact();
    return _cacheBox.put('banners-cache', getDateTime());
  }

  @override
  Future<bool> useMarqueeCache() async {
    try {
      if (_cacheBox == null) _cacheBox = await _getHiveBox(HomeBox.Time);
      final String lastCacheTime =
          _cacheBox?.get('marquees-cache', defaultValue: '') ?? '';
      debugPrint('marquees last cache time: $lastCacheTime');
      if (lastCacheTime.isEmpty) return false;
      return !lastCacheTime.toDatetime().isAfterHours(12);
    } catch (e) {
      MyLogger.error(
          msg: 'box get cache time has exception: $e', error: e, stackTrace: e);
      return false;
    }
  }

  @override
  Future<List<MarqueeEntity>> getCachedMarquees() async {
    try {
      var box = await _getHiveBox(HomeBox.Marquee);
      return box.getData<MarqueeEntity>(logKeyword: 'marquee');
    } on HiveDataException {
      return [];
    } catch (e) {
      MyLogger.error(
          msg: 'box get data has exception: $e', error: e, stackTrace: e);
      return [];
    }
  }

  @override
  Future<void> cacheMarquees(List<MarqueeEntity> marqueesToCache) async {
    if (marqueesToCache.isEmpty) return;
    var box = await _getHiveBox(HomeBox.Marquee);
    if (box.hasData()) {
      marqueesToCache.addNewToHive(
          box: box, identifier: 'marquee', filterKey: 'id');
    } else {
      marqueesToCache.addAllToHive(box: box, identifier: 'marquee');
    }
    MyLogger.print(
        msg: 'cached marquees in HIVE: ${box.values.length}', tag: tag);
    box.compact();
    return _cacheBox.put('marquees-cache', getDateTime());
  }

  @override
  Future<bool> useGameTypesCache() async {
    try {
      if (_cacheBox == null) _cacheBox = await _getHiveBox(HomeBox.Time);
      final String lastCacheTime =
          _cacheBox?.get('game-types-cache', defaultValue: '') ?? '';
      debugPrint('game type last cache time: $lastCacheTime');
      if (lastCacheTime.isEmpty) return false;
      return !lastCacheTime.toDatetime().isAfterHours(168);
    } catch (e) {
      MyLogger.error(
          msg: 'box get cache time has exception: $e', error: e, stackTrace: e);
      return false;
    }
  }

  @override
  Future<GameTypes> getCachedGameTypes() async {
    try {
      var box1 = await _getHiveBox(HomeBox.Category);
      final categories =
          box1.getData<GameCategoryEntity>(logKeyword: 'type-category');
      var box2 = await _getHiveBox(HomeBox.Platform);
      final platforms =
          box2.getData<GamePlatformEntity>(logKeyword: 'type-platform');
      return GameTypes(categories: categories, platforms: platforms);
    } on HiveDataException {
      return GameTypes(categories: [], platforms: []);
    } catch (e) {
      MyLogger.error(
          msg: 'box get data has exception: $e', error: e, stackTrace: e);
      return GameTypes(categories: [], platforms: []);
    }
  }

  @override
  Future<void> cacheGameTypes(GameTypes typesToCache) async {
    if (!typesToCache.isValid) return;
    var cBox = await _getHiveBox(HomeBox.Category);
    if (cBox.hasData()) {
      typesToCache.categories.addNewToHive(
          box: cBox, identifier: 'type-category', filterKey: 'id');
    } else {
      typesToCache.categories
          .addAllToHive(box: cBox, identifier: 'type-category');
    }
    cBox.compact();
    MyLogger.print(
        msg: 'cached category in HIVE: ${cBox.values.length}', tag: tag);

    var pBox = await _getHiveBox(HomeBox.Platform);
    if (pBox.hasData()) {
      typesToCache.platforms.addNewToHive(
          box: pBox, identifier: 'type-platform', filterKey: 'id');
    } else {
      typesToCache.platforms
          .addAllToHive(box: pBox, identifier: 'type-platform');
    }
    MyLogger.print(
        msg: 'cached platform in HIVE: ${pBox.values.length}', tag: tag);
    pBox.compact();
    return _cacheBox.put('game-types-cache', getDateTime());
  }

  @override
  Future<bool> useGamesCache(String classname) async {
    try {
      if (_cacheBox == null) _cacheBox = await _getHiveBox(HomeBox.Time);
      final String lastCacheTime =
          _cacheBox?.get('games-cache-$classname', defaultValue: '') ?? '';
      debugPrint('games last cache time: $lastCacheTime');
      if (lastCacheTime.isEmpty) return false;
      return !lastCacheTime.toDatetime().isAfterHours(24);
    } catch (e) {
      MyLogger.error(
          msg: 'box get cache time has exception: $e', error: e, stackTrace: e);
      return false;
    }
  }

  @override
  Future<List<GameEntity>> getCachedGames(String classname) async {
    try {
      var box = await _getHiveBox(HomeBox.Games, classname: classname);
      return box.getData<GameEntity>(logKeyword: 'games-$classname');
    } on HiveDataException {
      return [];
    } catch (e) {
      MyLogger.error(
          msg: 'box get data has exception: $e', error: e, stackTrace: e);
      return [];
    }
  }

  @override
  Future<void> cacheGames(
      List<GameEntity> gamesToCache, String classname) async {
    if (gamesToCache.isEmpty) return;
    var box = await _getHiveBox(HomeBox.Games, classname: classname);
    if (box.hasData()) {
      gamesToCache.addNewToHive(
          box: box, identifier: 'games-$classname', filterKey: 'url');
    } else {
      gamesToCache.addAllToHive(box: box, identifier: 'games-$classname');
    }
    MyLogger.print(
        msg: 'cached games-$classname in HIVE: ${box.values.length}', tag: tag);
    box.compact();
    return _cacheBox.put('games-cache-$classname', getDateTime());
  }
}

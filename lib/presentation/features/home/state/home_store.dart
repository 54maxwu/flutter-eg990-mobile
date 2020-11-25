import 'dart:collection' show HashMap;

import 'package:flutter_eg990_mobile/domain/sector/home/banner/banner_entity.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/category/game_category_entity.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/game/game_entity.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/game_types.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/home_repository.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/marquee/marquee_entity.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/platform/game_platform_entity.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

import '../form/platform_game_form.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

enum HomeStoreState { initial, loading, loaded }

abstract class _HomeStore with Store {
  final HomeRepository _repository;

  _HomeStore(this._repository);

  @observable
  ObservableFuture<List> _initFuture;

  List<BannerEntity> banners;

  List<MarqueeEntity> marquees;

  GameTypes _gameTypes;

  List<GameCategoryEntity> homeTabs;

  // Key = category
  HashMap<String, List<GamePlatformEntity>> _homePlatformMap;

  // Key = site/category
  HashMap<String, List<GameEntity>> _homeGamesMap;

  bool hasPlatformGames(String key) =>
      _homeGamesMap != null && _homeGamesMap.containsKey(key);

  List<GameEntity> getPlatformGames(String key) =>
      (_homeGamesMap.containsKey(key)) ? _homeGamesMap[key] : [];

  HashMap<String, List<GamePlatformEntity>> get homePlatformMap =>
      _homePlatformMap;

  @observable
  bool waitForGameUrl = false;

  @observable
  String gameUrl;

  bool waitForInitializeData = false;
  bool waitForBanner = false;
  bool waitForMarquee = false;
  bool waitForGameTypes = false;
//   bool waitForRecommend = false;
//   bool waitForFavorite = false;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.HOME,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  HomeStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return HomeStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending && waitForInitializeData
        ? HomeStoreState.loading
        : HomeStoreState.loaded;
  }

  @action
  Future<void> getInitializeData({bool force = false}) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForInitializeData = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      _initFuture = ObservableFuture(Future.wait([
        if (banners == null || (force && banners.isEmpty))
          Future.value(getBanners()),
        if (marquees == null || force) Future.value(getMarquees()),
        if (_gameTypes == null || force) Future.value(getGameTypes()),
      ]));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initFuture.whenComplete(() {
        waitForInitializeData = false;
        // debugPrint('banners: ${banners?.length}, '
        //     'marquees: ${marquees?.length}, '
        //     'categories: ${_gameTypes.categories}');
        // if (force) updateHomeTabs();
      });
    } on Exception {
      waitForInitializeData = false;
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> getBanners() async {
    if (waitForBanner) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForBanner = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository
          .getBanners()
          .then(
            (result) => result.fold(
              (failure) {
                setErrorMsg(msg: failure.message, showOnce: true);
                banners = [];
              },
              (list) {
//                debugPrint('home store banners: $list');
                // creates a new object list otherwise the data memory might get cleaned
                banners = List.from(list);
              },
            ),
          )
          .whenComplete(() => waitForBanner = false);
    } on Exception {
      waitForBanner = false;
      setErrorMsg(type: FailureType.BANNER);
    }
  }

  @action
  Future<void> getMarquees() async {
    if (waitForMarquee) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForMarquee = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository
          .getMarquees()
          .then(
            (result) => result.fold(
              (failure) {
                setErrorMsg(msg: failure.message, showOnce: true);
                marquees = [];
              },
              (list) {
//            debugPrint('home store marquees: $list');
                // creates a new object list otherwise the data memory might get cleaned
                if (list.isNotEmpty) {
                  // repeat the text for marquee to run anim
                  if (list.length == 1)
                    marquees = List.from(list)..addAll(list);
                  else
                    marquees = List.from(list);
                } else {
                  marquees = [];
                }
              },
            ),
          )
          .whenComplete(() => waitForMarquee = false);
    } on Exception {
      waitForMarquee = false;
      setErrorMsg(type: FailureType.MARQUEE);
    }
  }

  @action
  Future<void> getGameTypes() async {
    if (waitForGameTypes) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForGameTypes = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository
          .getGameTypes()
          .then(
            (result) => result.fold(
              (failure) {
                setErrorMsg(msg: failure.message, showOnce: true);
                homeTabs = [];
              },
              (data) {
                debugPrint('home game types: ${data.categories.length}');
                debugPrint('home game platforms: ${data.platforms.length}');
                // creates a new object list otherwise the data memory might get cleaned
                _gameTypes = data.copyWith();
                _createPlatformMap();
              },
            ),
          )
          .whenComplete(() => waitForGameTypes = false);
    } on Exception {
      waitForGameTypes = false;
      setErrorMsg(type: FailureType.GAMES, code: 1);
    }
  }

  void _createPlatformMap() {
    if (_gameTypes == null || !_gameTypes.isValid) {
      homeTabs = List();
      _homePlatformMap = HashMap();
    }

    final List<GameCategoryEntity> tabs =
        new List.from(_gameTypes.categories, growable: true);
    final HashMap<String, List<GamePlatformEntity>> platformMap = new HashMap();
    List removeList = new List();

    tabs.forEach((category) {
      // get all platforms that belongs to category
      var list = List<GamePlatformEntity>.from(_gameTypes.platforms
          .where((platform) => category.type == platform.category));
      debugPrint('mapping game category: ${category.type}');
      switch (category.type) {
        // add category to remove list if no platform
        case 'gift':
        case 'movie':
          if (list == null || list.isEmpty) removeList.add(category);
          break;
        default:
          // add platform list to map with category.type as key
          if (list == null || list.isEmpty) {
            platformMap.putIfAbsent(
                category.type, () => List<GamePlatformEntity>());
          } else {
            platformMap.putIfAbsent(category.type, () => list);
          }
          break;
      }
    });
    if (removeList.isNotEmpty) {
      removeList.forEach((element) => tabs.remove(element));
    }

    // customizePlatformMap();
    // homeTabs.add(cockfightingCategory);
    // homeTabs.add(websiteCategory);
    // homeTabs.add(aboutCategory);

    // homePlatformMap.keys
    //     .forEach((key) => debugPrint('$key: ${homePlatformMap[key]}\n'));

    homeTabs = tabs;
    _homePlatformMap = platformMap;
  }

//   void customizePlatformMap() {
//     List<String> classNames = ['s128-sport'];
//     try {
// //      debugPrint('sport platforms: ${homePlatformMap['sport'].length}');
//       var cockfightingGames = homePlatformMap['sport']
//               ?.where((element) => classNames.contains(element.className))
//               ?.toList() ??
//           [];
// //      debugPrint('found cockfighting games: ${cockfightingGames.length}');
//       homePlatformMap['sport']
//           .removeWhere((element) => classNames.contains(element.className));
//       homePlatformMap.putIfAbsent(
//           cockfightingCategory.type, () => cockfightingGames);
//     } catch (e) {
//       debugPrint(e);
//     } finally {
// //      debugPrint('updated sport platforms: ${homePlatformMap['sport'].length}');
// //      debugPrint('updated cockfighting platforms: '
// //          '${homePlatformMap[cockfightingCategory.type].length}');
//     }
//   }

  @action
  Future<List<GameEntity>> getGames(PlatformGameForm form, String key) async {
    try {
      _homeGamesMap ??= new HashMap();
      if (_homeGamesMap.containsKey(key)) {
        return _homeGamesMap[key] ?? [];
      }
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      debugPrint('requesting home platform games: $form');
      return await _repository.getGames(form).then(
            (result) => result.fold(
              (failure) {
                setErrorMsg(msg: failure.message, showOnce: true);
                return _homeGamesMap[key] = [];
              },
              (list) {
                debugPrint('home store platform games: $list');
                _homeGamesMap[key] = new List.from(list);
                return _homeGamesMap[key];
              },
            ),
          );
    } on Exception {
      setErrorMsg(type: FailureType.GAMES, code: 2);
      return _homeGamesMap[key] = [];
    }
  }

//   void searchGame({String searchKey, bool clear = false}) {
//     if (clear) {
//       _searchGameController.sink.add('');
//     } else if (searchKey != null) {
//       _searchGameController.sink.add(searchKey);
//     }
//   }
//
  @action
  Future<void> getGameUrl(String param) async {
    if (waitForGameUrl) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      gameUrl = null;
      waitForGameUrl = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      debugPrint('requesting home game url: $param');
      await _repository
          .getGameUrl(param)
          .then(
            (result) => result.fold(
              (failure) => setErrorMsg(msg: failure.message),
              (data) {
                debugPrint('home store game url: $data');
                gameUrl = data;
              },
            ),
          )
          .whenComplete(() => waitForGameUrl = false);
    } on Exception {
      waitForGameUrl = false;
      setErrorMsg(type: FailureType.GAMES, code: 3);
    }
  }

  void clearGameUrl() => gameUrl = null;

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _repository.closeHiveBox(),
      ]);
    } catch (e) {
      MyLogger.warn(msg: 'close home stream error', error: e, tag: 'HomeStore');
      return null;
    }
  }
}

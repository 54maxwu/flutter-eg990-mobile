import 'dart:collection' show HashMap;

import 'package:flutter_ty_mobile/core/mobx_store_export.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/home/data/entity/banner_entity.dart';
import 'package:flutter_ty_mobile/features/home/data/entity/game_entity.dart';
import 'package:flutter_ty_mobile/features/home/data/entity/marquee_entity.dart';
import 'package:flutter_ty_mobile/features/home/data/form/platform_game_form.dart';
import 'package:flutter_ty_mobile/features/home/data/models/game_category_model.dart';
import 'package:flutter_ty_mobile/features/home/data/models/game_platform.dart';
import 'package:flutter_ty_mobile/features/home/data/models/game_types.dart';
import 'package:flutter_ty_mobile/features/home/data/repository/home_repository.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/user_entity.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

enum HomeStoreState { initial, loading, loaded }

abstract class _HomeStore with Store {
  final HomeRepository _repository;

  final StreamController<String> _creditController =
      StreamController<String>.broadcast();
  static StreamController<List<BannerEntity>> _bannerController =
      StreamController<List<BannerEntity>>.broadcast();
  static StreamController<List<MarqueeEntity>> _marqueeController =
      StreamController<List<MarqueeEntity>>.broadcast();
  static StreamController<List<GameCategoryModel>> _tabController =
      StreamController<List<GameCategoryModel>>.broadcast();
  static StreamController<String> _gamesRetrieveController =
      StreamController<String>.broadcast();
  static StreamController<List> _recommendController =
      StreamController<List>.broadcast();
  static StreamController<List> _favoriteController =
      StreamController<List>.broadcast();
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();

  _HomeStore(this._repository) {
    print('init home store');
    _creditController.stream.listen((event) {
//      print('home stream credit: $event');
      userCredit = event;
    });
    _bannerController.stream.listen((event) {
//      print('home stream banners: ${event.length}');
      banners = event;
    });
    _marqueeController.stream.listen((event) {
//      print('home stream marquees: ${event.length}');
      marquees = event;
    });
//    _tabController.stream.listen((event) {
//      print('home stream games tab: ${event.length}');
//    });
    _gamesRetrieveController.stream.listen((event) {
      print('home stream games retrieve: $event');
    });
    _recommendController.stream.listen((event) {
//      print('home stream games recommend: ${event.length}');
      recommends = event;
    });
    _favoriteController.stream.listen((event) {
//      print('home stream games favorite: ${event.length}');
      favorites = event
        ..removeWhere(
          (element) => (element is GameEntity || element is GamePlatformEntity)
              ? element.favorite != 1 && element.favorite != '1'
              : false,
        );
    });
    _searchController.stream.listen((event) {
//      print('home stream search recommend: $event');
      searchPlatform = event;
    });
  }

  @observable
  ObservableFuture<List> _initFuture;

  Stream<List<BannerEntity>> get bannerStream => _bannerController.stream;

  Stream<List<MarqueeEntity>> get marqueeStream => _marqueeController.stream;

  Stream<List<GameCategoryModel>> get tabStream => _tabController.stream;

  Stream<String> get gamesStream => _gamesRetrieveController.stream;

  Stream<List> get recommendStream => _recommendController.stream;

  Stream<List> get favoriteStream => _favoriteController.stream;

  Stream<String> get showPlatformStream => _searchController.stream;

  List<BannerEntity> banners;

  List<MarqueeEntity> marquees;

  GameTypes _gameTypes;

  List<GameCategoryModel> homeTabs;

  List recommends;

  List favorites;

  String searchPlatform = '';

  // Key = category
  HashMap<String, List<GamePlatformEntity>> homePlatformMap;

  // Key = site/category
  HashMap<String, List<GameEntity>> _homeGamesMap;

  bool hasPlatformGames(String key) =>
      _homeGamesMap != null && _homeGamesMap.containsKey(key);

  List<GameEntity> getPlatformGames(String key) =>
      (_homeGamesMap.containsKey(key)) ? _homeGamesMap[key] : [];

  void showSearchPlatform(String platformClassName) {
    _searchController.sink.add(platformClassName);
  }

  void clearSearch() {
    searchPlatform = '';
  }

  @observable
  bool waitForGameUrl = false;

  @observable
  String gameUrl;

  @observable
  String errorMessage;

  Stream<String> get creditStream =>
      _creditController.stream.asBroadcastStream();

  String userCredit = '0';

  bool hasUser = false;

  bool waitForInitializeData = false;
  bool waitForBanner = false;
  bool waitForMarquee = false;
  bool waitForGameTypes = false;
  bool waitForRecommend = false;
  bool waitForFavorite = false;

  @computed
  HomeStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return HomeStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? HomeStoreState.loading
        : HomeStoreState.loaded;
  }

  @action
  Future getInitializeData() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForInitializeData = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      _initFuture = ObservableFuture(Future.wait([
        if (banners == null) Future.value(getBanners()),
        if (marquees == null) Future.value(getMarquees()),
        if (_gameTypes == null) Future.value(getGameTypes()),
      ]));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initFuture.whenComplete(() => waitForInitializeData = false);
    } on Exception {
      waitForInitializeData = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.HOME)).message;
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
      print('requesting home banner data...');
      await _repository
          .getBanners()
          .then(
            (result) => result.fold(
              (failure) {
                errorMessage = failure.message;
                _bannerController.sink.add([]);
              },
              (list) {
//                print('home store banners: $list');
                // creates a new list then add to stream
                // otherwise the data will lost after navigate
                _bannerController.sink.add(List.from(list));
              },
            ),
          )
          .whenComplete(() => waitForBanner = false);
    } on Exception {
      waitForBanner = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.BANNER)).message;
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
      print('requesting home marquee data...');
      await _repository
          .getMarquees()
          .then(
            (result) => result.fold(
              (failure) {
                errorMessage = failure.message;
                _marqueeController.sink.add([]);
              },
              (list) {
//            print('home store marquees: $list');
                // creates a new list then add to stream
                // otherwise the data will lost after navigate
                _marqueeController.sink.add(List.from(list));
              },
            ),
          )
          .whenComplete(() => waitForMarquee = false);
    } on Exception {
      waitForMarquee = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.MARQUEE)).message;
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
      print('requesting home game types data...');
      await _repository
          .getGameTypes()
          .then(
            (result) => result.fold(
              (failure) {
                errorMessage = failure.message;
                _tabController.sink.add([]);
              },
              (data) {
//                print('home store game types: $data');
                print('home stream game types: ${data.categories.length}');
                print('home stream game platforms: ${data.platforms.length}');
                // creates a new data instance then add to stream
                // otherwise the data will lost after navigate
                _gameTypes = new GameTypes(
                  categories: new List.from(data.categories),
                  platforms: new List.from(data.platforms),
                );
                _processHomeContent();
              },
            ),
          )
          .whenComplete(() => waitForGameTypes = false);
    } on Exception {
      waitForGameTypes = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.GAMES)).message;
    }
  }

  @computed
  List<GameCategoryModel> get homeUserTabs =>
      new List.from([recommendCategory, favoriteCategory] + homeTabs
//           + [movieEgCategory, movieNewCategory],
          );

  void _processHomeContent() {
    homeTabs = new List.from(_gameTypes.categories, growable: true);
    if (homeTabs == null || homeTabs.isEmpty) return;
    final all = _gameTypes.platforms;
    List remove = new List();
    homePlatformMap = new HashMap();
    homeTabs.forEach((category) {
      var list = List<GamePlatformEntity>.from(
          all.where((platform) => category.type == platform.category));
      switch (category.type) {
        case 'gift':
        case 'movie':
          if (list == null || list.isEmpty) remove.add(category);
          break;
        default:
          if (list == null || list.isEmpty)
            homePlatformMap.putIfAbsent(
                category.type, () => List<GamePlatformEntity>());
          else
            homePlatformMap.putIfAbsent(category.type, () => list);
          break;
      }
    });
    if (remove.isNotEmpty)
      remove.forEach((element) => homeTabs.remove(element));

//    homePlatformMap.keys.forEach((key) => MyLogger.print(
//        msg: '$key: ${homePlatformMap[key]}\n', tag: 'HomePlatformMap'));

    checkHomeTabs();
  }

  void checkHomeTabs() {
    if (hasUser != getRouteUserStreams.hasUser) {
      hasUser = getRouteUserStreams.hasUser;
      _creditController.sink.add(getRouteUserStreams.userCredit);
//      print('home store has user = $hasUser');
      getGameTypes();
    }
    if (hasUser) {
      _tabController.sink.add(homeUserTabs);
    } else {
      _tabController.sink.add(homeTabs);
    }
  }

  @action
  Future<void> getGames(PlatformGameForm form, String key) async {
    try {
      _homeGamesMap ??= new HashMap();
      if (_homeGamesMap.containsKey(key)) {
        _gamesRetrieveController.sink.add(key);
        return;
      }
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      print('requesting home platform games: $form');
      await _repository.getGames(form).then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (list) {
                print('home store platform games: $list');
                _homeGamesMap[key] = new List.from(list);
                _gamesRetrieveController.sink.add(key);
              },
            ),
          );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.GAMES)).message;
    }
  }

  @action
  Future<void> getRecommend() async {
    if (waitForRecommend) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForRecommend = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      print('requesting home recommend data...');
      await _repository
          .getRecommend()
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (list) {
//                print('home store game recommend: $list');
                // creates a new data instance then add to stream
                // otherwise the data will lost after navigate
                if (recommends != list)
                  _recommendController.sink.add(List.from(list));
              },
            ),
          )
          .whenComplete(() => waitForRecommend = false);
    } on Exception {
      waitForRecommend = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.RECOMMENDS)).message;
    }
  }

  @action
  Future<void> getFavorites() async {
    if (waitForFavorite) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForFavorite = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      print('requesting home favorite data...');
      await _repository
          .getFavorites()
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (list) {
                print('home store game favorite: $list');
                // creates a new data instance then add to stream
                // otherwise the data will lost after navigate
                if (list != favorites)
                  _favoriteController.sink.add(List.from(list));
              },
            ),
          )
          .whenComplete(() => waitForFavorite = false);
    } on Exception {
      waitForFavorite = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.FAVORITE)).message;
    }
  }

  @action
  Future<void> postFavorite({
    @required dynamic entity,
    @required bool favorite,
  }) async {
    try {
      bool isPlatform = entity is GamePlatformEntity;
      int id = entity.id;
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      print('posting home favorite: $entity');
      if (isPlatform)
        await _repository.postFavoritePlatform(id, favorite).then(
              (result) => result.fold(
                (failure) => MyLogger.warn(
                    msg: 'set platform $id favorite failed: $failure'),
                (success) {
                  MyLogger.log(
                      msg: 'set platform $id favorite($favorite) success');
                  _updatePlatformMap(entity, favorite);
                },
              ),
            );
      else
        await _repository.postFavoriteGame(id, favorite).then(
              (result) => result.fold(
                (failure) => MyLogger.warn(
                    msg: 'set game $id favorite failed: $failure'),
                (success) {
                  MyLogger.log(msg: 'set game $id favorite($favorite) success');
                  _updateGameMap(entity, favorite);
                },
              ),
            );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.FAVORITE)).message;
    }
  }

  void _updatePlatformMap(GamePlatformEntity entity, bool isFavorite) {
    if (favorites != null) getFavorites();
    final newItem = entity.copyWith(favorite: (isFavorite) ? '1' : '0');
    try {
      String key = entity.category;
//      print('platforms: ${homePlatformMap[key]}');
//      print('looking for $entity in ${homePlatformMap[key]}');
      int index = homePlatformMap[key].indexOf(entity);
//      print('platform index: $index');
      if (index >= 0) {
        homePlatformMap[key][index] = newItem;
        print('updated platform map item: ${homePlatformMap[key][index]}');
      }
    } catch (e) {
      MyLogger.warn(
          msg: 'update platform map (${entity.category}) failed: $e',
          tag: 'HomeStore');
//      getGameTypes();
    }

    if (recommends != null && recommends.isNotEmpty) {
      try {
//        print('looking for $entity in $recommends');
//        print('recommend has platform: ${recommends.contains(entity)}');
        final item = recommends.singleWhere(
          (element) =>
              element is GamePlatformEntity &&
              element.id == entity.id &&
              element.className == entity.className,
          orElse: null,
        );
        if (item == null) return;
        int rIndex = recommends.indexOf(item);
        recommends[rIndex] = newItem;
        print('updated recommend list item: ${recommends[rIndex]}');
      } catch (e) {
        MyLogger.warn(
            msg: 'update recommend platform failed: $e', tag: 'HomeStore');
        getRecommend();
      }
    }
  }

  void _updateGameMap(GameEntity entity, bool isFavorite) {
    if (favorites != null) getFavorites();
    final newItem = entity.copyWith(favorite: (isFavorite) ? 1 : 0);
    List info = entity.gameUrl.split('/');
    String key = '${info[0]}/${info[1]}';
    print('game map key: $key');

    if (_homeGamesMap != null && _homeGamesMap.containsKey(key)) {
      try {
        int index = _homeGamesMap[key].indexOf(entity);
        _homeGamesMap[key][index] = newItem;
        print('updated game map item: ${_homeGamesMap[key][index]}');
      } catch (e) {
        MyLogger.warn(
            msg: 'update game map ($key) failed: $e', tag: 'HomeStore');
        getGames(
            PlatformGameForm(
              category: info[1],
              platform: info[0],
            ),
            key);
      }
    }

    if (recommends != null && recommends.isNotEmpty) {
      try {
//        print('looking for $entity in $recommends');
//        print('recommend has game: ${recommends.contains(entity)}');
        final item = recommends.singleWhere(
          (element) =>
              element is GameEntity &&
              element.id == entity.id &&
              element.gameUrl == entity.gameUrl,
          orElse: null,
        );
        if (item == null) return;
        int rIndex = recommends.indexOf(item);
        recommends[rIndex] = newItem;
        print('updated recommend list item: ${recommends[rIndex]}');
      } catch (e) {
        MyLogger.warn(
            msg: 'update recommend game failed: $e', tag: 'HomeStore');
        getRecommend();
      }
    }
  }

  @action
  Future<void> getGameUrl(String param) async {
    if (waitForGameUrl) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      gameUrl = null;
      waitForGameUrl = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      print('requesting home game url: $param');
      await _repository
          .getGameUrl(param)
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (data) {
                print('home store game url: $data');
                gameUrl = data;
              },
            ),
          )
          .whenComplete(() => waitForGameUrl = false);
    } on Exception {
      waitForGameUrl = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.GAMES)).message;
    }
  }

  void clearGameUrl() => gameUrl = null;

  @action
  Future<void> getCredit() async {
    try {
      if (!hasUser) return;
      print('requesting home page user credit...');
      var user = getRouteUserStreams.lastStatus.currentUser;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.updateCredit(user.account).then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (value) {
                getRouteUserStreams.lastStatus.currentUser.updateCredit(value);
                _creditController.sink.add(value);
              },
            ),
          );
    } on Exception catch (e) {
      MyLogger.error(msg: 'home user credit has exception', error: e);
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _creditController.close(),
        _bannerController.close(),
        _marqueeController.close(),
        _tabController.close(),
        _recommendController.close(),
        _favoriteController.close(),
        _searchController.close(),
        _gamesRetrieveController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(msg: 'close home stream error', error: e, tag: 'HomeStore');
      return null;
    }
  }
}

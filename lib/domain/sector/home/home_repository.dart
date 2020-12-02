import 'dart:io' show Cookie;

import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/form/platform_game_form.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import 'banner/banner_entity.dart';
import 'banner/banner_model.dart';
import 'category/game_category_entity.dart';
import 'game/game_entity.dart';
import 'game/game_model.dart';
import 'game_types.dart';
import 'home_local_storage.dart';
import 'marquee/marquee_entity.dart';
import 'marquee/marquee_model.dart';
import 'marquee/marquee_model_list.dart';

class HomeApi {
  static const String BANNER = "api/banner";
  static const String MARQUEE = "api/marquee";
  static const String GAME_ALL = "api/getAll";
  static const String GAME_RECOMMEND = "api/getRecommend";
  static const String GAME_FAVORITE = "api/getallfavorite";
  static const String GAME_OPEN = "api/open/";
  static const String GAME_URL = "api/openUrl/";
  static const String POST_FAVORITE_PLATFORM = "api/setfavoriteplatform";
  static const String POST_FAVORITE_GAME = "api/setfavorite";

  /// Post with data PlatformGameForm
  static const String LOGIN = "api/login";
  static const String GAME_INDEX = "api/getindexGame";
}

abstract class HomeRepository {
  Future<void> closeHiveBox();

  Future<Either<Failure, List<BannerEntity>>> getBanners();

  Future<Either<Failure, List<MarqueeEntity>>> getMarquees();

  Future<Either<Failure, GameTypes>> getGameTypes();

  Future<Either<Failure, List<GameEntity>>> getGames(PlatformGameForm form);

  Future<Either<Failure, String>> getGameUrl(String requestUrl);
}

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final DioApiService dioApiService;
  final HomeLocalStorage localStorage;
  final JwtInterface jwtInterface;
  final tag = 'HomeRepository';

  HomeRepositoryImpl({
    @required this.networkInfo,
    @required this.dioApiService,
    @required this.localStorage,
    @required this.jwtInterface,
  });

  @override
  Future<void> closeHiveBox() async {
    localStorage.closeBox(HomeBox.Banner);
    localStorage.closeBox(HomeBox.Marquee);
    localStorage.closeBox(HomeBox.Category);
    localStorage.closeBox(HomeBox.Platform);
  }

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners() async {
    final connected = await networkInfo.isConnected;
    final useCache = await localStorage.useBannerCache();
    debugPrint('use banners cache: $useCache');
    if (!connected || useCache) {
      // Future.microtask(() => _remoteBanners()).whenComplete(
      //     () => MyLogger.debug(msg: 'banners cache updated', tag: tag));
      return _getCachedBanners();
    }
    return _remoteBanners();
  }

  Future<Either<Failure, List<BannerEntity>>> _getCachedBanners() async {
    // debugPrint('accessing banner local data source...');
    var cached = await localStorage.getCachedBanners();
    // debugPrint('banner data from cached: $cached');
    return (cached.isNotEmpty) ? Right(cached) : await _remoteBanners();
  }

  Future<Either<Failure, List<BannerEntity>>> _remoteBanners() async {
    final result = await requestModelList<BannerModel>(
      request: dioApiService.get(HomeApi.BANNER),
      parseJson: BannerModel.jsonToBannerModel,
      tag: 'remote-BANNER',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (models) {
        final list = models.map((model) => model.entity).toList();
        localStorage.cacheBanners(list);
        return Right(list);
      },
    );
  }

  @override
  Future<Either<Failure, List<MarqueeEntity>>> getMarquees() async {
    final connected = await networkInfo.isConnected;
    final useCache = await localStorage.useMarqueeCache();
    debugPrint('use marquees cache: $useCache');
    if (!connected || useCache) {
      // Future.microtask(() => _remoteMarquees()).whenComplete(
      //     () => MyLogger.debug(msg: 'marquees cache updated', tag: tag));
      return _getCachedMarquees();
    }
    return _remoteMarquees();
  }

  Future<Either<Failure, List<MarqueeEntity>>> _getCachedMarquees() async {
    // debugPrint('accessing marquee local data source...');
    var cached = await localStorage.getCachedMarquees();
//      debugPrint('marquee data from cached: $cached');
    return (cached.isNotEmpty) ? Right(cached) : await _remoteMarquees();
  }

  Future<Either<Failure, List<MarqueeEntity>>> _remoteMarquees() async {
    final result = await requestModel<MarqueeModelList>(
      request: dioApiService.get(HomeApi.MARQUEE),
      parseJson: MarqueeModelList.parseJsonList,
      tag: 'remote-MARQUEE',
    );
    // debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        final list = model.marquees.map((model) => model.entity).toList();
        localStorage.cacheMarquees(list);
        return Right(list);
      },
    );
  }

  @override
  Future<Either<Failure, GameTypes>> getGameTypes() async {
    final connected = await networkInfo.isConnected;
    final useCache = await localStorage.useGameTypesCache();
    debugPrint('use game type cache: $useCache');
    if (!connected || useCache) {
      // Future.microtask(() => _remoteGameTypes()).whenComplete(
      //     () => MyLogger.debug(msg: 'game-types cache updated', tag: tag));
      return _getCachedGameTypes();
    }
    return _remoteGameTypes();
  }

  Future<Either<Failure, GameTypes>> _getCachedGameTypes() async {
    // debugPrint('accessing game-types local data source...');
    final cached = await localStorage.getCachedGameTypes();
    if (cached == null ||
        cached.categories.isEmpty ||
        cached.platforms.isEmpty) {
      return Left(Failure.network());
    }
    // debugPrint('game-types from cached source: $cached');
    final updatedCategories =
        cached.categories.map((e) => e.copyWith(info: e.getCategory)).toList();
    return Right(GameTypes(
      categories: updatedCategories ?? [],
      platforms: cached.platforms ?? [],
    ));
  }

  Future<Either<Failure, GameTypes>> _remoteGameTypes() async {
    final result = await requestModel<GameTypes>(
      request: dioApiService.get(
        HomeApi.GAME_ALL,
        data: {
          "accountid": jwtInterface.userId,
        },
      ),
      parseJson: GameTypes.jsonToGameTypes,
      tag: 'remote-GAME_ALL',
    );
    // debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        localStorage.cacheGameTypes(data);
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<GameEntity>>> getGames(
    PlatformGameForm form,
  ) async {
    final connected = await networkInfo.isConnected;
    final useCache = await localStorage.useGamesCache(form.classname);
    debugPrint('use game ${form.classname} cache: $useCache');
    if (!connected || useCache) {
      // Future.microtask(() => _remoteGames(form)).whenComplete(
      //     () => MyLogger.debug(msg: 'game ${form.classname} cache updated', tag: tag));
      return _getCachedGames(form);
    }
    return _remoteGames(form);
  }

  Future<Either<Failure, List<GameEntity>>> _getCachedGames(
      PlatformGameForm form) async {
    // debugPrint('accessing games local data source...');
    var cached = await localStorage.getCachedGames(form.classname);
//      debugPrint('games data from cache: $cached');
    return (cached.isNotEmpty) ? Right(cached) : await _remoteGames(form);
  }

  Future<Either<Failure, List<GameEntity>>> _remoteGames(
      PlatformGameForm form) async {
    final result = await requestModelList<GameModel>(
      request: dioApiService.postForm(HomeApi.GAME_INDEX, form.toJson()),
      parseJson: GameModel.jsonToGameModel,
      tag: 'remote-GAMES',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        final list = model.map((model) => model.entity).toList();
        localStorage.cacheGames(list, form.classname);
        return Right(list);
      },
    );
  }

  @override
  Future<Either<Failure, String>> getGameUrl(String requestUrl) async {
    if (requestUrl == null || requestUrl.isEmpty) {
      MyLogger.error(msg: 'game url is empty', tag: tag);
      return Left(Failure.internal(FailureCode(type: FailureType.GAME_URL)));
    }

    final connected = await networkInfo.isConnected;
    if (!connected) return Left(Failure.network());

    List<Cookie> cookies = DioApiService.loadCookies(
        Uri.parse('${Global.CURRENT_BASE}${HomeApi.LOGIN}'));
    debugPrint('Cookies: $cookies');

    Map<String, dynamic> headers = new Map();
    cookies.forEach((element) {
      headers[element.name] = element.value;
      if (element.name == 'token_mobile')
        headers.putIfAbsent('JWT-TOKEN', () => element.value);
    });
    debugPrint('Mapped Cookies: $headers');

    final result = await requestDataString(
      request: dioApiService.get(
        '${HomeApi.GAME_URL}$requestUrl',
        headers: headers,
      ),
      tag: 'remote-GAME_URL',
    );

    return result.fold(
      (failure) => Left(failure),
      (data) =>
          (data.isUrl) ? Right(data) : Left(Failure.errorMessage(msg: data)),
    );
  }
//
//  @override
//  Future<Either<Failure, List>> getRecommend() async {
//    final connected = await networkInfo.isConnected;
//    if (!connected) return Left(Failure.network());
//
//    final result = await requestData(
//      request: dioApiService.post(
//        HomeApi.GAME_RECOMMEND,
//        data: {
//          'accountid': jwtInterface.accountId,
//        },
//      ),
//      tag: 'remote-RECOMMEND',
//    );
////    debugPrint('test response type: ${result.runtimeType}, data: $result');
//    return result.fold(
//      (failure) => Left(failure),
//      (data) {
//        debugPrint('check recommend data type: ${data.runtimeType}');
//        if (data is List) return Right(_decodeMixedData(data));
//        if (data is String && data.startsWith('[') && data.endsWith(']'))
//          return Right(_decodeMixedData(jsonDecode(data)));
//        return Left(Failure.jsonFormat());
//      },
//    );
//  }
//
//  List _decodeMixedData(List data) {
//    if (data == null || data.isEmpty) return [];
//    List decodedList = data.map((map) {
//      try {
//        if (map.containsKey('platform'))
//          return GameModel.jsonToGameModel(map).entity;
//        else if (map.containsKey('site'))
//          return GamePlatform.jsonToGamePlatformEntity(map);
//        else
//          return '';
//      } catch (e) {
//        return '';
//      }
//    }).toList();
//    decodedList.removeWhere((element) => element == '');
////    debugPrint('decoded recommend games: $decodedList');
//    return decodedList;
//  }
//
//  @override
//  Future<Either<Failure, List>> getFavorites() async {
//    final connected = await networkInfo.isConnected;
//    if (!connected) return Left(Failure.network());
//
//    final result = await requestData(
//      request: dioApiService.post(
//        HomeApi.GAME_FAVORITE,
//        data: {
//          'accountid': jwtInterface.accountId,
//        },
//      ),
//      tag: 'remote-FAVORITE',
//    );
////    debugPrint('test response type: ${result.runtimeType}, data: $result');
//    return result.fold(
//      (failure) => Left(failure),
//      (data) {
//        debugPrint('check favorite data type: ${data.runtimeType}');
//        Map map = new Map();
//        if (data is Map)
//          map = data;
//        else if (data is String)
//          map = jsonDecode(data);
//        else
//          return Left(Failure.jsonFormat());
//
//        List dataList = new List();
//        map.forEach((key, value) {
////            debugPrint('$key data is List: ${value is List}');
//          if (value is List)
//            dataList.addAll(value);
//          else
//            MyLogger.warn(
//              msg: 'data type error, $key data is ${value.runtimeType}',
//              tag: tag,
//            );
//        });
//        return Right(_decodeMixedData(dataList));
//      },
//    );
//  }
//
//  @override
//  Future<Either<Failure, bool>> postFavoritePlatform(
//    int id,
//    bool favorite,
//  ) async {
//    final connected = await networkInfo.isConnected;
//    if (!connected) return Left(Failure.network());
//
//    final result = await requestData(
//      request: dioApiService.post(
//        HomeApi.POST_FAVORITE_PLATFORM,
//        data: {
//          'accountid': jwtInterface.accountId,
//          'id': id,
//          'status': (favorite) ? '1' : '0',
//        },
//      ),
//      tag: 'remote-FAVORITE',
//    );
////    debugPrint('test response type: ${result.runtimeType}, data: $result');
//    return result.fold(
//      (failure) => Left(failure),
//      (data) {
//        if (data is String)
//          return Right(data == '1' || data == 'true');
//        else if (data is bool)
//          return Right(data);
//        else if (data is int)
//          return Right(data == 1);
//        else
//          return Left(Failure.dataType());
//      },
//    );
//  }
//
//  @override
//  Future<Either<Failure, bool>> postFavoriteGame(int id, bool favorite) async {
//    final connected = await networkInfo.isConnected;
//    if (!connected) return Left(Failure.network());
//
//    final result = await requestData(
//      request: dioApiService.post(
//        HomeApi.POST_FAVORITE_GAME,
//        data: {
//          'accountid': jwtInterface.accountId,
//          'gameid': id,
//          'status': (favorite) ? '1' : '0',
//        },
//      ),
//      tag: 'remote-FAVORITE',
//    );
////    debugPrint('test response type: ${result.runtimeType}, data: $result');
//    return result.fold(
//      (failure) => Left(failure),
//      (data) {
//        if (data is String)
//          return Right(data == '1' || data == 'true');
//        else if (data is bool)
//          return Right(data);
//        else if (data is int)
//          return Right(data == 1);
//        else
//          return Left(Failure.dataType());
//      },
//    );
//  }
}

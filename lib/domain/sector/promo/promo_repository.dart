import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

import 'promo_entity.dart';
import 'promo_local_storage.dart';
import 'promo_model.dart';

class PromoApi {
  static const String GET_PROMO = "api/promo";
}

abstract class PromoRepository {
  Future<Either<Failure, List<PromoEntity>>> getPromos();
}

class PromoRepositoryImpl implements PromoRepository {
  final DioApiService dioApiService;
  final NetworkInfo networkInfo;
  final PromoLocalStorage localStorage;
  final tag = 'PromoRepository';

  PromoRepositoryImpl({
    @required this.dioApiService,
    @required this.networkInfo,
    @required this.localStorage,
  });

  @override
  Future<Either<Failure, List<PromoEntity>>> getPromos() async {
    final connected = await networkInfo.isConnected;
    final useCache = await localStorage.usePromoCache();
    debugPrint('use promos cache: $useCache');
    if (!connected || useCache) {
      // Future.microtask(() => _remotePromos()).whenComplete(
      //     () => MyLogger.debug(msg: 'promos cache updated', tag: tag));
      return _getCachedPromos();
    }
    return _remotePromos();
  }

  Future<Either<Failure, List<PromoEntity>>> _getCachedPromos() async {
    // debugPrint('accessing marquee local data source...');
    var cached = await localStorage.getCachedPromos();
//      debugPrint('data from cached source: $cached');
    if (cached.isNotEmpty)
      return Right(cached);
    else
      return Left(Failure.network());
  }

  Future<Either<Failure, List<PromoEntity>>> _remotePromos() async {
    final result = await requestModelList<PromoModel>(
      request: dioApiService.get(PromoApi.GET_PROMO),
      parseJson: PromoModel.parseJson,
      tag: 'remote-PROMO',
    );
//      print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (models) {
        final list = models.map((model) => model.entity).toList();
        localStorage.cachePromos(list);
        return Right(list);
      },
    );
  }
}

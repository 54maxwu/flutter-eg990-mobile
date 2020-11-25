import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

import 'ad_model.dart';

class AdsApi {
  static const String AD = "api/getAd";
}

abstract class AdsRepository {
  Future<Either<Failure, List<AdModel>>> getAds();
}

class AdsRepositoryImpl implements AdsRepository {
  final DioApiService dioApiService;
  final tag = 'AdsRepository';

  AdsRepositoryImpl({@required this.dioApiService});

  @override
  Future<Either<Failure, List<AdModel>>> getAds() async {
    final result = await requestModelList<AdModel>(
      request: dioApiService.get(AdsApi.AD),
      jsonToModel: AdModel.jsonToAdModel,
      tag: 'remote-Ads_AD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models),
    );
  }
}

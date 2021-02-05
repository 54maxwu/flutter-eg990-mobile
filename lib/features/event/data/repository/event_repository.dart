import 'package:flutter_eg990_mobile/core/repository_export.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/service/data/model/service_model.dart';

import '../models/ad_model.dart';

class EventApi {
  static const String GET_WEB_LIST = "api/websiteList";
  static const String AD = "api/getAd";
  static const String POST_SIGN = "api/memSign";

  static const String GET_NEW_MESSAGE_COUNT = 'api/stationCount';
}

abstract class EventRepository {
  Future<Either<Failure, ServiceModel>> getWebsiteList();

  Future<Either<Failure, List<AdModel>>> getAds();

  Future<Either<Failure, bool>> checkNewMessage();
}

class EventRepositoryImpl implements EventRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'EventRepository';

  EventRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, bool>> checkNewMessage() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(EventApi.GET_NEW_MESSAGE_COUNT),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-EVENT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Right(false);
        Map<String, dynamic> data = model.data;
        if (data != null && data.containsKey('count') && data['count'] > 0)
          return Right(true);
        else
          return Right(false);
      },
    );
  }

  @override
  Future<Either<Failure, List<AdModel>>> getAds() async {
    final result = await requestModelList<AdModel>(
      request: dioApiService.get(EventApi.AD),
      jsonToModel: AdModel.jsonToAdModel,
      tag: 'remote-EVENT_AD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models),
    );
  }

  @override
  Future<Either<Failure, ServiceModel>> getWebsiteList() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(EventApi.GET_WEB_LIST),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-EVENT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Left(Failure.event());
        if (model.data != null && model.data is Map) {
          return Right(ServiceModel.jsonToServiceModel(model.data));
        }
        return Left(Failure.dataType());
      },
    );
  }
}

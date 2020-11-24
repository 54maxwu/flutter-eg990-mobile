import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

import '../models/ad_model.dart';
import '../models/event_model.dart';

class EventApi {
  static const String AD = "api/getAd";
  static const String GET_EVENT = "api/showActive";
  static const String POST_SIGN = "api/memSign";
}

abstract class EventRepository {
  Future<Either<Failure, List<AdModel>>> getAds();

  Future<Either<Failure, EventModel>> getEvent();

  Future<Either<Failure, RequestCodeModel>> signEvent(int eventId, int prize);
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
  Future<Either<Failure, EventModel>> getEvent() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(EventApi.GET_EVENT),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-EVENT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Left(Failure.event());
        if (model.data != null)
          return Right(EventModel.jsonToEventModel(model.data));
        else
          return Right(EventModel(hasData: false));
      },
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> signEvent(
      int eventId, int prize) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        EventApi.POST_SIGN,
        data: {'aid': eventId, 'prize': prize},
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-EVENT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}
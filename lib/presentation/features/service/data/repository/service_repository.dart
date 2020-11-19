import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';
import 'package:flutter_eg990_mobile/presentation/features/service/data/model/service_model.dart';

class ServiceApi {
  static const String GET_WEB_LIST = "api/websiteList";
}

abstract class ServiceRepository {
  Future<Either<Failure, ServiceModel>> getWebsiteList();
}

class ServiceRepositoryImpl implements ServiceRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'ServiceRepository';

  ServiceRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, ServiceModel>> getWebsiteList() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(ServiceApi.GET_WEB_LIST),
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

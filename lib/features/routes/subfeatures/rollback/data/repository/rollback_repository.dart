import 'package:flutter_eg990_mobile/core/repository_export.dart';

import '../models/rollback_model.dart';

class RollbackApi {
  static const String GET_RECORD = "api/rollback";
}

abstract class RollbackRepository {
  Future<Either<Failure, List<RollbackModel>>> getDataModel(int page);
}

class RollbackRepositoryImpl implements RollbackRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'RollbackRepository';

  RollbackRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, List<RollbackModel>>> getDataModel(int page) async {
    final result = await requestModelList<RollbackModel>(
      request: dioApiService.get(RollbackApi.GET_RECORD),
      jsonToModel: RollbackModel.jsonToRollbackModel,
      tag: 'remote-Rollback',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }
}

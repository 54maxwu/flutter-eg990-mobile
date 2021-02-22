import 'package:flutter_eg990_mobile/core/repository_export.dart';

import '../entity/mission_claim_form.dart';
import '../models/mission_list_model.dart';

class MissionApi {
  static const String HREF = "/mission";
  static const String GET_MISSIONS = "api/getMission";
  static const String GET_MISSION_RULES = "api/getMissionRule";
  static const String POST_MISSION_PRIZE = "api/receiveMission";
}

abstract class MissionRepository {
  Future<Either<Failure, MissionListModel>> getMissions();
  Future<Either<Failure, RequestCodeModel>> getRules();
  Future<Either<Failure, RequestCodeModel>> postClaimPrize(
      MissionClaimForm form);
}

class MissionRepositoryImpl implements MissionRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'MissionRepository';

  MissionRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt(MissionApi.HREF));
  }

  @override
  Future<Either<Failure, MissionListModel>> getMissions() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MissionApi.GET_MISSIONS,
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-$tag',
    );
    // debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess) {
          return Right(MissionListModel.parseJson(model.data));
        } else {
          return Left(Failure.errorMessage(msg: model.msg));
        }
      },
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> getRules() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(MissionApi.GET_MISSION_RULES),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-${tag}_RULE',
    );
    // debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postClaimPrize(
      MissionClaimForm form) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MissionApi.POST_MISSION_PRIZE,
        userToken: jwtInterface.token,
        data: form.toJson(),
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-${tag}_CLAIM',
    );
    // debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}

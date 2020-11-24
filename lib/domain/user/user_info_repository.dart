import 'package:dartz/dartz.dart';
import 'package:flutter_eg990_mobile/domain/auth/token_storage.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

import 'user_model.dart';

class UserInfoApi {
  static const String GET_ACCOUNT_LIMIT = "api/get_account";
  static const String GET_NEW_MESSAGE_COUNT = 'api/stationCount';
  static const String LOGOUT = "api/logout";
}

abstract class UserInfoRepository {
  Future<Either<Failure, String>> updateCredit();
  Future<Either<Failure, bool>> checkNewMessage();
  Future<Either<Failure, Unit>> logout(String account, bool cleanStorage);
}

class UserInfoRepositoryImpl implements UserInfoRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'UserInfoRepository';

  UserInfoRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface});

  @override
  Future<Either<Failure, String>> updateCredit() async {
    final result = await requestModel<UserModel>(
      request: dioApiService.get(UserInfoApi.GET_ACCOUNT_LIMIT,
          userToken: jwtInterface.token),
      jsonToModel: UserModel.jsonToUserModel,
      tag: 'remote-CREDIT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.credit),
    );
  }

  @override
  Future<Either<Failure, bool>> checkNewMessage() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(UserInfoApi.GET_NEW_MESSAGE_COUNT),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-MSG',
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
  Future<Either<Failure, Unit>> logout(
    String account,
    bool cleanStorage,
  ) async {
    String token = (jwtInterface.token.isNotEmpty)
        ? jwtInterface.token
        : await Future.value(TokenStorage.load(account)).then((value) {
            return value?.cookie?.value ?? '';
          });

    Either result;
    if (token.isNotEmpty) {
      result = await requestData(
        request: dioApiService.post(UserInfoApi.LOGOUT, userToken: token),
        tag: 'remote-LOGOUT',
      );
    }

    if (cleanStorage) {
      TokenStorage.clear();
    }

    jwtInterface.clearToken();

    return result.fold(
      (failure) => left(failure),
      (model) => right(unit),
    );
  }
}

import 'dart:convert';

import 'package:flutter_eg990_mobile/core/network/dio_api_service.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_eg990_mobile/core/repository_export.dart';
import 'package:flutter_eg990_mobile/features/member/data/repository/member_jwt_interface.dart';
import 'package:flutter_eg990_mobile/features/subfeatures/transfer/data/form/transfer_form.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

class BalanceApi {
  static const String GET_PROMISE = "api/allBlancePromise";
  static const String GET_BALANCE = "api/balance";
  static const String GET_LIMIT = "api/get_account/creditlimit";
  static const String POST_TRANSFER = "api/transfer";
}

abstract class BalanceRepository {
  Future<Either<Failure, List<String>>> getPromise();
  Future<Either<Failure, String>> getBalance(String platform);
  Future<Either<Failure, String>> getLimit();
  Future<Either<Failure, RequestStatusModel>> postTransfer(TransferForm form);
}

class BalanceRepositoryImpl implements BalanceRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'BalanceRepository';

  BalanceRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, List<String>>> getPromise() async {
    final result = await requestDataString(
      request: dioApiService.get(
        BalanceApi.GET_PROMISE,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-PROMISE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (str) {
        try {
          var list = JsonUtil.decodeArray(str);
//          print('balance promise result: $list');
          return Right(list.map((e) => e.toString()).toList());
        } on Exception {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  @override
  Future<Either<Failure, String>> getBalance(String platform) async {
    final result = await requestDataString(
      request: dioApiService.get(
        '${BalanceApi.GET_BALANCE}/$platform',
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-BALANCE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          var map = jsonDecode(data);
          if (map.containsKey('balance')) {
            print('decoded credit: ${map['balance']}');
            return Right(map['balance']);
          } else {
            print('decoded: $map');
            return Right('---');
          }
        } catch (e) {
          print('balance error: $platform');
          return Right('');
        }
      },
    );
  }

  @override
  Future<Either<Failure, String>> getLimit() async {
    final result = await requestDataString(
      request: dioApiService.get(
        BalanceApi.GET_LIMIT,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-LIMIT',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          var map = jsonDecode(data);
          if (map.containsKey('creditlimit')) {
            print('decoded limit: ${map['creditlimit']}');
            return Right(map['creditlimit']);
          } else {
            print('decoded: $map');
            return Right('-1');
          }
        } catch (e) {
          print('credit limit error: $e');
          return Right('');
        }
      },
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postTransfer(
    TransferForm form,
  ) async {
    final result = await requestModel<RequestStatusModel>(
      request:
          dioApiService.post(BalanceApi.POST_TRANSFER, data: form.toJson()),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-TRANSFER',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) async {
        String platform = (form.from == '0') ? form.to : form.from;
        await requestDataString(
          request:
              dioApiService.get('${BalanceApi.GET_BALANCE}/$platform/reload'),
          allowJsonString: true,
          tag: 'remote-RELOAD',
        );
        return Right(model);
      },
    );
  }
}

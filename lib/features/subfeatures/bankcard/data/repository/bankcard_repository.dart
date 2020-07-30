import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';

import '../form/bankcard_form.dart';
import '../models/bankcard_model.dart';

class BankcardApi {
  static const String GET_CARD = "api/bankcard";
  static const String POST_PROVINCES = "api/getProvince";
  static const String POST_BANKS = "api/getBankid";
  static const String POST_CITY = "api/getCity";
  static const String POST_NEW_CARD = "api/addbankcard";
}

abstract class BankcardRepository {
  Future<Either<Failure, BankcardModel>> getBankcard();
  Future<Either<Failure, RequestStatusModel>> postBankcard(BankcardForm form);
  Future<Either<Failure, Map<String, String>>> getBanks();
  Future<Either<Failure, Map<String, String>>> getProvinces();
  Future<Either<Failure, Map<String, String>>> getMapByCode(String code);
}

class BankcardRepositoryImpl implements BankcardRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'BankcardRepository';
  bool jwtChecked = false;

  BankcardRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, BankcardModel>> getBankcard() async {
    final result = await requestData(
      request: dioApiService.get(
        BankcardApi.GET_CARD,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-BANKCARD',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if ((data is bool && !data) || (data is String && data == 'false')) {
          return Right(BankcardModel(hasCard: false));
        } else if (data is Map) {
          data.putIfAbsent('hasCard', () => true);
          MyLogger.print(msg: 'bankcard map: $data', tag: tag);
          return Right(BankcardModel.jsonToBankcardModel(data));
        } else if (data is String &&
            data.startsWith('{') &&
            data.endsWith('}')) {
          Map map = jsonDecode(data);
          map.putIfAbsent('hasCard', () => true);
          MyLogger.print(msg: 'bankcard map: $map', tag: tag);
          return Right(BankcardModel.jsonToBankcardModel(map));
        } else {
          MyLogger.error(msg: 'bankcard data error: $data', tag: tag);
          return Left(Failure.token());
        }
      },
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postBankcard(
      BankcardForm form) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        BankcardApi.POST_NEW_CARD,
        data: form.toJson(),
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-BANKCARD_NEW',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, Map<String, String>>> getBanks() async {
    final result = await requestData(
      request: dioApiService.post(
        BankcardApi.POST_BANKS,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-BANK_ID',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data is Map || data is String) {
          return _processMap(data, 'banks id');
        } else {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, String>>> getProvinces() async {
    final result = await requestData(
      request: dioApiService.post(
        BankcardApi.POST_PROVINCES,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-BANK_PROVINCE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if ('$data'.isEmpty || '$data' == '[]') return Right(null);
        if (data is Map || data is String) {
          return _processMap(data, 'provinces');
        } else {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, String>>> getMapByCode(String code) async {
    final result = await requestData(
      request: dioApiService.post(
        BankcardApi.POST_CITY,
        data: {"code": code},
        userToken: jwtInterface.token,
      ),
      tag: 'remote-BANK_AREA',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.toString().isEmpty || data.toString() == '[]')
          return Right(null);
        if (data is Map || data is String) {
          return _processMap(data, 'areas');
        } else {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  Either<Failure, Map<String, String>> _processMap(
    dynamic data,
    String dataName, {
    bool debug = false,
  }) {
    try {
      if (debug)
        MyLogger.print(
          msg: '$dataName data type: ${data.runtimeType}, data: \n$data',
          tag: tag,
        );

      if (data is Map) {
        return Right(data.map<String, String>(
            (key, value) => MapEntry<String, String>(key, value.toString())));
      } else {
        var map = jsonDecode('$data');
        return Right(map.map<String, String>(
            (key, value) => MapEntry<String, String>(key, value.toString())));
      }
    } catch (e) {
      MyLogger.error(
          msg: '$dataName data process error!! $e', error: e, tag: tag);
      return Left(Failure.jsonFormat());
    }
  }
}

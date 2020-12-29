import 'package:flutter_eg990_mobile/core/repository_export.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../form/deposit_form.dart';
import '../model/deposit_info.dart';
import '../model/deposit_result.dart';
import '../model/payment_promo.dart';
import '../model/payment_type.dart';

class DepositApi {
  static const String GET_CARD = "api/bankcard";
  static const String GET_PAYMENT = "api/getPayment";
  static const String GET_PAYMENT_PROMO = "api/getPromo";
  static const String GET_DEPOSIT_INFO = "/api/getShowAcc";
  static const String GET_DEPOSIT_RULE = "/api/getDepositRule";
  static const String GET_DEPOSIT_BANK = "/api/getBankid";
  static const String POST_DEPOSIT = "api/deposit";
  static const String JWT_CHECK_HREF = "/deposit";
}

abstract class DepositRepository {
  Future<Either<Failure, bool>> checkBankcard();
  Future<Either<Failure, List<PaymentType>>> getPayment();

  Future<Either<Failure, PaymentPromoTypeJson>> getPaymentPromo();

  Future<Either<Failure, List<DepositInfo>>> getDepositInfo();

  Future<Either<Failure, Map<int, String>>> getDepositBanks();

  Future<Either<Failure, Map<int, String>>> getDepositRule();

  Future<Either<Failure, DepositResult>> postDeposit(DepositDataForm form);
}

class DepositRepositoryImpl implements DepositRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'DepositRepository';

  DepositRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, bool>> checkBankcard() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        DepositApi.GET_CARD,
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-BANKCARD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.isSuccess && data.data.toString().isNotEmpty) {
          MyLogger.print(msg: 'bankcard map: ${data.data}', tag: tag);
          if (data.data is Map)
            return Right(true);
          else if (data.data is String)
            return Right(true);
          else
            return Left(Failure.dataType());
        } else {
          return Right(false);
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<PaymentType>>> getPayment() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        DepositApi.GET_PAYMENT,
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-DEPOSIT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold((failure) => Left(failure), (data) {
      if (data.isSuccess) {
        MyLogger.print(msg: 'payment map: ${data.data}', tag: tag);
        if (data.data is Map)
          return Right(decodePaymentTypes(data.data));
        else if (data.data is String)
          return Right(decodePaymentTypes(jsonDecode(data.data)));
        else if (data.data is List && (data.data as List).isEmpty)
          return Right([]);
        else
          return Left(Failure.dataType());
      } else {
        MyLogger.error(msg: 'payment data error: $data', tag: tag);
        return Left(Failure.token(FailureType.DEPOSIT));
      }
    });
  }

  @override
  Future<Either<Failure, PaymentPromoTypeJson>> getPaymentPromo() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        DepositApi.GET_PAYMENT_PROMO,
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-DEPOSIT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.isSuccess) {
          MyLogger.print(msg: 'payment promo map: ${data.data}', tag: tag);
          if (data.data is Map)
            return Right(PaymentPromo.jsonToPaymentPromo(data.data));
          else if (data.data is String)
            return Right(
                PaymentPromo.jsonToPaymentPromo(jsonDecode(data.data)));
          else if (data.data is List && (data.data as List).isEmpty)
            return Right(PaymentPromoTypeJson(local: '', other: ''));
          else
            return Left(Failure.dataType());
        } else {
          MyLogger.error(msg: 'payment promo data error: $data', tag: tag);
          return Left(Failure.token(FailureType.DEPOSIT));
        }
      },
    );
  }

  @override
  Future<Either<Failure, Map<int, String>>> getDepositBanks() async {
    final result = await requestData(
      request: dioApiService.post(
        DepositApi.GET_DEPOSIT_BANK,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-DEPOSIT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.map<int, String>((key, value) {
        return MapEntry<int, String>(
            (key is int) ? key : '$key'.strToInt, '$value');
      })),
    );
  }

  @override
  Future<Either<Failure, Map<int, String>>> getDepositRule() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        DepositApi.GET_DEPOSIT_RULE,
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-DEPOSIT',
    );
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.data.map<int, String>((key, value) {
        debugPrint('rule key: $key, data: $value');
        return MapEntry<int, String>('$key'.strToInt, """$value""");
      })),
    );
  }

  @override
  Future<Either<Failure, DepositResult>> postDeposit(
      DepositDataForm form) async {
    final result = await requestModel<DepositResult>(
      request: dioApiService.post(
        DepositApi.POST_DEPOSIT,
        userToken: jwtInterface.token,
        data: form.toJson(),
      ),
      jsonToModel: DepositResult.jsonToDepositResult,
      tag: 'remote-DEPOSIT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, List<DepositInfo>>> getDepositInfo() async {
    final result = await requestData(
      request: dioApiService.get(
        DepositApi.GET_DEPOSIT_INFO,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-DEPOSIT',
    );
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(
        JsonUtil.decodeMapToModelList(
          data,
          (jsonMap) => DepositInfo.jsonToDepositInfo(jsonMap),
          addKey: false,
        ),
      ),
    );
  }
}

import 'package:flutter_eg990_mobile/core/repository_export.dart';
import 'package:flutter_eg990_mobile/features/member/data/repository/member_jwt_interface.dart';

import '../form/deposit_form.dart';
import '../model/deposit_result.dart';
import '../model/payment_promo.dart';
import '../model/payment_raw.dart';

class DepositApi {
  static const String GET_PAYMENT = "api/getPayment";
  static const String GET_PAYMENT_PROMO = "api/getPromo";
  static const String POST_DEPOSIT = "api/deposit";
  static const String JWT_CHECK_HREF = "/deposit";
}

abstract class DepositRepository {
  Future<Either<Failure, PaymentRaw>> getPayment();
  Future<Either<Failure, PaymentPromoTypeJson>> getPaymentPromo();
  Future<Either<Failure, DepositResult>> postDeposit(DepositDataForm form);
}

class DepositRepositoryImpl implements DepositRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'DepositRepository';
  bool jwtChecked = false;

  DepositRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, PaymentRaw>> getPayment() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        DepositApi.GET_PAYMENT,
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-DEPOSIT',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.isSuccess) {
          MyLogger.print(msg: 'payment map: ${data.data}', tag: tag);
          if (data.data is Map)
            return Right(PaymentRaw.jsonToPaymentRaw(data.data));
          else if (data.data is String)
            return Right(PaymentRaw.jsonToPaymentRaw(jsonDecode(data.data)));
          else
            return Left(Failure.dataType());
        } else {
          MyLogger.error(msg: 'payment data error: $data', tag: tag);
          return Left(Failure.token());
        }
      },
    );
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
//    print('test response type: ${result.runtimeType}, data: $result');
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
          else
            return Left(Failure.dataType());
        } else {
          MyLogger.error(msg: 'payment promo data error: $data', tag: tag);
          return Left(Failure.token());
        }
      },
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
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}

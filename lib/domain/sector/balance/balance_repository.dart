import 'dart:async' show StreamController;

import 'package:flutter_eg990_mobile/domain/sector/balance/balance_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/transfer/transfer_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/transfer/transfer_result.dart';
import 'package:flutter_eg990_mobile/domain/sector/wallet/wallet_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/withdraw/withdraw_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/withdraw/withdraw_model.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

class BalanceApi {
  static const String POST_WALLET = "api/walletbalance";
  static const String GET_PROMISE = "api/allBalancePromise";
  static const String GET_BALANCE = "api/balance";
  static const String POST_TRANSFER_ALL = "api/balancetomain";

  static const String POST_TRANSFER = "api/transfer";
  static const String POST_WITHDRAW = "api/withdrawal";
}

abstract class BalanceRepository {
  /// Get all platform names
  Future<Either<Failure, BalanceData>> getWallet();

  /// Get all platform names
  Future<Either<Failure, List<String>>> getPromise();

  /// Get requested platform's current credit
  Future<Either<Failure, BalanceData>> getBalance(String platform);

  /// Transfer all platform credit to wallet
  Future<Either<Failure, Map<String, dynamic>>> postTransferAll(
    List<String> platforms,
    StreamController<String> progressController,
  );

  /// Transfer credit between platforms
  Future<Either<Failure, TransferResult>> postTransfer(TransferForm form);

  /// Withdraw credit to wallet or card
  Future<Either<Failure, WithdrawModel>> postWithdraw(WithdrawForm form);
}

class BalanceRepositoryImpl implements BalanceRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'BalanceRepository';

  BalanceRepositoryImpl({
    @required this.dioApiService,
    @required this.jwtInterface,
  }) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, BalanceData>> getWallet() async {
    final result = await requestModel<WalletModel>(
      request: dioApiService.post(
        BalanceApi.POST_WALLET,
        userToken: jwtInterface.token,
        data: {'accountcode': jwtInterface.username},
      ),
      parseJson: WalletModel.parseJson,
      tag: 'remote-WALLET',
    );
//      debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => (model.auto != '-1')
          ? Right(BalanceData(platform: '0', amount: model.credit))
          : Left(Failure.token(FailureType.WALLET)),
    );
  }

  @override
  Future<Either<Failure, List<String>>> getPromise() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        BalanceApi.GET_PROMISE,
        userToken: jwtInterface.token,
      ),
      parseJson: RequestCodeModel.parseJson,
      tag: 'remote-BALANCE_PROMISE',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Right([]),
      (model) {
        if (model.data.isNotEmpty) {
          try {
            // decode list in json format to string list
            List decoded = JsonUtil.decodeArray(model.data, trim: false);
            MyLogger.print(
                msg: 'balance platform decoded list: $decoded', tag: tag);
            if (decoded.isNotEmpty) {
              if (decoded.first is String) {
                return Right(decoded.map((e) => e.toString()).toList());
              } else if (decoded.first is Map) {
                List<String> list = decoded.map((e) {
                  Map itemMap = e as Map;
                  return (itemMap.containsKey('name'))
                      ? '${itemMap['name']}'
                      : '';
                }).toList()
                  ..removeWhere((element) => element.isEmpty);
                // debugPrint('balance platform list: $list');
                return Right(list);
              }
            }
          } on Exception catch (e) {
            MyLogger.error(
                msg: 'balance platform map error!!', error: e, tag: tag);
          }
        }
        return Right([]);
      },
    );
  }

  @override
  Future<Either<Failure, BalanceData>> getBalance(String platform) async {
    final result = await requestDataString(
      request: dioApiService.get(
        '${BalanceApi.GET_BALANCE}/$platform',
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-BALANCE',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          var map = jsonDecode(data);
          if (map.containsKey('balance')) {
            debugPrint('decoded credit: ${map['balance']}');
            return Right(BalanceData(
              platform: platform,
              amount: ValueUtil.format(map['balance'], trimIfZero: false),
            ));
          } else {
            debugPrint('decoded: $map');
            return Right(BalanceData(platform: platform, amount: '---'));
          }
        } catch (e) {
          debugPrint('balance error: $platform');
          return Right(BalanceData(
              platform: platform, amount: 'x', error: e.toString()));
        }
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> postTransferAll(
    List<String> platforms,
    StreamController<String> progressController,
  ) async {
    if (platforms != null && platforms.isNotEmpty) {
      final result = await Future.microtask(
        () => dioApiService.postList(
          BalanceApi.POST_TRANSFER,
          dataList: List.generate(
            platforms.length,
            (index) => {
              'accountcode': jwtInterface.username,
              'plat': {'name': platforms[index]},
            },
          ),
          keyList: platforms,
          stream: progressController,
          userToken: jwtInterface.token,
        ),
      ).catchError((e) => null);
      return Right(result);
    } else {
      MyLogger.warn(
          msg: 'cannot retrieve platform list in wallet page!!', tag: tag);
      return Left(Failure.server());
    }
  }

  @override
  Future<Either<Failure, TransferResult>> postTransfer(
      TransferForm form) async {
    final result = await requestModel<TransferResult>(
      request: dioApiService.post(
        BalanceApi.POST_TRANSFER,
        data: form.toJson(),
      ),
      parseJson: TransferResult.parseJson,
      tag: 'remote-TRANSFER',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
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

  @override
  Future<Either<Failure, WithdrawModel>> postWithdraw(WithdrawForm form) async {
    final result = await requestModel<WithdrawModel>(
      request: dioApiService.post(
        BalanceApi.POST_WITHDRAW,
        data: form.toJson(),
        userToken: jwtInterface.token,
      ),
      parseJson: WithdrawModel.parseJson,
      tag: 'remote-WITHDRAW',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.code == 0)
          return Right(model);
        else
          return Left(Failure.errorMessage(msg: model.msg));
      },
    );
  }
}

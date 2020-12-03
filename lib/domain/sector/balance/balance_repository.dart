import 'package:flutter_eg990_mobile/domain/sector/balance/balance_data.dart';
import 'file:///C:/Dev/Projects/flutter_eg990_mobile/lib/domain/sector/wallet/wallet_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/transfer/transfer_form.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

class BalanceApi {
  static const String POST_WALLET = "api/walletbalance";
  static const String GET_PROMISE = "api/allBlancePromise";
  static const String GET_BALANCE = "api/balance";
  static const String POST_TRANSFER = "api/transfer";
}

abstract class BalanceRepository {
  /// Get all platform names
  Future<Either<Failure, BalanceData>> getWallet();

  /// Get all platform names
  Future<Either<Failure, List<String>>> getPromise();

  /// Get requested platform's current credit
  Future<Either<Failure, BalanceData>> getBalance(String platform);

  /// Transfer credit between platforms
  Future<Either<Failure, RequestStatusModel>> postTransfer(TransferForm form);
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
      parseJson: WalletModel.jsonToWalletModel,
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
      request: dioApiService.post(
        BalanceApi.GET_PROMISE,
        userToken: jwtInterface.token,
      ),
      parseJson: RequestCodeModel.jsonToCodeModel,
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
            MyLogger.print(msg: 'wallet decoded list: $decoded', tag: tag);
            return Right(decoded.map((e) => e.toString()).toList());
          } on Exception catch (e) {
            MyLogger.error(msg: 'wallet map error!!', error: e, tag: tag);
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
              amount: formatValue(map['balance'], trimIfZero: false),
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
  Future<Either<Failure, RequestStatusModel>> postTransfer(
      TransferForm form) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        BalanceApi.POST_TRANSFER,
        data: form.toJson(),
      ),
      parseJson: RequestStatusModel.jsonToStatusModel,
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
}

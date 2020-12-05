import 'package:flutter_eg990_mobile/domain/sector/wallet/wallet_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/wallet/wallet_type.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

class TransferApi {
  static const String POST_WALLET = "api/walletbalance";
  static const String POST_CHANGE = "api/changewallet";
  static const String JWT_CHECK_HREF = "/no_transfer_wallet";
  static const String WALLET_OPTION_SINGLE = "WlraLb1";
  static const String WALLET_OPTION_MULTI = "WlraLb0";
}

abstract class TransferRepository {
  Future<Either<Failure, WalletType>> getWalletType();
  Future<Either<Failure, String>> postWalletType(bool toSingle);
}

class TransferRepositoryImpl implements TransferRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'TransferRepository';

  TransferRepositoryImpl({
    @required this.dioApiService,
    @required this.jwtInterface,
  }) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, WalletType>> getWalletType() async {
    final result = await requestModel<WalletModel>(
      request: dioApiService.post(
        TransferApi.POST_WALLET,
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
          ? Right(WalletType(model.auto))
          : Left(Failure.token(FailureType.WALLET)),
    );
  }

  @override
  Future<Either<Failure, String>> postWalletType(bool toSingle) async {
    final result = await requestDataString(
      request: dioApiService.post(
        TransferApi.POST_CHANGE,
        data: {
          'accountcode': jwtInterface.username,
          'status': (toSingle)
              ? TransferApi.WALLET_OPTION_SINGLE
              : TransferApi.WALLET_OPTION_MULTI,
        },
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-WALLET_CHANGE',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }
}

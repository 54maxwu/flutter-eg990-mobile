import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_model.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

class WithdrawApi {
  static const String GET_CARD = "api/bankcard";
}

abstract class WithdrawRepository {
  Future<Either<Failure, BankcardModel>> getBankcard();
}

class WithdrawRepositoryImpl implements WithdrawRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'WithdrawRepository';

  WithdrawRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, BankcardModel>> getBankcard() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        WithdrawApi.GET_CARD,
        userToken: jwtInterface.token,
      ),
      parseJson: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-BANKCARD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.isSuccess && data.data.toString().isNotEmpty) {
          MyLogger.print(msg: 'bankcard map: ${data.data}', tag: tag);
          if (data.data is Map)
            return Right(BankcardModel.jsonToBankcardModel(data.data)
                .copyWith(hasCard: true));
          else if (data.data is String)
            return Right(
                BankcardModel.jsonToBankcardModel(jsonDecode(data.data))
                    .copyWith(hasCard: true));
          else
            return Left(Failure.dataType());
        } else {
          return Right(BankcardModel(hasCard: false));
        }
      },
    );
  }
}

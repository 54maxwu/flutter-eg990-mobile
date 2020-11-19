import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';
import 'package:flutter_eg990_mobile/injection_container.dart' show sl;
import 'package:flutter_eg990_mobile/presentation/features/user/presentation/state/user_info_store.dart';

import 'token_storage.dart';

class JwtApi {
  static const String JWT_CHECK = "api/checkJwt";
}

abstract class JwtInterface {
  String account;
  String accountId;
  String token;

  /// Calls the service [UserApi.JWT_CHECK] endpoint to verify [token].
  Future<Either<Failure, RequestStatusModel>> checkJwt(
    String href, {
    String loginAccount,
    String loginToken,
  });

  Future<void> clearToken();
}

class JwtInterfaceImpl implements JwtInterface {
  final DioApiService dioApiService;
  final tag = 'JwtInterface';

  JwtInterfaceImpl({@required this.dioApiService});

  UserInfoStore infoStore;

  ///
  /// Check token to confirm user action is valid
  ///
  Future<bool> _readToken() async {
    infoStore ??= sl.get<UserInfoStore>();
    if (infoStore != null && !infoStore.hasUser) {
      MyLogger.debug(msg: 'no user, cannot read token');
      return false;
    }
    String currentAccount = infoStore.userName;
    if (token.isEmpty) {
      account = currentAccount;
      token = await Future.value(TokenStorage.load(account))
          .then((value) => value.cookie.value);
      debugPrint('jwt token: $token');
    }
    return true;
  }

  @override
  Future<Either<Failure, RequestStatusModel>> checkJwt(
    String href, {
    String loginAccount,
    String loginToken,
  }) async {
    if (loginAccount != null && loginToken != null) {
      account = loginAccount;
      token = loginToken;
      return await requestModel<RequestStatusModel>(
        request: dioApiService.post(JwtApi.JWT_CHECK,
            userToken: loginToken, data: {"href": href}),
        jsonToModel: RequestStatusModel.jsonToStatusModel,
        tag: 'remote-JWT',
      ).then((result) => result.fold(
            (failure) => Left(failure),
            (status) => Right(status),
          ));
    } else {
      return await _readToken().then((canContinue) async {
        if (canContinue) {
          return await requestModel<RequestStatusModel>(
            request: dioApiService
                .post(JwtApi.JWT_CHECK, userToken: token, data: {"href": href}),
            jsonToModel: RequestStatusModel.jsonToStatusModel,
            tag: 'remote-JWT',
          ).then(
            (result) => result.fold(
              (failure) => Left(failure),
              (status) => Right(status),
            ),
          );
        } else {
          return Left(Failure.token(FailureType.TOKEN));
        }
      });
    }
  }

  @override
  Future<void> clearToken() => Future.sync(() {
        token = '';
        accountId = '';
        MyLogger.info(msg: 'jwt token cleared', tag: 'JwtInterface');
      });

  @override
  String token = '';

  @override
  String account = '';

  @override
  String accountId = '';
}

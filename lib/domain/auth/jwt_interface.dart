import 'package:dartz/dartz.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/domain/response/request_status_model.dart';
import 'package:flutter_eg990_mobile/infrastructure/core/dio_api_service.dart';
import 'package:flutter_eg990_mobile/infrastructure/handler/request_handler.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:meta/meta.dart' show required;

import 'token_storage.dart';

class JwtApi {
  static const String JWT_CHECK = "api/checkJwt";
}

abstract class JwtInterface {
  bool get hasUser;

  String get username;

  String get userId;

  String get token;

  /// Calls the service [UserApi.JWT_CHECK] endpoint to verify [token].
  Future<Either<Failure, Unit>> checkJwt(
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

  /// Currently logged in user
  String _account = '';

  /// User id for game to recognize user
  String _accountId = '';

  /// User auth string from server
  String _token = '';

  @override
  Future<Either<Failure, Unit>> checkJwt(
    String href, {
    String loginAccount,
    String loginToken,
  }) async {
    if (loginAccount != null && loginToken != null) {
      return await requestModel<RequestStatusModel>(
        request: dioApiService.post(JwtApi.JWT_CHECK,
            userToken: loginToken, data: {"href": href}),
        parseJson: RequestStatusModel.jsonToStatusModel,
        tag: 'remote-JWT',
      ).then((result) => result.fold(
            (failure) => left(failure),
            (status) {
              if (status.isSuccess) {
                _account = loginAccount;
                _accountId = status.msg;
                _token = loginToken;
                return right(unit);
              } else {
                return left(Failure.errorStatus(status));
              }
            },
          ));
    } else {
      return await _readToken().then((canContinue) async {
        if (canContinue) {
          return await requestModel<RequestStatusModel>(
            request: dioApiService.post(JwtApi.JWT_CHECK,
                userToken: _token, data: {"href": href}),
            parseJson: RequestStatusModel.jsonToStatusModel,
            tag: 'remote-JWT',
          ).then(
            (result) => result.fold(
              (failure) => left(failure),
              (status) => (status.isSuccess)
                  ? right(unit)
                  : left(Failure.errorStatus(status)),
            ),
          );
        } else {
          return Left(Failure.token(FailureType.TOKEN));
        }
      });
    }
  }

  ///
  /// Check token to confirm user action is valid
  ///
  Future<bool> _readToken() async {
    if (_account.isEmpty) {
      MyLogger.debug(msg: 'no user, cannot read token');
      return false;
    }
    if (_token.isEmpty) {
      _token = await Future.value(TokenStorage.load(_account))
          .then((value) => value.cookie.value);
      // debugPrint('jwt token: $token');
    }
    return true;
  }

  @override
  Future<void> clearToken() => Future.sync(() {
        _token = '';
        _account = '';
        MyLogger.info(msg: 'jwt token cleared', tag: 'JwtInterface');
      });

  @override
  bool get hasUser => _account.isNotEmpty;

  @override
  String get token => _token;

  @override
  String get username => _account;

  @override
  String get userId => _accountId;
}

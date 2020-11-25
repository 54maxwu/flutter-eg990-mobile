import 'package:flutter_eg990_mobile/domain/user/user_model.dart';
import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';
import 'package:flutter_eg990_mobile/presentation/features/login/form/login_form.dart';

class LoginApi {
  static const String LOGIN = "api/login";
  static const String GET_ACCOUNT = "api/get_account";
  static const String JWT_CHECK_HREF = "/myaccount";
}

abstract class LoginRepository {
  /// Calls the service [LoginApi.LOGIN] endpoint with [form] to get user info.
  Future<Either<Failure, UserModel>> login(LoginForm form);
}

class LoginRepositoryImpl implements LoginRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'UserRepository';

  LoginRepositoryImpl({
    @required this.dioApiService,
    @required this.jwtInterface,
  });

  @override
  Future<Either<Failure, UserModel>> login(LoginForm form) async {
    final result = await requestHeader(
      request: dioApiService.post(LoginApi.LOGIN, data: form.toJson()),
      header: 'set-cookie',
      tag: 'remote-USER',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) async {
        debugPrint('data response type: ${data.runtimeType}');
        try {
          if (data.toString().contains('token_mobile')) {
            // extract token from response data
            final token =
                data.substring(data.indexOf('=') + 1, data.indexOf(';'));
            debugPrint('token: $token');

            // return Right(UserModel(
            //   account: account,
            //   credit: '0.00',
            //   status: 'success',
            //   vip: 1,
            //   vipName: 'Th\u00e0nh vi\u00ean b',
            // ));
            return await _checkTokenAndGetAccountInfo(
                form.username.value, token);
          } else if (data.toString().contains('"msg":')) {
            // parse error message to status model
            RequestStatusModel loginStatus = JsonUtil.decodeToModel(data,
                (jsonMap) => RequestStatusModel.jsonToStatusModel(jsonMap));
            debugPrint('login result: $loginStatus');
            return Left(Failure.login(loginStatus));
          }
        } catch (e, s) {
          debugPrint('login has exception: $e, stack:\n$s');
        }
        return Left(Failure.dataType());
      },
    );
  }

  ///
  /// Calls the [JwtInterface.checkJwt] to check if the returned token is valid,
  /// then calls [getAccount] to retrieve user info.
  ///
  Future<Either<Failure, UserModel>> _checkTokenAndGetAccountInfo(
      String account, String token) async {
    MyLogger.log(msg: 'start validate token...', tag: tag);
    return await Future.delayed(Duration(milliseconds: 500), () {
      return jwtInterface.checkJwt(
        LoginApi.JWT_CHECK_HREF,
        loginAccount: account,
        loginToken: token,
      );
    }).then(
      (result) => result.fold(
        (failure) {
          MyLogger.warn(msg: 'token is not valid!!', tag: tag);
          jwtInterface.clearToken();
          return Left(failure);
        },
        (_) async {
          MyLogger.log(
              msg: 'user token is valid, requesting account info...', tag: tag);
          return await _getAccount(token);
        },
      ),
    );
  }

  ///
  /// Calls the service [LoginApi.GET_ACCOUNT] endpoint,
  /// and decode json into [UserModel].
  ///
  Future<Either<Failure, UserModel>> _getAccount(String token) async {
    MyLogger.log(msg: 'requesting account info...', tag: tag);
    final result = await requestModel<UserModel>(
      request: dioApiService.get(LoginApi.GET_ACCOUNT, userToken: token),
      jsonToModel: UserModel.jsonToUserModel,
      tag: 'remote-USER',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}

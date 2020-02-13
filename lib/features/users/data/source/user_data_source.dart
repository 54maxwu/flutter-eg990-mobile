import 'package:flutter_ty_mobile/core/data/data_request_handler.dart'
    show requestData, requestResponseHeader;
import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/features/home/domain/usecase/usecase_export.dart';
import 'package:flutter_ty_mobile/features/users/data/form/login_form.dart';
import 'package:flutter_ty_mobile/features/users/data/models/user_model.dart';
import 'package:meta/meta.dart' show required;

import 'user_api.dart';

abstract class UserRemoteDataSource {
  /// Calls the service [UserApi.GET_ACCOUNT] endpoint, and decode json into [UserModel].
  Future<UserModel> getAccount(UserLoginForm form);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioApiService dioApiService;
  final tag = 'UserRemoteDataSource';

  UserRemoteDataSourceImpl({@required this.dioApiService});

  Future<List<String>> _login(UserLoginForm form) {
    print('loggin user...');
    return requestResponseHeader(
      request: dioApiService.post(UserApi.LOGIN, data: form.toJson()),
      header: 'set-cookie',
      tag: 'remote-USER',
    );
  }

  @override
  Future<UserModel> getAccount(UserLoginForm form) async {
    final tokenStr = await Future.value(_login(form)).then((headers) =>
        headers.firstWhere((str) => str.startsWith('token_mobile')));
    final token =
        tokenStr.substring(tokenStr.indexOf('=') + 1, tokenStr.indexOf(';'));
    MyLogger.debug(msg: 'user token: $token', tag: tag);
    return requestData<UserModel>(
      request: dioApiService.get(UserApi.GET_ACCOUNT, userToken: token),
      jsonToModel: UserModel.jsonToUserModel,
      tag: 'remote-USER',
    );
  }
}

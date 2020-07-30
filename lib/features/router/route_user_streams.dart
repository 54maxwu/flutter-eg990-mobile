import 'dart:async' show StreamController, Stream;

import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/features/general/data/user/user_token_storage.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/login_status.dart';
import 'package:flutter_ty_mobile/features/user/data/repository/user_repository.dart'
    show UserApi;
import 'package:flutter_ty_mobile/injection_container.dart';
import 'package:flutter_ty_mobile/mylogger.dart';

import 'app_navigate.dart' show RouterNavigate;

RouteUserStreams get getRouteUserStreams => sl.get<RouteUserStreams>();

///
/// Stream user [LoginStatus] through out the app to control UI state
///
class RouteUserStreams {
  final StreamController<LoginStatus> _userControl =
      StreamController<LoginStatus>.broadcast();

  final StreamController<bool> _recheckControl =
      StreamController<bool>.broadcast();

  DioApiService _dioApiService;

  Stream<LoginStatus> get userStream => _userControl.stream;

  Stream<bool> get recheckUserStream => _recheckControl.stream;

  LoginStatus _user = LoginStatus(loggedIn: false);

  bool hasEvent = false;

  LoginStatus get lastStatus => _user;

  bool get hasUser => _user.loggedIn;

  int get userLevel => _user.currentUser?.vip ?? 0;

  String get userName => _user.currentUser?.account ?? 'Guest';

  String get userCredit => _user.currentUser?.credit ?? '0';

  RouteUserStreams() {
    _userControl.stream.listen((event) {
      print('update stream user: $event');
      _user = event;
    });
  }

  updateUser(LoginStatus user) {
    _userControl.sink.add(user);
  }

  setCheck(bool recheck) {
    _recheckControl.sink.add(recheck);
  }

  logout() async {
    if (!hasUser) return;
    String userName = _user.currentUser.account;
    MyLogger.info(msg: 'logging out user $userName', tag: 'RouteUserStreams');
    try {
      var jwtInterface = sl.get<MemberJwtInterface>();
      _dioApiService ??= sl.get<DioApiService>();

      String token = (jwtInterface.token.isNotEmpty)
          ? jwtInterface.token
          : await Future.value(UserTokenStorage.load(userName)).then((value) {
              return value?.cookie?.value ?? '';
            });
      if (token.isNotEmpty)
        _dioApiService.post(UserApi.LOGOUT, userToken: token);

      jwtInterface.clearToken();
    } catch (e, s) {
      MyLogger.error(
        msg: 'logout $userName has error: $e',
        tag: 'RouteUserStreams',
      );
      print('stack:\n$s');
    }
    Future.delayed(Duration(milliseconds: 500),
        () => RouterNavigate.navigateClean(force: true));
    _userControl.sink.add(LoginStatus(loggedIn: false));
    _recheckControl.sink.add(true);
  }

  dispose() {
    MyLogger.warn(msg: 'disposing route streams!!', tag: 'RouteUserStreams');
    _userControl.close();
    _recheckControl.close();
  }
}

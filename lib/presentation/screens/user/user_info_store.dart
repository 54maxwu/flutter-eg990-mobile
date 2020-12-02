import 'package:flutter_eg990_mobile/domain/user/login/login_status.dart';
import 'package:flutter_eg990_mobile/domain/user/user_info_repository.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';

part 'user_info_store.g.dart';

class UserInfoStore = _UserInfoStore with _$UserInfoStore;

abstract class _UserInfoStore with Store {
  final String tag = 'UserInfoStore';
  final UserInfoRepository _repository;

  _UserInfoStore(this._repository);

  /// Info
  final String _creditResetStr = '$creditSymbol---';

  LoginStatus _userStatus = LoginStatus(loggedIn: false);

  int get userLevel => (hasUser) ? _userStatus.user.vip : -1;

  @observable
  bool askRecheckInfo = false;

  @observable
  bool hasUser = false;

  String userName = '';

  @observable
  String userCredit = '';

  @observable
  bool hasNewMessage = false;

  /// Error
  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.USER,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  set setRecheck(bool recheck) => askRecheckInfo = recheck;

  void updateUser(LoginStatus status) {
    userName = (status.loggedIn) ? status.user.username.value : '';
    userCredit = (status.loggedIn)
        ? formatValue(status.user.credit, creditSign: true)
        : '';
    if (status != _userStatus) {
      _userStatus = status;
      hasUser = status.loggedIn;
      if (status.loggedIn) {
        // getUserCredit();
        getNewMessageCount();
      } else {
        hasNewMessage = false;
      }
    }
  }

  /// Pass in credit value to update credit,
  /// if value is null or not passed in then reset.
  void updateOrResetCredit({String credit = ''}) {
    userCredit = (credit.isNotEmpty)
        ? formatValue(userCredit, creditSign: true)
        : _creditResetStr;
  }

  @action
  Future<void> getUserCredit() async {
    try {
      if (!hasUser) return;
      updateOrResetCredit();
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.updateCredit().then(
            (result) => result.fold(
              (failure) {
                setErrorMsg(msg: failure.message, showOnce: true);
                updateOrResetCredit();
              },
              (value) {
                updateOrResetCredit(credit: value);
              },
            ),
          );
    } on Exception catch (e) {
      MyLogger.error(
          msg: 'update user credit has exception', tag: tag, error: e);
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> getNewMessageCount() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    try {
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.checkNewMessage().then((result) {
        debugPrint('new message result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (value) {
            hasNewMessage = value;
          },
        );
      });
    } on Exception catch (e) {
      MyLogger.error(
          msg: 'update user credit has exception', tag: tag, error: e);
      setErrorMsg(code: 4);
    }
  }

  @action
  Future<void> logout({bool clean = false, bool navToLogin = true}) async {
    if (!hasUser) return Future.value();
    String user = '$userName';
    debugPrint('logging out user $user');
    try {
      await _repository.logout(user, clean).then(
            (result) => result.fold(
              (failure) => setErrorMsg(msg: failure.message, showOnce: true),
              (value) {
                MyLogger.info(msg: 'log out success', tag: tag);
              },
            ),
          );
    } catch (e) {
      MyLogger.error(msg: 'logout $userName has error: $e', tag: tag);
      setErrorMsg(code: 9);
    }

    Future.delayed(
        Duration(milliseconds: 500), () => AppNavigator.returnToHome());
    // Future.delayed(
    //     Duration(milliseconds: 500),
    //     () => (navToLogin)
    //         ? AppNavigator.navigateTo(RoutePage.login)
    //         : AppNavigator.returnToHome());

    updateUser(LoginStatus(loggedIn: false));
    setRecheck = true;
  }
}

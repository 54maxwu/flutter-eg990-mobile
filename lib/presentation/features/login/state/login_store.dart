import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/internal/error_message_map.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_repository.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_status.dart';
import 'package:flutter_eg990_mobile/domain/user/user_model.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';

import '../form/login_form.dart';
import '../../../../domain/user/login/login_form_hive.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

enum LoginStoreState { initial, loading, loaded }

enum LoginState { initial, loading, complete, failed }

abstract class _LoginStore with Store {
  final LoginRepository _repository;
  final UserInfoStore _infoStore;
  final String tag = 'LoginStore';

  _LoginStore(this._repository, this._infoStore);

  @observable
  ObservableFuture<Box> _initFuture;

  Box _box;

  LoginFormHive hiveLoginForm;

  String _lastLoginName = '';

  String get lastUser => _lastLoginName;

  @observable
  ObservableFuture<Either<Failure, UserModel>> _loginFuture;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.LOGIN,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  LoginStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return LoginStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? LoginStoreState.loading
        : LoginStoreState.loaded;
  }

  @action
  Future<void> checkHistory() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // Fetch from the repository and wrap the regular Future into an observable.
    _initFuture =
        ObservableFuture(Future.value(getHiveBox(Global.CACHE_LOGIN_FORM)));
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _initFuture.then((value) {
      _box = value;
      MyLogger.log(msg: 'login history check: ${_box?.length}', tag: tag);
      if (_box != null && _box.isNotEmpty) {
        // debugPrint(
        //     'last hive user: ${(_box.values.last as LoginFormHive).username}');
        hiveLoginForm = _box.values.last;
      }
    });
  }

  void cleanHistoryData() => hiveLoginForm = LoginFormHive.clean();

  @computed
  LoginState get loginState {
    // If the user has not yet triggered a action or there has been an error
    if (_loginFuture == null || _loginFuture.status == FutureStatus.rejected) {
      return LoginState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _loginFuture.status == FutureStatus.pending
        ? LoginState.loading
        : (_lastLoginName.isNotEmpty)
            ? LoginState.complete
            : LoginState.failed;
  }

  @action
  Future<void> login(LoginForm form) async {
    if (_loginFuture != null && _loginFuture.status == FutureStatus.pending)
      return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      _loginFuture = null;
      _lastLoginName = '';
      // debugPrint('user login request: $form');
      // Fetch from the repository and wrap the regular Future into an observable.
      _loginFuture = new ObservableFuture(_repository.login(form));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _loginFuture.then((value) => value.fold(
            (failure) => setErrorMsg(
              msg: MessageMap.getErrorMessage(failure.message, RouteEnum.LOGIN),
            ),
            (model) async {
              _lastLoginName = form.username.value;
              _infoStore.updateUser(LoginStatus(
                loggedIn: true,
                user: model.getData,
              ));
              // debugPrint('user info: ${model.getData}');
              Future.sync(() => (form.saveForm)
                      ? _saveToBox(form.toHive())
                      : _cleanHistoryBox())
                  .whenComplete(() {})
                  .whenComplete(() => _box.close());
            },
          ));
    } on Exception {
      setErrorMsg(code: 1);
    } finally {
      Future.delayed(Duration(milliseconds: 500), () => _loginFuture = null);
    }
  }

  @action
  Future<void> _saveToBox(LoginFormHive form) async {
    if (_box == null) {
      MyLogger.warn(msg: 'login history box not init', tag: tag);
      return;
    }
    if (_box.isEmpty) {
      await _box
          .add(form)
          .whenComplete(() => debugPrint('login history saved'))
          .catchError((e) => MyLogger.error(
              msg: 'save login history error: $_box', error: e, tag: tag));
    } else {
      await _box
          .putAt(0, form)
          .whenComplete(() => debugPrint('login history saved'))
          .catchError((e) => MyLogger.error(
              msg: 'save login history error: $_box', error: e, tag: tag));
    }
  }

  @action
  Future<void> _cleanHistoryBox() async {
    if (_box != null && _box.isNotEmpty) {
      await _box
          .clear()
          .whenComplete(() => debugPrint('login history cleared'))
          .catchError((e) => debugPrint('clean login history has error: $e'));
    }
  }

  void close() {
    try {
      closeHiveBox(Global.CACHE_LOGIN_FORM);
    } catch (e) {
      MyLogger.warn(
          msg: 'close login stream error', error: e, tag: 'LoginStore');
      return null;
    }
  }
}

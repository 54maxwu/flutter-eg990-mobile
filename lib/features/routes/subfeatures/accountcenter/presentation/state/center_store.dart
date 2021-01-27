import 'package:flutter_eg990_mobile/core/data/hive_actions.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_eg990_mobile/features/user/data/form/login_form.dart';
import 'package:hive/hive.dart';

import '../../data/entity/center_account_entity.dart';
import '../../data/entity/center_vip_entity.dart';
import '../../data/form/center_password_form.dart';
import '../../data/models/center_model.dart';
import '../../data/repository/center_repository.dart';

part 'center_store.g.dart';

class CenterStore = _CenterStore with _$CenterStore;

enum CenterStoreState { initial, loading, loaded, error }

enum CenterStoreAction {
  password,
  birth,
  email,
  wechat,
  lucky,
  verify_request,
  verify,
}

typedef CenterFutureTask(String data);

abstract class _CenterStore with Store {
  final CenterRepository _repository;

  final StreamController<CenterAccountEntity> _accountController =
      StreamController<CenterAccountEntity>.broadcast();
  final StreamController<CenterVipEntity> _vipController =
      StreamController<CenterVipEntity>.broadcast();

  _CenterStore(this._repository) {
    _accountController.stream.listen((event) {
      accountEntity = event;
      debugPrint('account data: $event');
      if (accountEntity == null) errorMessage = Failure.jsonFormat().message;
    });
    _vipController.stream.listen((event) {
      accountVip = event;
      debugPrint('account vip: $event');
      if (accountVip == null) errorMessage = Failure.jsonFormat().message;
    });
  }

  @observable
  ObservableFuture<Either<Failure, CenterModel>> _accountFuture;

  @observable
  bool accountDataReady = false;

  Box _loginDataBox;

  CenterAccountEntity accountEntity;
  CenterVipEntity accountVip;

  Stream<CenterAccountEntity> get accountStream => _accountController.stream;

  Stream<CenterVipEntity> get vipStream => _vipController.stream;

  CenterStoreAction currentRequest;

  @observable
  bool waitForResponse = false;

  @observable
  dynamic requestResponse;

  @observable
  String errorMessage;

  bool _errorState = false;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.CENTER,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  CenterStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_accountFuture == null ||
        _accountFuture.status == FutureStatus.rejected) {
      return CenterStoreState.initial;
    }
    if (_errorState) {
      return CenterStoreState.error;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _accountFuture.status == FutureStatus.pending || !accountDataReady
        ? CenterStoreState.loading
        : CenterStoreState.loaded;
  }

  @action
  Future<void> getAccount() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _accountFuture = ObservableFuture(_repository.getAccount());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _accountFuture.then((result) {
//        debugPrint('center data result: $result');
        result.fold(
          (failure) {
            setErrorMsg(msg: failure.message, showOnce: true);
            _errorState = true;
          },
          (model) {
            _accountController.sink.add(model.wrapAccountData);
            _vipController.sink.add(model.wrapVipData);
            accountDataReady = true;
          },
        );
      });
    } on Exception {
      _errorState = true;
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> initLoginDataBox() async {
    await getHiveBox(Global.CACHE_LOGIN_FORM)
        .then((value) => _loginDataBox = value);
  }

  @action
  Future<void> postPassword(CenterPasswordForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.password;
      await _repository.postPassword(form).then((result) {
//        debugPrint('center password result: $result');
        return result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) {
            if (data.isSuccess &&
                _loginDataBox != null &&
                _loginDataBox.isNotEmpty) {
              LoginHiveForm hiveForm = _loginDataBox.values?.last;
              if (hiveForm.account == accountEntity.accountCode) {
                LoginHiveForm newHiveForm = hiveForm.copyWith(password: '');
                Future.sync(() {
                  _loginDataBox
                      .putAt(0, newHiveForm)
                      .whenComplete(
                          () => debugPrint('Login Hive - data updated'))
                      .catchError((e) => MyLogger.error(
                          msg: 'Save error: $_loginDataBox',
                          error: e,
                          tag: 'CenterStore'));
                });
              }
            }
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      setErrorMsg(code: 2);
    }
  }

  void bindBirth(String dateOfBirth) async {
    _postStringData(
      dateOfBirth,
      CenterStoreAction.birth,
      _repository.postBirth,
      () => _accountController.sink
          .add(accountEntity.copyWith(birthDate: dateOfBirth)),
    );
  }

  void bindEmail(String email) async {
    _postStringData(
      email,
      CenterStoreAction.email,
      _repository.postEmail,
      () => _accountController.sink.add(accountEntity.copyWith(email: email)),
    );
  }

  void bindWechat(String wechatno) {
    _postStringData(
      wechatno,
      CenterStoreAction.wechat,
      _repository.postWechat,
      () =>
          _accountController.sink.add(accountEntity.copyWith(wechat: wechatno)),
    );
  }

  @action
  Future<void> _postStringData(
    String data,
    CenterStoreAction action,
    CenterFutureTask task,
    Function callback,
  ) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = action;
      await task(data).then((result) {
//        debugPrint('center $action result: $result');
        return result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (RequestStatusModel data) {
            if (data.isSuccess) callback();
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      setErrorMsg(code: 3);
    }
  }

  @action
  Future<void> postVerifyRequest(String mobile) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.verify_request;
      await _repository.postVerifyRequest(mobile).then((result) {
        debugPrint('center verify request result: $result');
        return result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => requestResponse = data,
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      setErrorMsg(code: 5);
    }
  }

  @action
  Future<void> postVerify(String mobile, String code) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.verify;
      await _repository.postVerify(mobile, code).then((result) {
        debugPrint('center verify result: $result');
        return result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) {
            if (data.isSuccess)
              Future.delayed(Duration(milliseconds: 300), () => getAccount());
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      errorMessage = Failure.internal(
        FailureCode(type: FailureType.CENTER, code: 6),
      ).message;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _accountController.close(),
        _vipController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close center stream error', error: e, tag: 'CenterStore');
      return null;
    }
  }
}

import 'dart:async';

import 'package:flutter_eg990_mobile/domain/response/request_code_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_repository.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'bankcard_store.g.dart';

class BankcardStore = _BankcardStore with _$BankcardStore;

enum BankcardStoreState { initial, loading, loaded }

abstract class _BankcardStore with Store {
  final BankcardRepository _repository;

  _BankcardStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, BankcardModel>> _initDataFuture;

  @observable
  BankcardModel bankcard;

  @observable
  Map<String, String> provinceMap;

  @observable
  Map<String, String> banksMap;

  @observable
  Map<String, String> cityMap;

  @observable
  Map<String, String> areaMap;

  @observable
  bool waitForNewCardResult = false;

  @observable
  RequestCodeModel newCardResult;

  @observable
  bool _mobileVerified = false;

  bool _lockVerify = false;

  bool get lockVerify => _lockVerify;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.HOME,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  BankcardStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (bankcard == null ||
        _initDataFuture == null ||
        _initDataFuture.status == FutureStatus.rejected) {
      return BankcardStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initDataFuture.status == FutureStatus.pending
        ? BankcardStoreState.loading
        : BankcardStoreState.loaded;
  }

  @action
  Future initialize() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch firt data from the repository and wrap the regular Future into an observable.
      // This _initDataFuture triggers widget updates to the computed state property.
      _initDataFuture = ObservableFuture(_repository.getBankcard());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initDataFuture.then((value) => value.fold(
            (fail) => setErrorMsg(msg: fail.message, showOnce: true),
            (data) => bankcard = data,
          ));
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('BankcardStore Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getBanks() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getBanks().then((result) {
//        debugPrint('bank ids map result: $result');
        result.fold(
          (failure) {
            setErrorMsg(msg: failure.message, showOnce: true);
            banksMap = new Map();
          },
          (data) => banksMap = (data != null) ? data : new Map(),
        );
      });
    } on Exception {
      setErrorMsg(code: 2);
    }
  }

  @action
  Future<void> getProvinces() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getProvinces().then((result) {
//        debugPrint('province map result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) {
            if (data != null && data.isNotEmpty) {
              provinceMap = data;
            }
          },
        );
      });
    } on Exception {
      setErrorMsg(code: 3);
    }
  }

  @action
  Future<void> getCities(String provinceCode, {bool showError = true}) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getMapByCode(provinceCode).then((result) {
//        debugPrint('city map result: $result');
        result.fold(
          (failure) {
            if (showError)
              setErrorMsg(msg: failure.message, showOnce: true);
            else
              debugPrint(failure.message);
          },
          (data) {
            if (data != null && data.isNotEmpty) cityMap = data;
          },
        );
      });
    } on Exception {
      setErrorMsg(code: 4);
    }
  }

  @action
  Future<void> getAreas(String cityCode) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getMapByCode(cityCode).then((result) {
//        debugPrint('area map result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) {
            if (data != null && data.isNotEmpty) areaMap = data;
          },
        );
      });
    } on Exception {
      setErrorMsg(code: 5);
    }
  }

  @action
  Future<void> postNewCard(BankcardForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      newCardResult = null;
      waitForNewCardResult = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postBankcard(form)
          .whenComplete(() => waitForNewCardResult = false)
          .then((result) {
        debugPrint('bind new bankcard result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message),
          (data) => newCardResult = data,
        );
      });
    } on Exception {
      waitForNewCardResult = false;
      setErrorMsg(code: 6);
    }
  }

  @action
  Future<bool> getVerifyCode(BankcardNewMobile form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      _lockVerify = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      return await _repository.requestMobileVerify(form).then(
            (result) => result.fold(
              (failure) {
                _lockVerify = false;
                setErrorMsg(msg: failure.message);
                return false;
              },
              (data) {
                debugPrint('send verify result = $data');
                _lockVerify = false;
                if (data.isSuccess) {
                  return true;
                } else {
                  setErrorMsg(msg: data.msg);
                  return false;
                }
              },
            ),
          );
    } on Exception {
      _lockVerify = false;
      setErrorMsg(code: 3);
      return false;
    }
  }

  @action
  Future<void> verifyMobile(BankcardNewMobile form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.postMobileVerifyCode(form).then(
            (result) => result.fold(
              (failure) => setErrorMsg(msg: failure.message),
              (data) {
                if (data.isSuccess) {
                  _mobileVerified = data.data;
                } else {
                  setErrorMsg(msg: data.msg);
                }
              },
            ),
          );
    } on Exception {
      setErrorMsg(code: 3);
    }
  }
}

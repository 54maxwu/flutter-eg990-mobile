import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';

import '../../data/form/withdraw_form.dart';
import '../../data/models/withdraw_model.dart';
import '../../data/repository/withdraw_repository.dart';

part 'withdraw_store.g.dart';

class WithdrawStore = _WithdrawStore with _$WithdrawStore;

enum WithdrawStoreState { initial, loading, loaded }

abstract class _WithdrawStore with Store {
  final WithdrawRepository _repository;

  _WithdrawStore(this._repository);

  @observable
  bool waitForWithdrawResult = false;

  @observable
  WithdrawModel withdrawResult;

  String rollback = '';

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.WITHDRAW,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @action
  Future<void> getRollback() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getRollback().then((result) {
        debugPrint('rollback result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => rollback = data,
        );
      });
    } on Exception {
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> sendRequest(WithdrawForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      withdrawResult = null;
      waitForWithdrawResult = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postWithdraw(form)
          .whenComplete(() => waitForWithdrawResult = false)
          .then((result) {
        debugPrint('withdraw result: $result');
        result.fold(
          (failure) {
            if (failure.message == 'amountMoreThanBalance')
              errorMessage = localeStr.messageInvalidWithdrawAmount;
            else if (failure.message == 'wrongPassword')
              errorMessage = localeStr.messageInvalidWithdrawPassword;
            else
              setErrorMsg(msg: failure.message, showOnce: true);
          },
          (data) => withdrawResult = data,
        );
      });
    } on Exception {
      waitForWithdrawResult = false;
      setErrorMsg(code: 4);
    }
  }
}

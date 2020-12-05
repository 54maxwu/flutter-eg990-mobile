import 'package:flutter_eg990_mobile/domain/sector/withdraw/withdraw_repository.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_model.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'withdraw_store.g.dart';

class WithdrawStore = _WithdrawStore with _$WithdrawStore;

enum WithdrawStoreState { initial, loading, loaded }

abstract class _WithdrawStore with Store {
  final WithdrawRepository _repository;

  _WithdrawStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, BankcardModel>> _bankcardFuture;

  @observable
  BankcardModel bankcard;

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

  @computed
  WithdrawStoreState get state {
    // If the user has not yet searched for a weather forecast or there has been an error
    if (_bankcardFuture == null ||
        _bankcardFuture.status == FutureStatus.rejected) {
      return WithdrawStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _bankcardFuture.status == FutureStatus.pending
        ? WithdrawStoreState.loading
        : WithdrawStoreState.loaded;
  }

  @action
  Future<void> getBankcard() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      _bankcardFuture = ObservableFuture(_repository.getBankcard());
      await _bankcardFuture.then((result) {
//        debugPrint('bankcard result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => bankcard = data,
        );
      });
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }
}

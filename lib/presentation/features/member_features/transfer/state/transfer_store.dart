import 'package:flutter_eg990_mobile/domain/sector/transfer/transfer_repository.dart';
import 'package:flutter_eg990_mobile/domain/sector/wallet/wallet_type.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'transfer_store.g.dart';

class TransferStore = _TransferStore with _$TransferStore;

enum TransferStoreState { initial, loading, loaded }

abstract class _TransferStore with Store {
  final TransferRepository _repository;

  _TransferStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, WalletType>> _walletTypeFuture;

  @observable
  WalletType walletType;

  bool waitForWalletTypeChange = false;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.TRANSFER,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  TransferStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (walletType == null ||
        _walletTypeFuture == null ||
        _walletTypeFuture.status == FutureStatus.rejected) {
      return TransferStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _walletTypeFuture.status == FutureStatus.pending
        ? TransferStoreState.loading
        : TransferStoreState.loaded;
  }

  @action
  Future<void> getWalletType() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _walletTypeFuture = ObservableFuture(_repository.getWalletType());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _walletTypeFuture.then((result) => result.fold(
            (failure) => setErrorMsg(msg: failure.message, showOnce: true),
            (data) {
              walletType = data;
              debugPrint('wallet type updated: $walletType');
            },
          ));
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> postWalletType(bool toSingle) async {
    if (waitForWalletTypeChange) return;
    try {
      debugPrint('change wallet to single: $toSingle');
      // Reset the possible previous error message.
      errorMessage = null;
      waitForWalletTypeChange = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postWalletType(toSingle)
          .then(
            (result) => result.fold(
              (failure) => setErrorMsg(msg: failure.message, showOnce: true),
              (data) {
                if (data == 'success') {
                  walletType =
                      (toSingle) ? WalletType.SINGLE : WalletType.MULTI;
                }
                // Future.delayed(Duration(milliseconds: 500), () => getWalletType());
              },
            ),
          )
          .whenComplete(() => waitForWalletTypeChange = false);
    } on Exception {
      waitForWalletTypeChange = false;
      setErrorMsg(code: 3);
    }
  }
}

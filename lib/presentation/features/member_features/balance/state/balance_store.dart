import 'dart:async';

import 'package:flutter_eg990_mobile/application/internal/error_message_map.dart';
import 'package:flutter_eg990_mobile/domain/sector/balance/balance_repository.dart';
import 'package:flutter_eg990_mobile/domain/sector/transfer/transfer_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/transfer/transfer_result.dart';
import 'package:flutter_eg990_mobile/domain/sector/withdraw/withdraw_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/withdraw/withdraw_model.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/balance/data/balance_grid_action.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'balance_store.g.dart';

class BalanceStore = _BalanceStore with _$BalanceStore;

enum BalanceStoreState { initial, loading, loaded }

abstract class _BalanceStore with Store {
  final BalanceRepository _repository;

  final StreamController<String> _loadingController =
      StreamController<String>.broadcast();

  _BalanceStore(this._repository);

  @observable
  ObservableFuture<List<void>> _initFuture;

  List<String> promises;
  int totalPlatform;
  Map<String, String> balanceMap;

  Stream<String> get loadingStream => _loadingController.stream;

  int balanceRequestProgress;

  @observable
  String balanceUpdated = '';

  @observable
  bool waitForTransferResult = false;

  @observable
  TransferResult transferResult;

  @observable
  bool waitForWithdrawResult = false;

  @observable
  WithdrawModel withdrawResult;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.BALANCE,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  BalanceStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return BalanceStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? BalanceStoreState.loading
        : BalanceStoreState.loaded;
  }

  @action
  Future<void> getInitializeData() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      balanceMap = new Map();
      // Fetch from the repository and wrap the regular Future into an observable.
      _initFuture = ObservableFuture(Future.wait([
        getWallet(),
        getPromises(),
      ]));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initFuture;
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getWallet() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getWallet().then(
            (result) => result.fold(
              (failure) => balanceMap['0'] = 'x',
              (data) {
                balanceMap[data.platform] = data.amount;
                debugPrint('add wallet balance to map: $data');
                balanceUpdated = data.platform;
              },
            ),
          );
    } catch (e) {
      setErrorMsg(code: 9);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getPromises() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getPromise().then(
            (result) => result.fold(
              (failure) => setErrorMsg(msg: failure.message, showOnce: true),
              (list) {
                // promises = list;
                // totalPlatform = list.length;
                promises = list.take(7).toList();
                totalPlatform = 7;
                // debugPrint('balance promise list: $list');
                if (promises.isNotEmpty) getBalances();
              },
            ),
          );
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getBalances() async {
    try {
      // Fetch from the repository and wrap the regular Future into an observable.
      Future.forEach(
        promises,
        (platform) =>
            Future.microtask(() => getBalanceSilent(platform)).whenComplete(() {
          balanceRequestProgress = balanceMap.length - 1;
          if (balanceRequestProgress == totalPlatform) {
            _loadingController.sink.add('');
            balanceRequestProgress = -1;
            Future.delayed(
              Duration(milliseconds: 100),
              () => balanceUpdated = null,
            );
          } else {
            _loadingController.sink
                .add('$balanceRequestProgress / $totalPlatform');
          }
        }),
      );
    } catch (e) {
      setErrorMsg(code: 2);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getBalanceSilent(String platform) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getBalance(platform).then(
        (result) {
          result.fold(
            (failure) => balanceMap[platform] = 'x',
            (data) {
              balanceMap[data.platform] = data.amount;
              debugPrint('add balance to map: $data');
              balanceUpdated = data.platform;
            },
          );
        },
      );
    } catch (e) {
      setErrorMsg(code: 3);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getBalance(String platform) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      balanceUpdated = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getBalance(platform).then(
        (result) {
          result.fold(
            (failure) => balanceMap[platform] = 'x',
            (data) {
              balanceMap[data.platform] = data.amount;
              debugPrint('add balance to map: $data');
              balanceUpdated = data.platform;
            },
          );
        },
      );
    } catch (e) {
      setErrorMsg(code: 4);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> exeGridAction(BalanceGridAction action) async {
    debugPrint('execute grid action: $action');
    // if (action.type.index <= 1) waitForTransferResult = true;
    //
    // switch (action.type) {
    //   case BalanceGridActionType.transferIn:
    //     int userCredit = action.userCredit.strToInt;
    //     if (userCredit > 1) {
    //       postTransfer(
    //         TransferForm(
    //           from: '0',
    //           to: action.platform,
    //           amount: '$userCredit',
    //         ),
    //       );
    //     } else {
    //       waitForTransferResult = false;
    //       errorMessage =
    //           localeStr.balanceTransferAmountError('$creditSymbol$userCredit');
    //     }
    //     break;
    //   case BalanceGridActionType.transferOut:
    //     var credit = balanceMap[action.platform].strToDouble;
    //     debugPrint('platform limit: $credit');
    //     if (credit >= 1) {
    //       postTransfer(
    //         TransferForm(
    //           from: action.platform,
    //           to: '0',
    //           amount: '${credit.floor()}',
    //         ),
    //       );
    //     } else {
    //       waitForTransferResult = false;
    //       errorMessage =
    //           localeStr.balanceTransferAmountError('$creditSymbol$credit');
    //     }
    //     break;
    //   case BalanceGridActionType.refresh:
    //     getBalance(action.platform);
    //     break;
    // }
  }

  @action
  Future<void> postTransfer(TransferForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      transferResult = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postTransfer(form)
          .whenComplete(() => waitForTransferResult = false)
          .then((result) {
        debugPrint('transfer from ${form.from} to ${form.to} result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) {
            transferResult = data;
            if (data.isSuccess) {
              Future.delayed(Duration(milliseconds: 500), () {
                (form.from == '0')
                    ? getBalance(form.to)
                    : getBalance(form.from);
              });
            }
          },
        );
      });
    } on Exception {
      waitForTransferResult = false;
      setErrorMsg(code: 5);
    }
  }

  @action
  Future<void> postWithdraw(WithdrawForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      withdrawResult = null;
      waitForWithdrawResult = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.postWithdraw(form).then((result) {
        debugPrint('withdraw result: $result');
        result.fold(
          (failure) => setErrorMsg(
            msg: MessageMap.getErrorMessage(
              failure.message,
              RouteEnum.WITHDRAW,
            ),
          ),
          (data) => withdrawResult = data,
        );
      }).whenComplete(() => waitForWithdrawResult = false);
    } on Exception {
      waitForWithdrawResult = false;
      setErrorMsg(code: 4);
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _loadingController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close balance stream error', error: e, tag: 'BalanceStore');
      return null;
    }
  }
}

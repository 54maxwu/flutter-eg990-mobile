import 'package:flutter_eg990_mobile/domain/sector/deposit/deposit_repository.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/form/deposit_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/info/deposit_info.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/promo/deposit_promos.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/result/deposit_result.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_types.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'deposit_store.g.dart';

class DepositStore = _DepositStore with _$DepositStore;

enum DepositStoreState { initial, loading, loaded, error }

abstract class _DepositStore with Store {
  final DepositRepository _repository;

  _DepositStore(this._repository);

  @observable
  ObservableFuture<void> _initFuture;

  // stores deposit methods by type
  // key:1 = local, key:2 = online
  List<DepositType> depositTypes;

  // stores all deposit methods, can be identify by data type
  // [DepositMethodOnline], [DepositMethodLocal]
  List<DepositMethod> depositMethods;

  DepositPromos promos;

  Map<int, String> ruleMap;

  Map<int, String> bankMap;

  @observable
  List<DepositInfo> infoList;

  @observable
  bool waitForDepositResult = false;

  @observable
  DepositResult depositResult;

  @observable
  String errorMessage;

  bool _errorState = false;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.DEPOSIT,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  DepositStoreState get state {
    // If the user has not yet searched for a weather forecast or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return DepositStoreState.initial;
    }
    if (_errorState) return DepositStoreState.error;
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? DepositStoreState.loading
        : DepositStoreState.loaded;
  }

  @action
  Future getInitializeData() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _initFuture = ObservableFuture(Future.wait([
        // if (depositTypes == null)
        //   Future.value(getTypes()).whenComplete(() {
        //     if (infoList == null) getDepositInfo();
        //   }),
        if (depositMethods == null) Future.value(getTypes()),
        // if (promos == null) Future.value(getPromos()),
        // if (bankMap == null) Future.value(getBankMap()),
        // if (ruleMap == null) Future.value(getRuleMap()),
      ]));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initFuture;
    } on Exception {
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> getTypes() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getTypes().then((result) {
        // debugPrint('deposit store type result: $result');
        result.fold(
          (failure) {
            setErrorMsg(msg: failure.message, showOnce: true);
            _errorState = true;
          },
          (data) {
            depositTypes = data;
            depositMethods = new List();
            depositTypes?.forEach((type) {
              debugPrint(
                  'deposit type, key:${type.key}, data: ${type.dataList}');
              switch (type.key) {
                case 1:
                  depositMethods.add(DepositMethodLocal(
                    banks: type.dataList
                        .map((e) => e as DepositMethodBankData)
                        .toList(),
                  ));
                  break;
                case 2:
                  depositMethods.add(DepositMethodOnline(
                    options: type.dataList
                        .map((e) => e as DepositMethodVirtualData)
                        .toList(),
                  ));
                  break;
                default:
                  depositMethods.addAll(type.dataList);
                  break;
              }
            });
            debugPrint('deposit methods: $depositMethods');
          },
        );
      });
    } on Exception {
      _errorState = true;
      setErrorMsg(code: 2);
    }
  }

  @action
  Future<void> getPromos() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getPromos().then((result) {
//        debugPrint('deposit store promo result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => promos = data,
        );
      });
    } catch (e) {
      setErrorMsg(code: 3);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getDepositInfo() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getDepositInfo().then((result) {
//        debugPrint('deposit info result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (list) {
            if (list != null &&
                list.isNotEmpty &&
                depositTypes.any((type) => type.key == 1)) {
              DepositMethodLocal local = depositMethods.singleWhere(
                  (value) => value is DepositMethodLocal,
                  orElse: () => DepositMethodLocal());
              if (local.banks.isEmpty) {
                infoList = [];
              } else {
                // filtered out unavailable bank options
                infoList = List.of(list)
                  ..removeWhere((info) => local.banks.any(
                      (data) => !(data.bankAccountId == info.bankAccountId)));
              }
            } else {
              infoList = [];
            }
//            debugPrint('deposit info: $infoList');
          },
        );
      });
    } catch (e) {
      setErrorMsg(code: 4);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getBankMap() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getBankMap().then((result) {
//        debugPrint('deposit banks result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => bankMap = data,
        );
      });
    } catch (e) {
      setErrorMsg(code: 5);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getRuleMap() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getRuleMap().then((result) {
//        debugPrint('deposit rule result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => ruleMap = data,
        );
      });
    } catch (e) {
      setErrorMsg(code: 6);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> postDeposit(DepositForm form) async {
    try {
      if (waitForDepositResult) return;
      // Reset the possible previous error message.
      errorMessage = null;
      depositResult = null;
      waitForDepositResult = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postDeposit(form)
          .whenComplete(() => waitForDepositResult = false)
          .then((result) {
//        debugPrint('deposit store promo result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message),
          (data) => depositResult = data,
        );
      });
    } on Exception {
      waitForDepositResult = false;
      setErrorMsg(code: 7);
    }
  }
}

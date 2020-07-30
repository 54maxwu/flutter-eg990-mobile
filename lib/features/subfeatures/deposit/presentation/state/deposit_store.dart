import 'package:flutter_ty_mobile/core/mobx_store_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deposit/data/entity/payment_enum.dart';

import '../../data/form/deposit_form.dart';
import '../../data/model/deposit_result.dart';
import '../../data/model/payment_freezed.dart';
import '../../data/model/payment_promo.dart';
import '../../data/model/payment_raw.dart';
import '../../data/repository/deposit_repository.dart';

part 'deposit_store.g.dart';

class DepositStore = _DepositStore with _$DepositStore;

enum DepositStoreState { initial, loading, loaded }

abstract class _DepositStore with Store {
  final DepositRepository _repository;

  _DepositStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, PaymentRaw>> _paymentFuture;

  Map<int, List<PaymentFreezed>> paymentMap;

  @observable
  List<PaymentEnum> paymentTypes;

  @observable
  ObservableFuture<Either<Failure, PaymentPromoTypeJson>> _promoFuture;

  Map<int, List<PaymentPromoData>> promoMap;

  @observable
  ObservableFuture<Either<Failure, DepositResult>> _depositFuture;

  @observable
  bool waitForDepositResult = false;

  @observable
  DepositResult depositResult;

  @observable
  String errorMessage;

  @computed
  DepositStoreState get state {
    // If the user has not yet searched for a weather forecast or there has been an error
    if (_paymentFuture == null ||
        _paymentFuture.status == FutureStatus.rejected) {
      return DepositStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _paymentFuture.status == FutureStatus.pending ||
            _promoFuture.status == FutureStatus.pending
        ? DepositStoreState.loading
        : DepositStoreState.loaded;
  }

  @action
  Future<void> getPaymentType() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _paymentFuture = ObservableFuture(_repository.getPayment());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _paymentFuture.then((result) {
//        print('payment store type result: $result');
        result.fold(
          (failure) {
            errorMessage = failure.message;
          },
          (data) {
            paymentMap = data.mapDataList;
            print('payment map: $paymentMap');
          },
        );
      });
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.DEPOSIT)).message;
    }
  }

  @action
  Future<void> getPaymentPromo() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _promoFuture = ObservableFuture(_repository.getPaymentPromo());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _promoFuture.then((result) {
        print('payment store promo result: $result');
        result.fold(
          (failure) {
            errorMessage = failure.message;
          },
          (data) {
            promoMap ??= new Map();
            promoMap[1] = data.getDataList(true);
            promoMap[2] = data.getDataList(false);
            print('payment promo map: $promoMap');
          },
        );
      });
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.DEPOSIT)).message;
    }
  }

  void generateEnumList() {
    if (paymentMap.isEmpty) {
      errorMessage = Failure.jsonFormat().message;
    } else {
      List<PaymentEnum> list = new List();
      PaymentEnum.valueMap.forEach((key, value) {
        if (paymentMap.containsKey(key)) list.add(value);
      });
      paymentTypes = list;
      print('payment types: $paymentTypes');
    }
  }

  @action
  Future<void> sendRequest(DepositDataForm form) async {
    try {
      if (waitForDepositResult) return;
      // Reset the possible previous error message.
      errorMessage = null;
      depositResult = null;
      waitForDepositResult = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      _depositFuture = ObservableFuture(_repository.postDeposit(form));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _depositFuture
          .whenComplete(() => waitForDepositResult = false)
          .then((result) {
        print('payment store promo result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) => depositResult = data,
        );
      });
    } on Exception {
      waitForDepositResult = false;
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.DEPOSIT)).message;
    }
  }
}

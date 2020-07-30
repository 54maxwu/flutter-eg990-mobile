import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/core/mobx_store_export.dart';

import '../../data/repository/bankcard_repository.dart';
import '../../data/form/bankcard_form.dart';
import '../../data/models/bankcard_model.dart';

part 'bankcard_store.g.dart';

class BankcardStore = _BankcardStore with _$BankcardStore;

enum BankcardStoreState { initial, loading, loaded }

abstract class _BankcardStore with Store {
  final BankcardRepository _repository;

  _BankcardStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, BankcardModel>> _bankcardFuture;

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
  RequestStatusModel newCardResult;

  @observable
  String errorMessage;

  @computed
  BankcardStoreState get state {
    // If the user has not yet searched for a weather forecast or there has been an error
    if (_bankcardFuture == null ||
        _bankcardFuture.status == FutureStatus.rejected) {
      return BankcardStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _bankcardFuture.status == FutureStatus.pending
        ? BankcardStoreState.loading
        : BankcardStoreState.loaded;
  }

  @action
  Future<void> getBankcard() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch weather from the repository and wrap the regular Future into an observable.
      // This _weatherFuture triggers updates to the computed state property.
      _bankcardFuture = ObservableFuture(_repository.getBankcard());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _bankcardFuture.then((result) {
//        print('bankcard result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) => bankcard = data,
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch bankcard. Is the device online?";
    }
  }

  @action
  Future<void> getBanks() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getBanks().then((result) {
//        print('bank ids map result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            if (data != null) banksMap = data;
          },
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch bank ids. Is the device online?";
    }
  }

  @action
  Future getProvinces() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getProvinces().then((result) {
//        print('province map result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            if (data != null && data.isNotEmpty) {
              provinceMap = data;
            }
          },
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch provinces. Is the device online?";
    }
  }

  @action
  Future getCities(String provinceCode, {bool showError = true}) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getMapByCode(provinceCode).then((result) {
//        print('city map result: $result');
        result.fold(
          (failure) {
            if (showError)
              errorMessage = failure.message;
            else
              print(failure.message);
          },
          (data) {
            if (data != null && data.isNotEmpty) cityMap = data;
          },
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch cities. Is the device online?";
    }
  }

  @action
  Future getAreas(String cityCode) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getMapByCode(cityCode).then((result) {
//        print('area map result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            if (data != null && data.isNotEmpty) areaMap = data;
          },
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch areas. Is the device online?";
    }
  }

  @action
  Future sendRequest(BankcardForm form) async {
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
        print('bankcard bind result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) => newCardResult = data,
        );
      });
    } on Exception {
      waitForNewCardResult = false;
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.BANKCARD)).message;
    }
  }
}

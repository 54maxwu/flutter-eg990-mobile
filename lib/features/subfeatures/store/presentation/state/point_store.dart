import 'package:flutter_ty_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/core/mobx_store_export.dart';

import '../../data/form/store_exchange_form.dart';
import '../../data/form/store_exchange_history_form.dart';
import '../../data/models/store_banner_model.dart';
import '../../data/models/store_exchange_model.dart';
import '../../data/models/store_product_model.dart';
import '../../data/models/store_rules_model.dart';
import '../../data/repository/store_repository.dart';

part 'point_store.g.dart';

class PointStore = _PointStore with _$PointStore;

enum PointStoreState { initial, loading, loaded }

abstract class _PointStore with Store {
  final StoreRepository _repository;

  final StreamController<num> _pointController =
      StreamController<num>.broadcast();
  final StreamController<StoreExchangeModel> _recordController =
      StreamController<StoreExchangeModel>.broadcast();

  _PointStore(this._repository) {
    _pointController.stream.listen((event) {
      print('member point: $event');
      if (event == null) errorMessage = Failure.jsonFormat().message;
      memberPoints = event;
    });
  }

  @observable
  ObservableFuture<List> _initFuture;

  List<StoreProductModel> products;

  List<StoreBannerModel> banners;

  StoreRulesModel rulesModel;

  Stream<num> get pointStream => _pointController.stream;

  Stream<StoreExchangeModel> get recordStream => _recordController.stream;

  num memberPoints = 0;

  @observable
  Map<String, String> provinceMap;

  @observable
  Map<String, String> cityMap;

  @observable
  Map<String, String> areaMap;

  @observable
  String errorMessage;

  @observable
  bool waitForInitializeData = false;

  @observable
  bool waitForExchange = false;

  @observable
  dynamic exchangeResult;

  @observable
  bool waitForRecord = false;

  @computed
  PointStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return PointStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? PointStoreState.loading
        : PointStoreState.loaded;
  }

  @action
  Future<void> getInitializeData() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForInitializeData = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      _initFuture = ObservableFuture(Future.wait([
        Future.value(
          _repository.getProduct().then(
                (result) => result.fold(
                  (failure) => errorMessage = failure.message,
                  (list) => products = list,
                ),
              ),
        ),
        Future.value(
          _repository.getBanners().then(
                (result) => result.fold(
                  (failure) => errorMessage = failure.message,
                  (list) => banners = list,
                ),
              ),
        ),
        Future.value(
          _repository.getPoint().then(
                (result) => result.fold(
                  (failure) => errorMessage = failure.message,
                  (value) => _pointController.sink.add(value),
                ),
              ),
        ),
        Future.value(
          _repository.getRules().then(
                (result) => result.fold(
                  (failure) => errorMessage = failure.message,
                  (value) => rulesModel = value,
                ),
              ),
        ),
      ]));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initFuture.whenComplete(() => waitForInitializeData = false);
    } on Exception {
      waitForInitializeData = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  @action
  Future<void> getProvinces() async {
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
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  @action
  Future<void> getCities(String provinceCode, {bool showError = true}) async {
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
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  @action
  Future<void> getAreas(String cityCode) async {
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
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  @action
  Future<void> exchangeProduct(StoreExchangeForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      exchangeResult = null;
      waitForExchange = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.postExchange(form).then((result) {
//        print('store exchange result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (model) {
            exchangeResult = model;
            if ((exchangeResult is RequestCodeModel ||
                    exchangeResult is RequestStatusModel) &&
                exchangeResult.isSuccess) {
              _repository.getPoint().then(
                    (result) => result.fold(
                      (failure) => errorMessage = failure.message,
                      (value) => _pointController.sink.add(value),
                    ),
                  );
            }
          },
        );
      }).whenComplete(() => waitForExchange = false);
    } on Exception {
      waitForExchange = false;
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  @action
  Future<void> getRules() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getRules().then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (value) => rulesModel = value,
            ),
          );
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  @action
  Future<void> getRecord({StoreExchangeHistoryForm form}) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForRecord = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .getExchange(form ?? StoreExchangeHistoryInit())
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (value) => _recordController.sink.add(value),
            ),
          )
          .whenComplete(() => waitForRecord = false);
    } on Exception {
      waitForRecord = false;
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.STORE)).message;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _pointController.close(),
        _recordController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close agent stream error', error: e, tag: 'AgentStore');
      return null;
    }
  }
}

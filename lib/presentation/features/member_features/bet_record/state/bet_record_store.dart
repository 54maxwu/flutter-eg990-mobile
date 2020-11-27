import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_query_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_repository.dart';
import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_type.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'bet_record_store.g.dart';

class BetRecordStore = _BetRecordStore with _$BetRecordStore;

enum BetRecordStoreState { initial, loading, loaded }

abstract class _BetRecordStore with Store {
  final BetRecordRepository _repository;

  _BetRecordStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, List<BetRecordType>>> _typeFuture;

  List<BetRecordType> typeList;

  bool get hasValidData => typeList != null && typeList.isNotEmpty;

  @observable
  dynamic records;

  @observable
  bool waitForRecordResponse = false;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.BETS,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  BetRecordStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_typeFuture == null || _typeFuture.status == FutureStatus.rejected) {
      return BetRecordStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _typeFuture.status == FutureStatus.pending
        ? BetRecordStoreState.loading
        : BetRecordStoreState.loaded;
  }

  @action
  Future<void> getTypes() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _typeFuture = ObservableFuture(_repository.getTypeData());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _typeFuture.then(
        (result) => result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (list) {
            debugPrint('bet record types: ${list.length}');
            typeList = list;
          },
        ),
      );
    } on Exception {
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> getRecord(BetRecordQueryForm form) async {
    try {
      if (waitForRecordResponse) return;
      // Reset the possible previous error message.
      waitForRecordResponse = true;
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      if (form.queryAllPlatform) {
        await _repository
            .getRecordAll(form)
            .then(
              (result) => result.fold(
                (failure) => setErrorMsg(msg: failure.message, showOnce: true),
                (list) {
                  debugPrint('${form.target} bet platform records: $list');
                  records = new List.from(list);
                },
              ),
            )
            .whenComplete(() => waitForRecordResponse = false);
      } else {
        await _repository
            .getRecord(form)
            .then(
              (result) => result.fold(
                (failure) => setErrorMsg(msg: failure.message, showOnce: true),
                (BetRecordModel model) {
                  debugPrint('${form.target} bet records: $model');
                  records = model.copyWith();
                },
              ),
            )
            .whenComplete(() => waitForRecordResponse = false);
      }
    } on Exception {
      waitForRecordResponse = false;
      setErrorMsg(code: 2);
    }
  }
}

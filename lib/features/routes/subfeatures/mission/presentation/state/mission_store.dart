import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_code_model.dart';

import '../../data/entity/mission_claim_form.dart';
import '../../data/models/mission_list_model.dart';
import '../../data/models/mission_model.dart';
import '../../data/repository/mission_repository.dart';

part 'mission_store.g.dart';

class MissionStore = _MissionStore with _$MissionStore;

enum MissionStoreState { initial, loading, loaded }

abstract class _MissionStore with Store {
  final MissionRepository _repository;

  _MissionStore(this._repository);

  final StreamController<MapEntry<int, MissionStatus>>
      _missionUpdateController =
      StreamController<MapEntry<int, MissionStatus>>.broadcast();

  Stream<MapEntry<int, MissionStatus>> get updateStream =>
      _missionUpdateController.stream;

  @observable
  ObservableFuture<Either<Failure, MissionListModel>> initDataFuture;

  @observable
  MissionListModel initData;

  String rules;

  @observable
  bool waitForPrizeResult = false;

  @observable
  RequestCodeModel prizeResult;

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
  MissionStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (initData == null ||
        initDataFuture == null ||
        initDataFuture.status == FutureStatus.rejected) {
      return MissionStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return initDataFuture.status == FutureStatus.pending
        ? MissionStoreState.loading
        : MissionStoreState.loaded;
  }

  @action
  Future<void> initialize() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch first data from the repository and wrap the regular Future into an observable.
      // This _initDataFuture triggers widget updates to the computed state property.
      initDataFuture = ObservableFuture(_repository.getMissions());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await initDataFuture
          .then((value) => value.fold(
                (fail) => setErrorMsg(msg: fail.message, showOnce: true),
                (result) => initData = result,
              ))
          .whenComplete(() => Future.microtask(() => getRules()));
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('MissionStore Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> getRules() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch data from the repository, observable values triggers [Observer]
      // widget updates when value change, or pass the changes to reaction.
      await _repository.getRules().then((value) => value.fold(
            (fail) => rules = fail.message,
            (result) => rules = '${result.data}',
          ));
    } catch (e) {
      setErrorMsg(code: 2);
      debugPrint('MissionStore Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> claimPrize(MissionClaimForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      prizeResult = null;
      waitForPrizeResult = true;
      _missionUpdateController.sink
          .add(MapEntry(form.prizeId, MissionStatus.LOADING));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postClaimPrize(form)
          .whenComplete(() => waitForPrizeResult = false)
          .then((result) {
        debugPrint('claim prize result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message),
          (result) {
            prizeResult = result;
            _missionUpdateController.sink.add(
              MapEntry(
                  form.prizeId,
                  (result.isSuccess)
                      ? MissionStatus.RECEIVED
                      : MissionStatus.COMPLETE),
            );
          },
        );
      });
    } catch (e) {
      waitForPrizeResult = false;
      setErrorMsg(code: 3);
      debugPrint('MissionStore Error: $errorMessage, Exception: $e');
    }
  }

  dispose() {
    try {
      _missionUpdateController?.close();
    } on Exception {}
  }
}

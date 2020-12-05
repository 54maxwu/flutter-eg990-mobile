import 'package:flutter_eg990_mobile/domain/sector/notice_board/notice_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/notice_board/notice_repository.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'notice_store.g.dart';

class NoticeStore = _NoticeStore with _$NoticeStore;

enum NoticeStoreState { initial, loading, loaded }

abstract class _NoticeStore with Store {
  final NoticeRepository _repository;

  _NoticeStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, Map<String, List<NoticeData>>>> _initFuture;

  Map<String, List<NoticeData>> notice;

  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.NOTICE,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  NoticeStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return NoticeStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? NoticeStoreState.loading
        : NoticeStoreState.loaded;
  }

  @action
  Future<void> initialize() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _initFuture = ObservableFuture(_repository.getRemind());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initFuture.then(
        (result) => result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (model) {
            notice = model;
            debugPrint('notice: $notice');
          },
        ),
      );
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('Error: $errorMessage, Exception: $e');
    }
  }
}

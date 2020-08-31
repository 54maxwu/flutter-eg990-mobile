import 'package:flutter_eg990_mobile/core/data/hive_actions.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/features/event/data/models/event_model.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import '../../data/models/ad_model.dart';
import '../../data/repository/event_repository.dart';

part 'event_store.g.dart';

class EventStore = _EventStore with _$EventStore;

enum EventStoreState { initial, loading, loaded }

abstract class _EventStore with Store {
  final EventRepository _repository;

  final StreamController<List<AdModel>> _adsController =
      StreamController<List<AdModel>>.broadcast();

  _EventStore(this._repository) {
    _adsController.stream.listen((event) {
//      print('home stream ads: ${event.length}');
      ads = event;
    });
  }

  /// Event
  EventModel _event;

  // Observer is in [ScreenNavigationBar]
  @observable
  bool showEventOnHome = false;

  @observable
  bool hasSignedEvent = false;

  int signedTimes;

  bool forceShowEvent = false;

  EventModel get event => _event;

  bool get hasEvent =>
      _event.hasData &&
      _event.userLevelMatchEvent(getAppGlobalStreams.userLevel ?? 0);

  String getEventError() => errorMessage;

  set setShowEvent(bool show) {
    showEventOnHome = show;
  }

  set setForceShowEvent(bool show) {
    showEventOnHome = (!show) ? showEventOnHome : true;
    forceShowEvent = show;
  }

  /// Message
  @observable
  bool hasNewMessage = false;

  /// Ads
  //Stream builder is in [HomeDisplay]
  Stream<List<AdModel>> get adsStream => _adsController.stream;

  List<AdModel> ads;

  final String skipAdsKey = 'skipAds';

  bool _skipAds = false;

  bool _showOnStartup = true;

  bool _showingAds = false;

  bool get canShowAds => !_showingAds;

  bool get checkSkip => _skipAds;

  bool get autoShowAds => !_showingAds && _showOnStartup && !_skipAds;

  @observable
  String errorMessage;

  @action
  Future<void> getWebsiteList() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _repository.getWebsiteList().then((result) {
      debugPrint('website list result: $result');
      result.fold(
        (failure) => errorMessage = failure.message,
        (value) {},
      );
    });
  }

  @action
  Future<void> getNewMessageCount() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.checkNewMessage().then((result) {
        debugPrint('new message result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (value) => hasNewMessage = value,
        );
      });
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.EVENT)).message;
    }
  }

  @action
  Future<void> getEvent() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _repository.getEvent().then((result) {
      print('event result: $result');
      result.fold(
        (failure) => errorMessage = failure.message,
        (model) {
          _event = model;
          showEventOnHome =
              _event.showDialog(getAppGlobalStreams.userLevel ?? 0);
          forceShowEvent = false;
          hasSignedEvent = !(_event.canSign);
          signedTimes = _event.signData?.times ?? 0;
          print('event show: $showEventOnHome, has signed: $hasSignedEvent');
        },
      );
    });
  }

  @action
  Future<bool> signEvent() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    return await _repository
        .signEvent(_event.eventData.id, _event.eventData.prize)
        .then((result) {
      print('event result: $result');
      return result.fold(
        (failure) {
          errorMessage = failure.message;
          return false;
        },
        (model) async {
          if (model.isSuccess == false) {
            errorMessage = localeStr.eventButtonSignUpFailed;
          } else if (model.data is bool) {
            showEventOnHome = false;
            forceShowEvent = false;
            hasSignedEvent = true;
            signedTimes = (_event.signData?.times ?? 0) + 1;
            getEvent();
            return true;
          } else if (model.data is Map) {
            String msg = model.data['msg'];
            errorMessage = (msg == 'alreadySign')
                ? localeStr.eventButtonSignUpAlready
                : msg;
          }
          return false;
        },
      );
    });
  }

  void debugEvent() {
    print('Event: $_event');
    print('Event can sign: ${_event.canSign}');
    print('Has Event? $hasEvent');
    print('Has Signed? $hasSignedEvent');
  }

  @action
  Future<void> getAds() async {
    if (ads != null && ads.isNotEmpty) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Read setting
      Box box = await Future.value(getHiveBox(Global.CACHE_APP_DATA));
      if (box != null && box.isNotEmpty) {
        _skipAds = (box.containsKey(skipAdsKey)) ? box.get(skipAdsKey) : false;
      }
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getAds().then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (list) => _adsController.sink.add(List.from(list)),
            ),
          );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.EVENT)).message;
    }
  }

  void setSkipAd(bool value) {
    if (_skipAds == value) return;
    _skipAds = value;
    Future.microtask(() async {
      bool saveValue = _skipAds;
      if (saveValue) {
        Box box = await Future.value(getHiveBox(Global.CACHE_APP_DATA));
        if (box != null) {
          await box.putAll({skipAdsKey: saveValue});
          print('box ads: ${box.get(skipAdsKey)}');
        }
      }
      print('box saved: $skipAdsKey - $saveValue');
    });
  }

  void adsDialogClose() => _showingAds = false;

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _adsController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close event stream error', error: e, tag: 'EventStore');
      return null;
    }
  }
}

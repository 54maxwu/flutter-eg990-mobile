import 'dart:async';

import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/domain/sector/ads/ad_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/ads/ads_repository.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

part 'ads_store.g.dart';

class AdStore = _AdStore with _$AdStore;

enum AdStoreState { initial, loading, loaded }

abstract class _AdStore with Store {
  final AdsRepository _repository;

  _AdStore(this._repository);

  @observable
  List<AdModel> ads;

  final String skipAdsKey = 'skipAds';

  bool _skipAds = false;

  bool _showOnStartup = true;

  bool _showingAds = false;

  bool get canShowAds => !_showingAds;

  bool get checkSkip => _skipAds;

  bool get autoShowAds => !_showingAds && _showOnStartup && !_skipAds;

  set setAutoShowAds(bool auto) => _showOnStartup = auto;

  void adsDialogClose() => _showingAds = false;

  /// Error
  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.EVENT,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

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
              (failure) => setErrorMsg(msg: failure.message, showOnce: true),
              (list) => ads = List.from(list),
            ),
          );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      setErrorMsg(code: 2);
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
          debugPrint('box ads: ${box.get(skipAdsKey)}');
        }
      }
      debugPrint('box saved: $skipAdsKey - $saveValue');
    });
  }
}

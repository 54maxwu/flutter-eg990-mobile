// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdStore on _AdStore, Store {
  final _$adsAtom = Atom(name: '_AdStore.ads');

  @override
  List<AdModel> get ads {
    _$adsAtom.reportRead();
    return super.ads;
  }

  @override
  set ads(List<AdModel> value) {
    _$adsAtom.reportWrite(value, super.ads, () {
      super.ads = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_AdStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$getAdsAsyncAction = AsyncAction('_AdStore.getAds');

  @override
  Future<void> getAds() {
    return _$getAdsAsyncAction.run(() => super.getAds());
  }

  @override
  String toString() {
    return '''
ads: ${ads},
errorMessage: ${errorMessage}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MissionStore on _MissionStore, Store {
  Computed<MissionStoreState> _$stateComputed;

  @override
  MissionStoreState get state =>
      (_$stateComputed ??= Computed<MissionStoreState>(() => super.state,
              name: '_MissionStore.state'))
          .value;

  final _$initDataFutureAtom = Atom(name: '_MissionStore.initDataFuture');

  @override
  ObservableFuture<Either<Failure, MissionListModel>> get initDataFuture {
    _$initDataFutureAtom.reportRead();
    return super.initDataFuture;
  }

  @override
  set initDataFuture(
      ObservableFuture<Either<Failure, MissionListModel>> value) {
    _$initDataFutureAtom.reportWrite(value, super.initDataFuture, () {
      super.initDataFuture = value;
    });
  }

  final _$initDataAtom = Atom(name: '_MissionStore.initData');

  @override
  MissionListModel get initData {
    _$initDataAtom.reportRead();
    return super.initData;
  }

  @override
  set initData(MissionListModel value) {
    _$initDataAtom.reportWrite(value, super.initData, () {
      super.initData = value;
    });
  }

  final _$waitForPrizeResultAtom =
      Atom(name: '_MissionStore.waitForPrizeResult');

  @override
  bool get waitForPrizeResult {
    _$waitForPrizeResultAtom.reportRead();
    return super.waitForPrizeResult;
  }

  @override
  set waitForPrizeResult(bool value) {
    _$waitForPrizeResultAtom.reportWrite(value, super.waitForPrizeResult, () {
      super.waitForPrizeResult = value;
    });
  }

  final _$prizeResultAtom = Atom(name: '_MissionStore.prizeResult');

  @override
  RequestCodeModel get prizeResult {
    _$prizeResultAtom.reportRead();
    return super.prizeResult;
  }

  @override
  set prizeResult(RequestCodeModel value) {
    _$prizeResultAtom.reportWrite(value, super.prizeResult, () {
      super.prizeResult = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_MissionStore.errorMessage');

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

  final _$initializeAsyncAction = AsyncAction('_MissionStore.initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  final _$getRulesAsyncAction = AsyncAction('_MissionStore.getRules');

  @override
  Future<void> getRules() {
    return _$getRulesAsyncAction.run(() => super.getRules());
  }

  final _$claimPrizeAsyncAction = AsyncAction('_MissionStore.claimPrize');

  @override
  Future<void> claimPrize(MissionClaimForm form) {
    return _$claimPrizeAsyncAction.run(() => super.claimPrize(form));
  }

  @override
  String toString() {
    return '''
initDataFuture: ${initDataFuture},
initData: ${initData},
waitForPrizeResult: ${waitForPrizeResult},
prizeResult: ${prizeResult},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_center_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MemberCenterStore on _MemberCenterStore, Store {
  Computed<MemberCenterStoreState> _$stateComputed;

  @override
  MemberCenterStoreState get state =>
      (_$stateComputed ??= Computed<MemberCenterStoreState>(() => super.state,
              name: '_MemberCenterStore.state'))
          .value;

  final _$_initDataFutureAtom =
      Atom(name: '_MemberCenterStore._initDataFuture');

  @override
  ObservableFuture<Either<Failure, MemberDetailModel>> get _initDataFuture {
    _$_initDataFutureAtom.reportRead();
    return super._initDataFuture;
  }

  @override
  set _initDataFuture(
      ObservableFuture<Either<Failure, MemberDetailModel>> value) {
    _$_initDataFutureAtom.reportWrite(value, super._initDataFuture, () {
      super._initDataFuture = value;
    });
  }

  final _$waitForInitCompleteAtom =
      Atom(name: '_MemberCenterStore.waitForInitComplete');

  @override
  bool get waitForInitComplete {
    _$waitForInitCompleteAtom.reportRead();
    return super.waitForInitComplete;
  }

  @override
  set waitForInitComplete(bool value) {
    _$waitForInitCompleteAtom.reportWrite(value, super.waitForInitComplete, () {
      super.waitForInitComplete = value;
    });
  }

  final _$memberDetailAtom = Atom(name: '_MemberCenterStore.memberDetail');

  @override
  MemberDetail get memberDetail {
    _$memberDetailAtom.reportRead();
    return super.memberDetail;
  }

  @override
  set memberDetail(MemberDetail value) {
    _$memberDetailAtom.reportWrite(value, super.memberDetail, () {
      super.memberDetail = value;
    });
  }

  final _$memberVipDataAtom = Atom(name: '_MemberCenterStore.memberVipData');

  @override
  MemberVipData get memberVipData {
    _$memberVipDataAtom.reportRead();
    return super.memberVipData;
  }

  @override
  set memberVipData(MemberVipData value) {
    _$memberVipDataAtom.reportWrite(value, super.memberVipData, () {
      super.memberVipData = value;
    });
  }

  final _$storeActionResultAtom =
      Atom(name: '_MemberCenterStore.storeActionResult');

  @override
  MemberCenterStoreActionResult get storeActionResult {
    _$storeActionResultAtom.reportRead();
    return super.storeActionResult;
  }

  @override
  set storeActionResult(MemberCenterStoreActionResult value) {
    _$storeActionResultAtom.reportWrite(value, super.storeActionResult, () {
      super.storeActionResult = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_MemberCenterStore.errorMessage');

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

  final _$initializeAsyncAction = AsyncAction('_MemberCenterStore.initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  final _$_changePasswordAsyncAction =
      AsyncAction('_MemberCenterStore._changePassword');

  @override
  Future<void> _changePassword(PasswordForm form) {
    return _$_changePasswordAsyncAction.run(() => super._changePassword(form));
  }

  final _$_resetSavedLoginPasswordAsyncAction =
      AsyncAction('_MemberCenterStore._resetSavedLoginPassword');

  @override
  Future<void> _resetSavedLoginPassword() {
    return _$_resetSavedLoginPasswordAsyncAction
        .run(() => super._resetSavedLoginPassword());
  }

  final _$_MemberCenterStoreActionController =
      ActionController(name: '_MemberCenterStore');

  @override
  Future<void> sendRequest(MemberCenterStoreAction action, dynamic data) {
    final _$actionInfo = _$_MemberCenterStoreActionController.startAction(
        name: '_MemberCenterStore.sendRequest');
    try {
      return super.sendRequest(action, data);
    } finally {
      _$_MemberCenterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
waitForInitComplete: ${waitForInitComplete},
memberDetail: ${memberDetail},
memberVipData: ${memberVipData},
storeActionResult: ${storeActionResult},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}

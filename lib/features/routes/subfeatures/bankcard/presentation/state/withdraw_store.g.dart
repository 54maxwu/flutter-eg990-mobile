// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WithdrawStore on _WithdrawStore, Store {
  final _$waitForWithdrawResultAtom =
      Atom(name: '_WithdrawStore.waitForWithdrawResult');

  @override
  bool get waitForWithdrawResult {
    _$waitForWithdrawResultAtom.reportRead();
    return super.waitForWithdrawResult;
  }

  @override
  set waitForWithdrawResult(bool value) {
    _$waitForWithdrawResultAtom.reportWrite(value, super.waitForWithdrawResult,
        () {
      super.waitForWithdrawResult = value;
    });
  }

  final _$withdrawResultAtom = Atom(name: '_WithdrawStore.withdrawResult');

  @override
  WithdrawModel get withdrawResult {
    _$withdrawResultAtom.reportRead();
    return super.withdrawResult;
  }

  @override
  set withdrawResult(WithdrawModel value) {
    _$withdrawResultAtom.reportWrite(value, super.withdrawResult, () {
      super.withdrawResult = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_WithdrawStore.errorMessage');

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

  final _$getRollbackAsyncAction = AsyncAction('_WithdrawStore.getRollback');

  @override
  Future<void> getRollback() {
    return _$getRollbackAsyncAction.run(() => super.getRollback());
  }

  final _$sendRequestAsyncAction = AsyncAction('_WithdrawStore.sendRequest');

  @override
  Future<void> sendRequest(WithdrawForm form) {
    return _$sendRequestAsyncAction.run(() => super.sendRequest(form));
  }

  @override
  String toString() {
    return '''
waitForWithdrawResult: ${waitForWithdrawResult},
withdrawResult: ${withdrawResult},
errorMessage: ${errorMessage}
    ''';
  }
}

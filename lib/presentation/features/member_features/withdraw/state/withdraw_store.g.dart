// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WithdrawStore on _WithdrawStore, Store {
  Computed<WithdrawStoreState> _$stateComputed;

  @override
  WithdrawStoreState get state =>
      (_$stateComputed ??= Computed<WithdrawStoreState>(() => super.state,
              name: '_WithdrawStore.state'))
          .value;

  final _$_bankcardFutureAtom = Atom(name: '_WithdrawStore._bankcardFuture');

  @override
  ObservableFuture<Either<Failure, BankcardModel>> get _bankcardFuture {
    _$_bankcardFutureAtom.reportRead();
    return super._bankcardFuture;
  }

  @override
  set _bankcardFuture(ObservableFuture<Either<Failure, BankcardModel>> value) {
    _$_bankcardFutureAtom.reportWrite(value, super._bankcardFuture, () {
      super._bankcardFuture = value;
    });
  }

  final _$bankcardAtom = Atom(name: '_WithdrawStore.bankcard');

  @override
  BankcardModel get bankcard {
    _$bankcardAtom.reportRead();
    return super.bankcard;
  }

  @override
  set bankcard(BankcardModel value) {
    _$bankcardAtom.reportWrite(value, super.bankcard, () {
      super.bankcard = value;
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

  final _$getBankcardAsyncAction = AsyncAction('_WithdrawStore.getBankcard');

  @override
  Future<void> getBankcard() {
    return _$getBankcardAsyncAction.run(() => super.getBankcard());
  }

  @override
  String toString() {
    return '''
bankcard: ${bankcard},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}

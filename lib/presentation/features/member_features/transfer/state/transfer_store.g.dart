// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransferStore on _TransferStore, Store {
  Computed<TransferStoreState> _$stateComputed;

  @override
  TransferStoreState get state =>
      (_$stateComputed ??= Computed<TransferStoreState>(() => super.state,
              name: '_TransferStore.state'))
          .value;

  final _$_walletTypeFutureAtom =
      Atom(name: '_TransferStore._walletTypeFuture');

  @override
  ObservableFuture<Either<Failure, WalletType>> get _walletTypeFuture {
    _$_walletTypeFutureAtom.reportRead();
    return super._walletTypeFuture;
  }

  @override
  set _walletTypeFuture(ObservableFuture<Either<Failure, WalletType>> value) {
    _$_walletTypeFutureAtom.reportWrite(value, super._walletTypeFuture, () {
      super._walletTypeFuture = value;
    });
  }

  final _$walletTypeAtom = Atom(name: '_TransferStore.walletType');

  @override
  WalletType get walletType {
    _$walletTypeAtom.reportRead();
    return super.walletType;
  }

  @override
  set walletType(WalletType value) {
    _$walletTypeAtom.reportWrite(value, super.walletType, () {
      super.walletType = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_TransferStore.errorMessage');

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

  final _$getWalletTypeAsyncAction =
      AsyncAction('_TransferStore.getWalletType');

  @override
  Future<void> getWalletType() {
    return _$getWalletTypeAsyncAction.run(() => super.getWalletType());
  }

  final _$postWalletTypeAsyncAction =
      AsyncAction('_TransferStore.postWalletType');

  @override
  Future<void> postWalletType(bool toSingle) {
    return _$postWalletTypeAsyncAction
        .run(() => super.postWalletType(toSingle));
  }

  @override
  String toString() {
    return '''
walletType: ${walletType},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}

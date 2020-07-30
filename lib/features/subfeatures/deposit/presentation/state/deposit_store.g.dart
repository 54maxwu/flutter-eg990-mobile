// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DepositStore on _DepositStore, Store {
  Computed<DepositStoreState> _$stateComputed;

  @override
  DepositStoreState get state =>
      (_$stateComputed ??= Computed<DepositStoreState>(() => super.state,
              name: '_DepositStore.state'))
          .value;

  final _$_paymentFutureAtom = Atom(name: '_DepositStore._paymentFuture');

  @override
  ObservableFuture<Either<Failure, PaymentRaw>> get _paymentFuture {
    _$_paymentFutureAtom.reportRead();
    return super._paymentFuture;
  }

  @override
  set _paymentFuture(ObservableFuture<Either<Failure, PaymentRaw>> value) {
    _$_paymentFutureAtom.reportWrite(value, super._paymentFuture, () {
      super._paymentFuture = value;
    });
  }

  final _$paymentTypesAtom = Atom(name: '_DepositStore.paymentTypes');

  @override
  List<PaymentEnum> get paymentTypes {
    _$paymentTypesAtom.reportRead();
    return super.paymentTypes;
  }

  @override
  set paymentTypes(List<PaymentEnum> value) {
    _$paymentTypesAtom.reportWrite(value, super.paymentTypes, () {
      super.paymentTypes = value;
    });
  }

  final _$_promoFutureAtom = Atom(name: '_DepositStore._promoFuture');

  @override
  ObservableFuture<Either<Failure, PaymentPromoTypeJson>> get _promoFuture {
    _$_promoFutureAtom.reportRead();
    return super._promoFuture;
  }

  @override
  set _promoFuture(
      ObservableFuture<Either<Failure, PaymentPromoTypeJson>> value) {
    _$_promoFutureAtom.reportWrite(value, super._promoFuture, () {
      super._promoFuture = value;
    });
  }

  final _$_depositFutureAtom = Atom(name: '_DepositStore._depositFuture');

  @override
  ObservableFuture<Either<Failure, DepositResult>> get _depositFuture {
    _$_depositFutureAtom.reportRead();
    return super._depositFuture;
  }

  @override
  set _depositFuture(ObservableFuture<Either<Failure, DepositResult>> value) {
    _$_depositFutureAtom.reportWrite(value, super._depositFuture, () {
      super._depositFuture = value;
    });
  }

  final _$waitForDepositResultAtom =
      Atom(name: '_DepositStore.waitForDepositResult');

  @override
  bool get waitForDepositResult {
    _$waitForDepositResultAtom.reportRead();
    return super.waitForDepositResult;
  }

  @override
  set waitForDepositResult(bool value) {
    _$waitForDepositResultAtom.reportWrite(value, super.waitForDepositResult,
        () {
      super.waitForDepositResult = value;
    });
  }

  final _$depositResultAtom = Atom(name: '_DepositStore.depositResult');

  @override
  DepositResult get depositResult {
    _$depositResultAtom.reportRead();
    return super.depositResult;
  }

  @override
  set depositResult(DepositResult value) {
    _$depositResultAtom.reportWrite(value, super.depositResult, () {
      super.depositResult = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_DepositStore.errorMessage');

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

  final _$getPaymentTypeAsyncAction =
      AsyncAction('_DepositStore.getPaymentType');

  @override
  Future<void> getPaymentType() {
    return _$getPaymentTypeAsyncAction.run(() => super.getPaymentType());
  }

  final _$getPaymentPromoAsyncAction =
      AsyncAction('_DepositStore.getPaymentPromo');

  @override
  Future<void> getPaymentPromo() {
    return _$getPaymentPromoAsyncAction.run(() => super.getPaymentPromo());
  }

  final _$sendRequestAsyncAction = AsyncAction('_DepositStore.sendRequest');

  @override
  Future<void> sendRequest(DepositDataForm form) {
    return _$sendRequestAsyncAction.run(() => super.sendRequest(form));
  }

  @override
  String toString() {
    return '''
paymentTypes: $paymentTypes,
waitForDepositResult: $waitForDepositResult,
depositResult: $depositResult,
errorMessage: $errorMessage,
state: $state
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoticeStore on _NoticeStore, Store {
  Computed<NoticeStoreState> _$stateComputed;

  @override
  NoticeStoreState get state =>
      (_$stateComputed ??= Computed<NoticeStoreState>(() => super.state,
              name: '_NoticeStore.state'))
          .value;

  final _$_initFutureAtom = Atom(name: '_NoticeStore._initFuture');

  @override
  ObservableFuture<Either<Failure, Map<String, List<NoticeData>>>>
      get _initFuture {
    _$_initFutureAtom.reportRead();
    return super._initFuture;
  }

  @override
  set _initFuture(
      ObservableFuture<Either<Failure, Map<String, List<NoticeData>>>> value) {
    _$_initFutureAtom.reportWrite(value, super._initFuture, () {
      super._initFuture = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_NoticeStore.errorMessage');

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

  final _$initializeAsyncAction = AsyncAction('_NoticeStore.initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}

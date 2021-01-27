// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AgentStore on _AgentStore, Store {
  Computed<AgentStoreState> _$stateComputed;

  @override
  AgentStoreState get state =>
      (_$stateComputed ??= Computed<AgentStoreState>(() => super.state,
              name: '_AgentStore.state'))
          .value;

  final _$waitForAgentLoginAtom = Atom(name: '_AgentStore.waitForAgentLogin');

  @override
  bool get waitForAgentLogin {
    _$waitForAgentLoginAtom.reportRead();
    return super.waitForAgentLogin;
  }

  @override
  set waitForAgentLogin(bool value) {
    _$waitForAgentLoginAtom.reportWrite(value, super.waitForAgentLogin, () {
      super.waitForAgentLogin = value;
    });
  }

  final _$agentAtom = Atom(name: '_AgentStore.agent');

  @override
  AgentEntity get agent {
    _$agentAtom.reportRead();
    return super.agent;
  }

  @override
  set agent(AgentEntity value) {
    _$agentAtom.reportWrite(value, super.agent, () {
      super.agent = value;
    });
  }

  final _$waitForAgentRegisterAtom =
      Atom(name: '_AgentStore.waitForAgentRegister');

  @override
  bool get waitForAgentRegister {
    _$waitForAgentRegisterAtom.reportRead();
    return super.waitForAgentRegister;
  }

  @override
  set waitForAgentRegister(bool value) {
    _$waitForAgentRegisterAtom.reportWrite(value, super.waitForAgentRegister,
        () {
      super.waitForAgentRegister = value;
    });
  }

  final _$registerResultAtom = Atom(name: '_AgentStore.registerResult');

  @override
  RequestCodeModel get registerResult {
    _$registerResultAtom.reportRead();
    return super.registerResult;
  }

  @override
  set registerResult(RequestCodeModel value) {
    _$registerResultAtom.reportWrite(value, super.registerResult, () {
      super.registerResult = value;
    });
  }

  final _$_agentFutureAtom = Atom(name: '_AgentStore._agentFuture');

  @override
  ObservableFuture<Either<Failure, AgentModel>> get _agentFuture {
    _$_agentFutureAtom.reportRead();
    return super._agentFuture;
  }

  @override
  set _agentFuture(ObservableFuture<Either<Failure, AgentModel>> value) {
    _$_agentFutureAtom.reportWrite(value, super._agentFuture, () {
      super._agentFuture = value;
    });
  }

  final _$waitForAgentResponseAtom =
      Atom(name: '_AgentStore.waitForAgentResponse');

  @override
  bool get waitForAgentResponse {
    _$waitForAgentResponseAtom.reportRead();
    return super.waitForAgentResponse;
  }

  @override
  set waitForAgentResponse(bool value) {
    _$waitForAgentResponseAtom.reportWrite(value, super.waitForAgentResponse,
        () {
      super.waitForAgentResponse = value;
    });
  }

  final _$_bankcardFutureAtom = Atom(name: '_AgentStore._bankcardFuture');

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

  final _$bankcardAtom = Atom(name: '_AgentStore.bankcard');

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

  final _$banksMapAtom = Atom(name: '_AgentStore.banksMap');

  @override
  Map<String, String> get banksMap {
    _$banksMapAtom.reportRead();
    return super.banksMap;
  }

  @override
  set banksMap(Map<String, String> value) {
    _$banksMapAtom.reportWrite(value, super.banksMap, () {
      super.banksMap = value;
    });
  }

  final _$waitForNewCardResultAtom =
      Atom(name: '_AgentStore.waitForNewCardResult');

  @override
  bool get waitForNewCardResult {
    _$waitForNewCardResultAtom.reportRead();
    return super.waitForNewCardResult;
  }

  @override
  set waitForNewCardResult(bool value) {
    _$waitForNewCardResultAtom.reportWrite(value, super.waitForNewCardResult,
        () {
      super.waitForNewCardResult = value;
    });
  }

  final _$newCardResultAtom = Atom(name: '_AgentStore.newCardResult');

  @override
  RequestCodeModel get newCardResult {
    _$newCardResultAtom.reportRead();
    return super.newCardResult;
  }

  @override
  set newCardResult(RequestCodeModel value) {
    _$newCardResultAtom.reportWrite(value, super.newCardResult, () {
      super.newCardResult = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_AgentStore.errorMessage');

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

  final _$loginAgentAsyncAction = AsyncAction('_AgentStore.loginAgent');

  @override
  Future<void> loginAgent(LoginForm form) {
    return _$loginAgentAsyncAction.run(() => super.loginAgent(form));
  }

  final _$logoutAgentAsyncAction = AsyncAction('_AgentStore.logoutAgent');

  @override
  Future<void> logoutAgent() {
    return _$logoutAgentAsyncAction.run(() => super.logoutAgent());
  }

  final _$registerAgentAsyncAction = AsyncAction('_AgentStore.registerAgent');

  @override
  Future<void> registerAgent(AgentRegisterForm form) {
    return _$registerAgentAsyncAction.run(() => super.registerAgent(form));
  }

  final _$getAgentDataAsyncAction = AsyncAction('_AgentStore.getAgentData');

  @override
  Future<void> getAgentData() {
    return _$getAgentDataAsyncAction.run(() => super.getAgentData());
  }

  final _$getBankcardAsyncAction = AsyncAction('_AgentStore.getBankcard');

  @override
  Future<void> getBankcard() {
    return _$getBankcardAsyncAction.run(() => super.getBankcard());
  }

  final _$getReportAsyncAction = AsyncAction('_AgentStore.getReport');

  @override
  Future<void> getReport(AgentReportForm form) {
    return _$getReportAsyncAction.run(() => super.getReport(form));
  }

  final _$getLedgerAsyncAction = AsyncAction('_AgentStore.getLedger');

  @override
  Future<void> getLedger(AgentLedgerForm form) {
    return _$getLedgerAsyncAction.run(() => super.getLedger(form));
  }

  final _$getCommissionAsyncAction = AsyncAction('_AgentStore.getCommission');

  @override
  Future<void> getCommission() {
    return _$getCommissionAsyncAction.run(() => super.getCommission());
  }

  final _$getDownlinesAsyncAction = AsyncAction('_AgentStore.getDownlines');

  @override
  Future<void> getDownlines() {
    return _$getDownlinesAsyncAction.run(() => super.getDownlines());
  }

  final _$postDownlineAsyncAction = AsyncAction('_AgentStore.postDownline');

  @override
  Future<bool> postDownline(AgentDownlineForm form) {
    return _$postDownlineAsyncAction.run(() => super.postDownline(form));
  }

  final _$editProportionAsyncAction = AsyncAction('_AgentStore.editProportion');

  @override
  Future<bool> editProportion(AgentProportionForm form) {
    return _$editProportionAsyncAction.run(() => super.editProportion(form));
  }

  final _$getBanksAsyncAction = AsyncAction('_AgentStore.getBanks');

  @override
  Future<void> getBanks() {
    return _$getBanksAsyncAction.run(() => super.getBanks());
  }

  final _$addBankcardAsyncAction = AsyncAction('_AgentStore.addBankcard');

  @override
  Future<void> addBankcard(BankcardForm form) {
    return _$addBankcardAsyncAction.run(() => super.addBankcard(form));
  }

  @override
  String toString() {
    return '''
waitForAgentLogin: ${waitForAgentLogin},
agent: ${agent},
waitForAgentRegister: ${waitForAgentRegister},
registerResult: ${registerResult},
waitForAgentResponse: ${waitForAgentResponse},
bankcard: ${bankcard},
banksMap: ${banksMap},
waitForNewCardResult: ${waitForNewCardResult},
newCardResult: ${newCardResult},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}

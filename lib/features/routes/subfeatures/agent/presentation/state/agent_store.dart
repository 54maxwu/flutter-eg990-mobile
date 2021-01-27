import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/form/agent_downline_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/form/agent_proportion_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/models/downline_agent_model.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/bankcard/data/form/bankcard_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/bankcard/data/models/bankcard_model.dart';
import 'package:flutter_eg990_mobile/features/user/data/form/login_form.dart';

import '../../data/entity/agent_entity.dart';
import '../../data/form/agent_ledger_form.dart';
import '../../data/form/agent_register_form.dart';
import '../../data/form/agent_report_form.dart';
import '../../data/models/agent_chart_model.dart';
import '../../data/models/agent_commission_model.dart';
import '../../data/models/agent_ledger_model.dart';
import '../../data/models/agent_model.dart';
import '../../data/repository/agent_repository.dart';

part 'agent_store.g.dart';

class AgentStore = _AgentStore with _$AgentStore;

enum AgentStoreState { initial, loading, loaded }

abstract class _AgentStore with Store {
  final AgentRepository _repository;
  final StreamController<List<AgentChartModel>> _reportController =
      StreamController<List<AgentChartModel>>.broadcast();
  final StreamController<AgentLedgerModel> _ledgerController =
      StreamController<AgentLedgerModel>.broadcast();
  final StreamController<List<AgentCommissionModel>> _commissionController =
      StreamController<List<AgentCommissionModel>>.broadcast();
  final StreamController<List<DownlineAgentModel>> _downlinesController =
      StreamController<List<DownlineAgentModel>>.broadcast();

  _AgentStore(this._repository) {
    _reportController.stream.listen((event) {
//      debugPrint('report data: $event');
      if (event == null)
        setErrorMsg(msg: Failure.jsonFormat().message, showOnce: true);
    });
    _ledgerController.stream.listen((event) {
//      debugPrint('ledger data: $event');
      if (event == null)
        setErrorMsg(msg: Failure.jsonFormat().message, showOnce: true);
    });
    _commissionController.stream.listen((event) {
//      debugPrint('commission data: $event');
      if (event == null)
        setErrorMsg(msg: Failure.jsonFormat().message, showOnce: true);
    });
    _downlinesController.stream.listen((event) {
//      debugPrint('downline data: $event');
      if (event == null)
        setErrorMsg(msg: Failure.jsonFormat().message, showOnce: true);
    });
  }

  Stream<List<AgentChartModel>> get reportStream => _reportController.stream;

  Stream<AgentLedgerModel> get ledgerStream => _ledgerController.stream;

  Stream<List<AgentCommissionModel>> get commissionStream =>
      _commissionController.stream;

  Stream<List<DownlineAgentModel>> get downlinesStream =>
      _downlinesController.stream;

  /// Agent Login
  @observable
  bool waitForAgentLogin = false;

  @observable
  AgentEntity agent = AgentEntity(hasValidToken: false);

  /// Agent Register
  @observable
  bool waitForAgentRegister = false;

  @observable
  RequestCodeModel registerResult;

  /// Agent Data
  @observable
  ObservableFuture<Either<Failure, AgentModel>> _agentFuture;

  @observable
  bool waitForAgentResponse = false;

  AgentModel agentData;

  /// Agent Bankcard
  @observable
  ObservableFuture<Either<Failure, BankcardModel>> _bankcardFuture;

  @observable
  BankcardModel bankcard;

  @observable
  Map<String, String> banksMap;

  @observable
  bool waitForNewCardResult = false;

  @observable
  RequestCodeModel newCardResult;

  /// Error
  @observable
  String errorMessage;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.AGENT,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @action
  Future<void> loginAgent(LoginForm form) async {
    if (waitForAgentLogin) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentLogin = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.postAgentLogin(form).then((result) {
        debugPrint('agent login result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => agent = data,
        );
      }).whenComplete(() => waitForAgentLogin = false);
    } on Exception {
      waitForAgentLogin = false;
      setErrorMsg(code: 11);
    }
  }

  @action
  Future<void> logoutAgent() async {
    if (agent == null) return;
    try {
      agent = AgentEntity(hasValidToken: false);
      agentData = null;
      await _repository.logoutAgent();
    } on Exception {
      setErrorMsg(code: 12);
    }
  }

  @action
  Future<void> registerAgent(AgentRegisterForm form) async {
    if (waitForAgentRegister) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentRegister = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.postAgentRegister(form).then((result) {
        debugPrint('agent register result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => registerResult = data,
        );
      }).whenComplete(() => waitForAgentRegister = false);
    } on Exception {
      waitForAgentRegister = false;
      setErrorMsg(code: 10);
    }
  }

  @computed
  AgentStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_agentFuture == null || _agentFuture.status == FutureStatus.rejected) {
      return AgentStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _agentFuture.status == FutureStatus.pending ||
            bankcard == null ||
            _bankcardFuture.status == FutureStatus.pending
        ? AgentStoreState.loading
        : AgentStoreState.loaded;
  }

  @action
  Future<void> getAgentData() async {
    if (waitForAgentResponse) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _agentFuture = ObservableFuture(_repository.getAgentDetail());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _agentFuture.then((result) {
        debugPrint('agent result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => agentData = data,
        );
      }).whenComplete(() {
        waitForAgentResponse = false;
        getBankcard();
      });
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> getBankcard() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      _bankcardFuture = ObservableFuture(_repository.getBankcard());
      await _bankcardFuture.then((result) {
//        debugPrint('bankcard result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => bankcard = data,
        );
      });
    } on Exception {
      setErrorMsg(code: 1);
    }
  }

  @action
  Future<void> getReport(AgentReportForm form) async {
    if (waitForAgentResponse) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      _reportController.sink.add([]);
      waitForAgentResponse = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getReport(form).then((result) {
//        debugPrint('agent report result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => _reportController.sink.add(data),
        );
      }).whenComplete(() => waitForAgentResponse = false);
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 2);
    }
  }

  @action
  Future<void> getLedger(AgentLedgerForm form) async {
    if (waitForAgentResponse) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentResponse = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getLedger(form).then((result) {
        debugPrint('agent ledger result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => _ledgerController.sink.add(data),
        );
      }).whenComplete(() => waitForAgentResponse = false);
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 3);
    }
  }

  @action
  Future<void> getCommission() async {
    if (waitForAgentResponse) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentResponse = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getCommission().then((result) {
        debugPrint('agent commission result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => _commissionController.sink.add(data),
        );
      }).whenComplete(() => waitForAgentResponse = false);
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 4);
    }
  }

  @action
  Future<void> getDownlines() async {
    if (waitForAgentResponse) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentResponse = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getDownlines().then((result) {
        debugPrint('agent downlines result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => _downlinesController.sink.add(data),
        );
      }).whenComplete(() => waitForAgentResponse = false);
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 5);
    }
  }

  @action
  Future<bool> postDownline(AgentDownlineForm form) async {
    if (waitForAgentResponse) return false;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentResponse = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      return await _repository.postDownline(form).then((result) {
        debugPrint('agent downline submit result: $result');
        return result.fold(
          (failure) {
            setErrorMsg(msg: failure.message, showOnce: true);
            return false;
          },
          (data) {
            if (data.isSuccess == false) {
              setErrorMsg(msg: data.msg);
            }
            return data.isSuccess;
          },
        );
      }).whenComplete(() => waitForAgentResponse = false);
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 6);
      return false;
    }
  }

  @action
  Future<bool> editProportion(AgentProportionForm form) async {
    if (waitForAgentResponse) return false;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForAgentResponse = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      return await _repository.postProportion(form).then((result) {
        debugPrint('agent propotion update result: $result');
        return result.fold(
          (failure) {
            setErrorMsg(msg: failure.message, showOnce: true);
            return false;
          },
          (data) => true,
        );
      }).whenComplete(() => waitForAgentResponse = false);
    } on Exception {
      waitForAgentResponse = false;
      setErrorMsg(code: 7);
      return false;
    }
  }

  @action
  Future<void> getBanks() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getBanks().then((result) {
//        debugPrint('bank ids map result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) {
            if (data != null) banksMap = data;
          },
        );
      });
    } on Exception {
      setErrorMsg(code: 2);
    }
  }

  @action
  Future<void> addBankcard(BankcardForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      newCardResult = null;
      waitForNewCardResult = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postBankcard(form)
          .whenComplete(() => waitForNewCardResult = false)
          .then((result) {
        debugPrint('bankcard bind result: $result');
        result.fold(
          (failure) => setErrorMsg(msg: failure.message, showOnce: true),
          (data) => newCardResult = data,
        );
      });
    } on Exception {
      waitForNewCardResult = false;
      setErrorMsg(code: 6);
    }
  }

  Future<void> clearStreams() {
    try {
      return Future.wait([
        _reportController.stream.drain(),
        _ledgerController.stream.drain(),
        _commissionController.stream.drain(),
        _downlinesController.stream.drain(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'clean agent stream error', error: e, tag: 'AgentStore');
      return null;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _reportController.close(),
        _ledgerController.close(),
        _commissionController.close(),
        _downlinesController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close agent stream error', error: e, tag: 'AgentStore');
      return null;
    }
  }
}

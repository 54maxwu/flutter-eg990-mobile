import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/repository_export.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/enum/agent_level.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/form/agent_downline_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/form/agent_proportion_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/models/downline_agent_model.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/bankcard/data/form/bankcard_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/bankcard/data/models/bankcard_model.dart';
import 'package:flutter_eg990_mobile/features/user/data/form/login_form.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../entity/agent_entity.dart';
import '../form/agent_ledger_form.dart';
import '../form/agent_register_form.dart';
import '../form/agent_report_form.dart';
import '../models/agent_chart_model.dart';
import '../models/agent_commission_model.dart';
import '../models/agent_ledger_model.dart';
import '../models/agent_model.dart';

class AgentApi {
  static const String REG_AGENT = "api/regAgent";
  static const String LOGIN_AGENT = "api/loginAgent";
  static const String AGENT_REF = "/agent";

  static const String AGENT_CARD_BANKS = "api/getBankid2";
  static const String GET_AGENT_CARD = "api/bankcard2";
  static const String POST_AGENT_CARD = "api/addbankcard2";

  static const String GET_AGENT = "api/get_account2";
  static const String POST_REPORT = "api/getAgentReport";
  static const String POST_LEDGER = "api/getDownLedger";
  static const String POST_COMMISSION = "api/getCommission";
  static const String GET_DOWNLINE = "api/getAgentDownlineList";
  static const String POST_DOWNLINE = "api/addDownline";
  static const String POST_PROPORTION = "api/editAgentRate";
}

abstract class AgentRepository {
  Future<Either<Failure, RequestCodeModel>> postAgentRegister(
      AgentRegisterForm form);

  Future<Either<Failure, AgentEntity>> postAgentLogin(LoginForm form);

  Future<Either<Failure, bool>> logoutAgent();

  /// Agent Data
  Future<Either<Failure, AgentModel>> getAgentDetail();

  Future<Either<Failure, List<AgentChartModel>>> getReport(
      AgentReportForm form);

  Future<Either<Failure, List<AgentCommissionModel>>> getCommission();

  Future<Either<Failure, AgentLedgerModel>> getLedger(AgentLedgerForm form);

  Future<Either<Failure, List<DownlineAgentModel>>> getDownlines();

  Future<Either<Failure, RequestCodeModel>> postDownline(
      AgentDownlineForm form);

  Future<Either<Failure, RequestCodeModel>> postProportion(
      AgentProportionForm form);

  /// Agent Info
  Future<Either<Failure, Map<String, String>>> getBanks();

  Future<Either<Failure, BankcardModel>> getBankcard();

  Future<Either<Failure, RequestCodeModel>> postBankcard(BankcardForm form);
}

class AgentRepositoryImpl implements AgentRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'AgentRepository';

  AgentRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface});

  ///
  /// Agent Member Relative
  ///
  @override
  Future<Either<Failure, RequestCodeModel>> postAgentRegister(
      AgentRegisterForm form) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        AgentApi.REG_AGENT,
        data: form.toJson(),
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-AGENT_REGISTER',
    );
    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, AgentEntity>> postAgentLogin(LoginForm form) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        AgentApi.LOGIN_AGENT,
        data: form.toJson(),
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-AGENT_LOGIN',
    );
    // debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (status) async {
        if (status.isSuccess) {
          return await _checkToken(form.account, status.msg);
        } else {
          return Left(Failure.login(status));
        }
      },
    );
  }

  ///
  /// Calls the [JwtInterface.checkJwt] to check if the returned token is valid,
  /// then calls [getAccount] to retrieve user info.
  ///
  Future<Either<Failure, AgentEntity>> _checkToken(
      String account, String token) async {
    return await Future.delayed(Duration(milliseconds: 500), () {
      return jwtInterface.checkAgentJwt(
        '${Global.CURRENT_BASE}${AgentApi.LOGIN_AGENT}',
        AgentApi.AGENT_REF,
        aAccount: account,
        aToken: token,
      );
    }).then((result) {
      // debugPrint('test response type: ${result.runtimeType}, data: $result');
      return result.fold((failure) => Left(failure), (status) async {
        if (status.isSuccess) {
          MyLogger.log(msg: 'agent $account token is valid', tag: tag);
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          final levelKey = 'audlevel';
          return Right(AgentEntity(
              account: account,
              hasValidToken: true,
              level: (decodedToken.containsKey(levelKey)
                  ? AgentLevel.getLevel(decodedToken[levelKey])
                  : AgentLevel.UNKNOWN)));
        } else {
          MyLogger.warn(msg: 'agent token is not valid: $status', tag: tag);
          jwtInterface.clearAgentToken();
          return Left(Failure.token(FailureType.TOKEN));
        }
      });
    });
  }

  @override
  Future<Either<Failure, bool>> logoutAgent() {
    jwtInterface.clearAgentToken();
    return Future.value(Right(true));
  }

  ///
  /// Agent Data
  ///
  @override
  Future<Either<Failure, AgentModel>> getAgentDetail() async {
    final result = await requestModel<AgentModel>(
      request: dioApiService.get(
        AgentApi.GET_AGENT,
        agentToken: jwtInterface.agentToken,
      ),
      jsonToModel: AgentModel.jsonToAgentModel,
      tag: 'remote-AGENT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, List<AgentChartModel>>> getReport(
      AgentReportForm form) async {
    final result = await requestDataString(
      request: dioApiService.post(
        AgentApi.POST_REPORT,
        agentToken: jwtInterface.agentToken,
        data: form.toJson(),
      ),
      allowJsonString: true,
      tag: 'remote-REPORT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data == '[]') return Right([]);
        List<AgentChartModel> modelList = new List();
        Map<String, dynamic> map = jsonDecode(data);
        map.forEach((key, value) {
          List<AgentChartData> list = JsonUtil.decodeMapToModelList(
              value, (jsonMap) => AgentChartData.jsonToAgentChartData(jsonMap));
          modelList.add(AgentChartModel(
            platform: key,
            dataList: list,
          ));
        });
//        debugPrint('agent report model: $modelList');
        return Right(modelList);
      },
    );
  }

  @override
  Future<Either<Failure, AgentLedgerModel>> getLedger(
      AgentLedgerForm form) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        AgentApi.POST_LEDGER,
        agentToken: jwtInterface.agentToken,
        data: form.toJson(),
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-AGENT_LEDGER',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        var dataStr = (model.data != null) ? model.data.toString() : '';
        if (dataStr.isEmpty || dataStr == '[]') {
          return Right(AgentLedgerModel(data: []));
        } else {
          try {
            if (model.data is Map)
              return Right(AgentLedgerModel.jsonToAgentLedgerModel(model.data));
            else
              return Right(AgentLedgerModel.jsonToAgentLedgerModel(
                  jsonDecode(model.data)));
          } catch (e) {
            MyLogger.error(msg: 'ledger model has exception: $e', tag: tag);
            return Left(Failure.jsonFormat());
          }
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<AgentCommissionModel>>> getCommission() async {
    final result = await requestModelList<AgentCommissionModel>(
      request: dioApiService.post(
        AgentApi.POST_COMMISSION,
        agentToken: jwtInterface.agentToken,
      ),
      jsonToModel: AgentCommissionModel.jsonToAgentCommissionModel,
      tag: 'remote-COMMISSION',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, List<DownlineAgentModel>>> getDownlines() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        AgentApi.GET_DOWNLINE,
        agentToken: jwtInterface.agentToken,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-DOWNLINES',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        var dataStr = (model.data != null) ? model.data.toString() : '';
        if (dataStr.isEmpty || dataStr == '[]') {
          return Right([]);
        } else {
          try {
            return Right(JsonUtil.decodeMapToModelList(
              model.data,
              (jsonMap) => DownlineAgentModel.jsonToDownlineAgentModel(jsonMap),
              addKey: false,
            ));
          } catch (e) {
            MyLogger.error(msg: 'downline model has exception: $e', tag: tag);
            return Left(Failure.jsonFormat());
          }
        }
      },
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postDownline(
      AgentDownlineForm form) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        AgentApi.POST_DOWNLINE,
        agentToken: jwtInterface.agentToken,
        data: form.toJson(),
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-AGENT_DOWNLINE',
    );
    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postProportion(
      AgentProportionForm form) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        AgentApi.POST_PROPORTION,
        agentToken: jwtInterface.agentToken,
        data: form.toJson(),
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-AGENT_PROPORTION',
    );
    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  ///
  /// Agent Bankcard Relative
  ///
  @override
  Future<Either<Failure, Map<String, String>>> getBanks() async {
    final result = await requestData(
      request: dioApiService.post(
        AgentApi.AGENT_CARD_BANKS,
        agentToken: jwtInterface.agentToken,
      ),
      tag: 'remote-AGENT_BANKS',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data is Map || data is String) {
          return _processMap(data, 'banks id');
        } else {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  Either<Failure, Map<String, String>> _processMap(
    dynamic data,
    String dataName, {
    bool debug = false,
  }) {
    try {
      if (debug)
        MyLogger.print(
          msg: '$dataName data type: ${data.runtimeType}, data: \n$data',
          tag: tag,
        );

      if (data is Map) {
        return Right(data.map<String, String>(
            (key, value) => MapEntry<String, String>(key, value.toString())));
      } else {
        var map = jsonDecode('$data');
        return Right(map.map<String, String>(
            (key, value) => MapEntry<String, String>(key, value.toString())));
      }
    } catch (e) {
      MyLogger.error(
          msg: '$dataName data process error!! $e', error: e, tag: tag);
      return Left(Failure.jsonFormat());
    }
  }

  @override
  Future<Either<Failure, BankcardModel>> getBankcard() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(
        AgentApi.GET_AGENT_CARD,
        agentToken: jwtInterface.agentToken,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-AGENT_BANKCARD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.isSuccess && data.data.toString().isNotEmpty) {
          MyLogger.print(msg: 'bankcard map: ${data.data}', tag: tag);
          if (data.data is Map)
            return Right(BankcardModel.jsonToBankcardModel(data.data)
                .copyWith(hasCard: true));
          else if (data.data is String)
            return Right(
                BankcardModel.jsonToBankcardModel(jsonDecode(data.data))
                    .copyWith(hasCard: true));
          else
            return Left(Failure.dataType());
        } else {
          return Right(BankcardModel(hasCard: false));
        }
      },
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postBankcard(
      BankcardForm form) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        AgentApi.POST_AGENT_CARD,
        agentToken: jwtInterface.agentToken,
        data: form.toJson(),
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-AGENT_BANKCARD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}

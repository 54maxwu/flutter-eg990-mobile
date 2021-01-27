import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_model.freezed.dart';

@freezed
abstract class AgentModel with _$AgentModel {
  const factory AgentModel({
    @JsonKey(name: 'accountcode') String account,
    @JsonKey(name: 'creditlimit') String credit,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'success') String success,
    @JsonKey(name: 'vip') int vip,
    @JsonKey(name: 'vip_img') String vipImg,
    @JsonKey(name: 'vip_name') String vipName,
  }) = _AgentModel;

  static AgentModel jsonToAgentModel(Map<String, dynamic> jsonMap) {
    return _$_AgentModel(
      account: jsonMap['accountcode'] as String,
      credit: jsonMap['creditlimit'] as String,
      status: jsonMap['status'] as String,
      success: jsonMap['success'] as String,
      vip: jsonMap['vip'] as int,
      vipImg: jsonMap['vip_img'] as String,
      vipName: jsonMap['vip_name'] as String,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

part 'downline_agent_model.freezed.dart';

@freezed
abstract class DownlineAgentModel with _$DownlineAgentModel {
  const factory DownlineAgentModel({
    @JsonKey(name: 'accountcode') String account,
    @JsonKey(name: 'accountid') int accountId,
    @JsonKey(name: 'bankaccountno') String bankAccount,
    @JsonKey(name: 'bankaddress') String bankAddress,
    @JsonKey(name: 'bankindex') int bankIndex,
    @JsonKey(name: 'bankprovince') String bankProvince,
    @Default('') String email,
    @JsonKey(name: 'firstname') String firstName,
    @JsonKey(name: 'phoneno') String phone,
    String status,
    @Default('') String zalo,
  }) = _DownlineAgentModel;

  static DownlineAgentModel jsonToDownlineAgentModel(
          Map<String, dynamic> jsonMap) =>
      _$_DownlineAgentModel(
        account: jsonMap['accountcode'] as String,
        accountId: jsonMap['accountid'] as int,
        bankAccount: (jsonMap['bankaccountno'] != null)
            ? '${jsonMap['bankaccountno']}'
            : '',
        bankAddress:
            (jsonMap['bankaddress'] != null) ? '${jsonMap['bankaddress']}' : '',
        bankIndex: (jsonMap['bankindex'] != null)
            ? '${jsonMap['bankindex']}'.strToInt
            : -1,
        bankProvince: (jsonMap['bankProvince'] != null)
            ? '${jsonMap['bankProvince']}'
            : '',
        email: jsonMap['email'] as String ?? '',
        firstName: jsonMap['firstname'] as String,
        phone: jsonMap['phoneno'] as String,
        status: jsonMap['status'] as String,
        zalo: jsonMap['zalo'] as String ?? '',
      );
}

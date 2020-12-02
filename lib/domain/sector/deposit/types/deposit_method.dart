import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit_method.freezed.dart';
part 'deposit_method.g.dart';

@freezed
abstract class DepositMethod with _$DepositMethod {
  /// Contains a list of virtual bank data
  /// Created in deposit store
  const factory DepositMethod.online({
    @Default([]) List<DepositMethodVirtualData> options,
    @Default('1') dynamic key,
  }) = DepositMethodOnline;

  /// Contains each online deposit option info and deposit limit
  /// Created by json parser [jsonToVirtualBankData]
  const factory DepositMethod.virtual({
    String amount,
    @JsonKey(name: 'amountoption') List<String> amountOption,
    @JsonKey(name: 'amounttype') int amountType,
    @JsonKey(name: 'bankaccountid') int bankAccountId,
    int gateway,
    int max,
    int min,
    int payment,
    @JsonKey(name: 'pgindex') int pgIndex,
    @required List<int> sb,
    String type,
    dynamic key,
  }) = DepositMethodVirtualData;

  /// Contains a list of real banks data
  /// Created in deposit store
  const factory DepositMethod.local({
    @Default([]) List<DepositMethodBankData> banks,
    @Default('1') dynamic key,
  }) = DepositMethodLocal;

  /// Contains each bank info and deposit limit
  /// Created by json parser [jsonToLocalBankData]
  const factory DepositMethod.bank({
    @JsonKey(name: 'bankaccountid') int bankAccountId,
    @JsonKey(name: 'bankaccountno') String bankAccountNo,
    @JsonKey(name: 'bankindex') int bankIndex,
    @JsonKey(fromJson: JsonUtil.getRawJson) String max,
    @JsonKey(fromJson: JsonUtil.getRawJson) String min,
    String payment,
    String type,
    dynamic key,
  }) = DepositMethodBankData;

  factory DepositMethod.fromJson(Map<String, dynamic> json) =>
      (json.containsValue('localbank'))
          ? jsonToLocalBankData(json)
          : jsonToVirtualBankData(json);

  static DepositMethodBankData jsonToLocalBankData(
      Map<String, dynamic> jsonMap) {
    jsonMap['runtimeType'] = 'bank';
    return _$DepositMethodFromJson(jsonMap);
  }

  static DepositMethodVirtualData jsonToVirtualBankData(
      Map<String, dynamic> jsonMap) {
    jsonMap['runtimeType'] = 'virtual';
    return _$DepositMethodFromJson(jsonMap);
  }
}

extension DepositMethodExtension on DepositMethod {
  String get label {
    if (this is DepositMethodLocal) {
      return localeStr.depositPaymentTitleBank;
    } else if (this is DepositMethodOnline) {
      return localeStr.depositPaymentTitleOnline;
    } else if (this is DepositMethodBankData) {
      return (this as DepositMethodBankData).type;
    } else if (this is DepositMethodVirtualData) {
      return (this as DepositMethodVirtualData).type;
    }
    return '??';
  }
}

extension DepositMethodVirtualDataExtension on DepositMethodVirtualData {
  bool get hasAmountOption => amountOption != null && amountOption.isNotEmpty;
}

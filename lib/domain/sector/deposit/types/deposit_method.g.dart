// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DepositMethodOnline _$_$DepositMethodOnlineFromJson(
    Map<String, dynamic> json) {
  return _$DepositMethodOnline(
    options: (json['options'] as List)
            ?.map((e) => e == null
                ? null
                : DepositMethodVirtualData.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    key: json['key'] ?? '1',
  );
}

Map<String, dynamic> _$_$DepositMethodOnlineToJson(
        _$DepositMethodOnline instance) =>
    <String, dynamic>{
      'options': instance.options,
      'key': instance.key,
    };

_$DepositMethodVirtualData _$_$DepositMethodVirtualDataFromJson(
    Map<String, dynamic> json) {
  return _$DepositMethodVirtualData(
    amount: json['amount'] as String,
    amountOption:
        (json['amountoption'] as List)?.map((e) => e as String)?.toList(),
    amountType: json['amounttype'] as int,
    bankAccountId: json['bankaccountid'] as int,
    gateway: json['gateway'] as int,
    max: json['max'] as int,
    min: json['min'] as int,
    payment: json['payment'] as int,
    pgIndex: json['pgindex'] as int,
    sb: (json['sb'] as List)?.map((e) => e as int)?.toList(),
    type: json['type'] as String,
    key: json['key'],
  );
}

Map<String, dynamic> _$_$DepositMethodVirtualDataToJson(
        _$DepositMethodVirtualData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'amountoption': instance.amountOption,
      'amounttype': instance.amountType,
      'bankaccountid': instance.bankAccountId,
      'gateway': instance.gateway,
      'max': instance.max,
      'min': instance.min,
      'payment': instance.payment,
      'pgindex': instance.pgIndex,
      'sb': instance.sb,
      'type': instance.type,
      'key': instance.key,
    };

_$DepositMethodLocal _$_$DepositMethodLocalFromJson(Map<String, dynamic> json) {
  return _$DepositMethodLocal(
    banks: (json['banks'] as List)
            ?.map((e) => e == null
                ? null
                : DepositMethodBankData.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    key: json['key'] ?? '1',
  );
}

Map<String, dynamic> _$_$DepositMethodLocalToJson(
        _$DepositMethodLocal instance) =>
    <String, dynamic>{
      'banks': instance.banks,
      'key': instance.key,
    };

_$DepositMethodBankData _$_$DepositMethodBankDataFromJson(
    Map<String, dynamic> json) {
  return _$DepositMethodBankData(
    bankAccountId: json['bankaccountid'] as int,
    bankAccountNo: json['bankaccountno'] as String,
    bankIndex: json['bankindex'] as int,
    max: JsonUtil.getRawJson(json['max']),
    min: JsonUtil.getRawJson(json['min']),
    payment: json['payment'] as String,
    type: json['type'] as String,
    key: json['key'],
  );
}

Map<String, dynamic> _$_$DepositMethodBankDataToJson(
        _$DepositMethodBankData instance) =>
    <String, dynamic>{
      'bankaccountid': instance.bankAccountId,
      'bankaccountno': instance.bankAccountNo,
      'bankindex': instance.bankIndex,
      'max': instance.max,
      'min': instance.min,
      'payment': instance.payment,
      'type': instance.type,
      'key': instance.key,
    };

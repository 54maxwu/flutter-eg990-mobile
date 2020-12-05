import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bankcard.dart';

part 'bankcard_model.freezed.dart';

@freezed
abstract class BankcardModel with _$BankcardModel {
  const factory BankcardModel({
    @nullable bool hasCard,
    @JsonKey(name: 'bankaddress', defaultValue: '') String bankAddress,
    @JsonKey(name: 'firstname', defaultValue: '') String firstName,
    @JsonKey(name: 'bankaccountno', defaultValue: '') String bankAccountNo,
    @JsonKey(name: 'bankprovince', defaultValue: '') String bankProvince,
    @JsonKey(name: 'bankcity', defaultValue: '') String bankCity,
    @JsonKey(name: 'bankarea', defaultValue: '') String bankArea,
    @JsonKey(name: 'bankname', defaultValue: '') String bankName,
  }) = _BankcardModel;

  static BankcardModel jsonToBankcardModel(Map<String, dynamic> jsonMap) =>
      _$_BankcardModel(
        hasCard: jsonMap['hasCard'] as bool,
        bankAddress: jsonMap['bankaddress'] as String ?? '',
        firstName: jsonMap['firstname'] as String ?? '',
        bankAccountNo: jsonMap['bankaccountno'] as String ?? '',
        bankProvince: jsonMap['bankprovince'] as String ?? '',
        bankCity: jsonMap['bankcity'] as String ?? '',
        bankArea: jsonMap['bankarea'] as String ?? '',
        bankName: jsonMap['bankname'] as String ?? '',
      );
}

extension BankcardModelExtension on BankcardModel {
  Bankcard get data => hasCard
      ? Bankcard(
          bankName: bankName,
          bankAccount: bankAccountNo,
          accountName: firstName,
        )
      : Bankcard.empty();
}

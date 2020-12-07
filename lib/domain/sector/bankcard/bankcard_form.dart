import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show immutable, required;

import 'bankcard_form_data.dart';

@immutable
class BankcardForm with FormzMixin {
  BankcardForm({
    @required this.cardInfo,
    @required this.bankAddress,
    @required this.mobile,
  });

  final BankcardNewData cardInfo;
  final BankcardNewAddress bankAddress;
  final BankcardNewMobile mobile;

  @override
  List<FormzInput> get inputs => [cardInfo, bankAddress, mobile];

  @override
  String toString() {
    return 'BankcardForm(cardInfo: $cardInfo, bankAddress: $bankAddress, mobile: $mobile)' +
        '\nBankcardForm Status: ${this.status}';
  }

  Either<BankcardFormInputError, Unit> get validate => (this.status ==
          FormzStatus.valid)
      ? right(unit)
      : left(
          this.cardInfo.error ?? this.bankAddress.error ?? this.mobile.error);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bankname': this.cardInfo.value.cardOwner,
        'bankindex': this.cardInfo.value.bankId,
        'bankaccno': this.cardInfo.value.cardNumber,
        'bankaddress': this.bankAddress.value.branch,
        'bankprovince': this.bankAddress.value.province,
        'bankcity': this.bankAddress.value.area,
      };

  Map<String, dynamic> mobileToJson() => <String, dynamic>{
        'phone': this.mobile.value.mobile,
      };

  Map<String, dynamic> verifyToJson() => <String, dynamic>{
        'phone': this.mobile.value.mobile,
        'code': this.mobile.value.verifyCode,
      };
}

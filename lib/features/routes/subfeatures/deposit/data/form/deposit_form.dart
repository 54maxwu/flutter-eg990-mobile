import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit_form.freezed.dart';

@freezed
abstract class DepositDataForm with _$DepositDataForm {
  const factory DepositDataForm({
    @required int methodId,
    @Default(-1) int promoId,
    @Default(-1) int bankId,
    @required int bankIndex,
    @Default('') String name,
    @Default('-1') String amount,
    @Default('1') String gateway,
    @Default('') String remark,
    @Default(-1) int localBank,
    @Default('') String localBankCard,
  }) = _DepositDataForm;
}

extension DepositDataFormExtension on DepositDataForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    String amt = this.amount;
    if (Global.lang == 'zh' && !amt.contains('.')) amt += ".00";
    return <String, dynamic>{
      'account_name': (this.name != null) ? this.name : '',
      'amount': amt,
      'bankaccountid': this.bankId,
      'bankindex': this.bankIndex.toString(),
      'deposit_method': this.methodId.toString(),
      'promo': (this.promoId != -1) ? promoId : '',
//      'localbank': this.localBank ?? -1,
//      'localbankno': this.localBankCard ?? '',
//      'gateway': this.gateway ?? '1',
//      'remark': this.remark ?? '',
    };
  }

  bool get isValid =>
      amount != '-1' && amount.isNotEmpty && name.isNotEmpty && bankId != -1;
//      localBank != -1 &&
//      localBankCard.isNotEmpty &&
}

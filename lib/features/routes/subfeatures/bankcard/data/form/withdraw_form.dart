import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

part 'withdraw_form.freezed.dart';

@freezed
abstract class WithdrawForm with _$WithdrawForm {
  const factory WithdrawForm({
    @required String amount,
    @required String password,
    @required String type,
    @required int minimum,
  }) = _WithdrawForm;
}

extension WithdrawFormExtension on WithdrawForm {
  bool get isValid =>
      amount.isNotEmpty &&
      amount.strToInt >= minimum &&
      password.isNotEmpty &&
      type.isNotEmpty;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amount': this.amount,
      'password': this.password,
      'type': this.type,
    };
  }
}

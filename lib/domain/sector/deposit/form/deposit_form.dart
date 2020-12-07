import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show immutable, required;

import 'deposit_form_data.dart';

typedef OnDepositRequest = void Function(DepositForm);

@immutable
class DepositForm with FormzMixin {
  DepositForm({
    @required this.target,
    @required this.info,
  });

  final DepositTargetBank target;
  final DepositInfo info;

  @override
  List<FormzInput> get inputs => [target, info];

  @override
  String toString() {
    return 'DepositForm(target: $target, info: $info)' +
        '\nDepositForm Status: ${this.status}';
  }

  Either<DepositFormInputError, Unit> get validate =>
      (this.status == FormzStatus.valid)
          ? right(unit)
          : left(this.target.error ?? this.info.error);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'account_name': info.value.name,
        'amount': info.value.amountData.value.toString(),
        'bankaccountid': target.value.bankId,
        'bankindex': '${target.value.bankIndex}',
        'deposit_method': '${target.value.methodId}',
        'promo':
            (this.target.value.promoId != -1) ? '${target.value.promoId}' : '',
      };
}

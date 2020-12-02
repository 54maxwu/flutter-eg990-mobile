import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show immutable, required;

enum DepositFormInputError { TARGET, INFO, INFO_NAME, INFO_AMOUNT }

@immutable
class DepositTargetBankData {
  final int methodId;
  final int bankId;
  final int bankIndex;
  final int promoId;

  const DepositTargetBankData.empty({
    this.bankId = -1,
    this.bankIndex = -1,
    this.promoId = -1,
    this.methodId = -1,
  });

  const DepositTargetBankData.local({
    @required this.bankId,
    @required this.bankIndex,
    @required this.methodId,
    this.promoId = -1,
  });

  const DepositTargetBankData.online({
    @required this.bankId,
    @required this.bankIndex,
  })  : this.promoId = -1,
        this.methodId = 3;

  bool get isValid => bankId >= 0 && bankIndex >= 0;
}

@immutable
class DepositInfoData {
  final String name;
  final ValueRangeData amountData;
  final String gateway;

  const DepositInfoData.empty({
    this.name = '',
    this.amountData = const ValueRangeData.empty(),
    this.gateway = '',
  });

  const DepositInfoData.local({@required this.name, @required this.amountData})
      : this.gateway = '1',
        assert(name == null || name == '', 'Name is required'),
        assert(amountData == null, 'Deposit Amount Data is required');

  const DepositInfoData.online(
      {@required this.amountData, @required this.gateway})
      : this.name = '',
        assert(amountData == null, 'Deposit Amount Data is required');

  bool get isValidAmount => amountData.isInRange;

  bool get isValidName =>
      gateway.strToInt > 0 && ((gateway == '1') ? name.isNotEmpty : true);
}

class DepositTargetBank
    extends FormzInput<DepositTargetBankData, DepositFormInputError> {
  // Call super.pure to represent an unmodified form input.
  const DepositTargetBank.pure()
      : super.pure(const DepositTargetBankData.empty());

  // Call super.dirty to represent a modified form input.
  const DepositTargetBank.dirty({@required DepositTargetBankData data})
      : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  DepositFormInputError validator(DepositTargetBankData data) {
    return data.isValid ? null : DepositFormInputError.TARGET;
  }
}

class DepositInfo extends FormzInput<DepositInfoData, DepositFormInputError> {
  // Call super.pure to represent an unmodified form input.
  const DepositInfo.pure() : super.pure(const DepositInfoData.empty());

  // Call super.dirty to represent a modified form input.
  const DepositInfo.dirty({@required DepositInfoData data}) : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  DepositFormInputError validator(DepositInfoData data) {
    bool validName = data.isValidName;
    bool validAmount = data.isValidAmount;
    if (!validName && !validAmount) return DepositFormInputError.INFO;
    if (!validName) return DepositFormInputError.INFO_NAME;
    if (!validAmount) return DepositFormInputError.INFO_AMOUNT;
    return null;
  }
}

import 'package:flutter_eg990_mobile/application/internal/input_limit.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show immutable, required;
import 'package:flutter_eg990_mobile/utils/value_util.dart';

enum BankcardFormInputError {
  CARD,
  CARD_INFO,
  CARD_NO,
  ADDRESS,
  MOBILE,
  VERIFY
}

@immutable
class BankcardData {
  final String bankId;
  final String cardOwner;
  final String cardNumber;

  const BankcardData({
    this.bankId = '',
    this.cardOwner = '',
    this.cardNumber = '',
  });

  bool get isInfoValid => bankId.isNotEmpty && cardOwner.isNotEmpty;
  bool get isCardNumberValid => ValueRangeData(
        value: cardNumber.length,
        min: InputLimit.CARD_MIN,
        max: InputLimit.CARD_MAX,
      ).isInRange;
}

@immutable
class BankcardAddressData {
  final String branch;
  final String province;
  final String area;

  const BankcardAddressData({
    this.branch = '',
    this.province = '',
    this.area = '',
  });

  bool get isValid =>
      branch.isNotEmpty && province.isNotEmpty && area.isNotEmpty;
}

@immutable
class BankcardMobileData {
  final String mobile;
  final String verifyCode;

  const BankcardMobileData({
    this.mobile = '',
    this.verifyCode = '',
  });

  bool get isNumberValid =>
      mobile.isNotEmpty && mobile.length == InputLimit.PHONE_MAX;
  bool get hasVerifiedCode => verifyCode.isNotEmpty;
}

class BankcardNewData extends FormzInput<BankcardData, BankcardFormInputError> {
  // Call super.pure to represent an unmodified form input.
  const BankcardNewData.pure() : super.pure(const BankcardData());

  // Call super.dirty to represent a modified form input.
  const BankcardNewData.dirty({@required BankcardData data})
      : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  BankcardFormInputError validator(BankcardData data) {
    bool infoIsValid = data.isInfoValid;
    bool cardNumberIsValid = data.isCardNumberValid;
    if (!infoIsValid && !cardNumberIsValid) {
      return BankcardFormInputError.CARD;
    } else if (!infoIsValid) {
      return BankcardFormInputError.CARD_INFO;
    } else if (!cardNumberIsValid) {
      return BankcardFormInputError.CARD_NO;
    }
    return null;
  }
}

class BankcardNewAddress
    extends FormzInput<BankcardAddressData, BankcardFormInputError> {
  // Call super.pure to represent an unmodified form input.
  const BankcardNewAddress.pure() : super.pure(const BankcardAddressData());

  // Call super.dirty to represent a modified form input.
  const BankcardNewAddress.dirty({@required BankcardAddressData data})
      : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  BankcardFormInputError validator(BankcardAddressData data) {
    return data.isValid ? null : BankcardFormInputError.ADDRESS;
  }
}

class BankcardNewMobile
    extends FormzInput<BankcardMobileData, BankcardFormInputError> {
  // Call super.pure to represent an unmodified form input.
  const BankcardNewMobile.pure() : super.pure(const BankcardMobileData());

  // Call super.dirty to represent a modified form input.
  const BankcardNewMobile.dirty({@required BankcardMobileData data})
      : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  BankcardFormInputError validator(BankcardMobileData data) {
    return data.isNumberValid
        ? (data.hasVerifiedCode)
            ? null
            : BankcardFormInputError.VERIFY
        : BankcardFormInputError.MOBILE;
  }
}

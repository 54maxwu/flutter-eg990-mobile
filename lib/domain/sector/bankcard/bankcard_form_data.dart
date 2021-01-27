import 'package:flutter_eg990_mobile/application/internal/input_limit.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show immutable, required;
import 'package:flutter_eg990_mobile/utils/value_util.dart';

enum BankcardFormInputError {
  CARD_HOLDER,
  CARD_BANK,
  CARD_NO,
  ADDRESS,
  MOBILE,
  VERIFY
}

@immutable
class BankcardData {
  final String bankId;
  final String cardholder;
  final String cardNumber;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const BankcardData({
    this.bankId = '',
    this.cardholder = '',
    this.cardNumber = '',
  });

  BankcardData copyWith({
    String bankId,
    String cardholder,
    String cardNumber,
  }) {
    if ((bankId == null || identical(bankId, this.bankId)) &&
        (cardholder == null || identical(cardholder, this.cardholder)) &&
        (cardNumber == null || identical(cardNumber, this.cardNumber))) {
      return this;
    }

    return new BankcardData(
      bankId: bankId ?? this.bankId,
      cardholder: cardholder ?? this.cardholder,
      cardNumber: cardNumber ?? this.cardNumber,
    );
  }

  @override
  String toString() {
    return 'BankcardData{bankId: $bankId, cardholder: $cardholder, cardNumber: $cardNumber}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankcardData &&
          runtimeType == other.runtimeType &&
          bankId == other.bankId &&
          cardholder == other.cardholder &&
          cardNumber == other.cardNumber);

  @override
  int get hashCode =>
      bankId.hashCode ^ cardholder.hashCode ^ cardNumber.hashCode;

  factory BankcardData.fromMap(Map<String, dynamic> map) {
    return new BankcardData(
      bankId: map['bankId'] as String,
      cardholder: map['cardholder'] as String,
      cardNumber: map['cardNumber'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'bankId': this.bankId,
      'cardholder': this.cardholder,
      'cardNumber': this.cardNumber,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  bool get isCardholderValid => ValueRangeData(
        value: cardholder.length,
        min: InputLimit.NAME_MIN,
        max: InputLimit.NAME_MAX,
      ).isInRange;

  bool get isBankValid => bankId.isNotEmpty;

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

//<editor-fold desc="Data Methods" defaultstate="collapsed">
  BankcardAddressData copyWith({
    String branch,
    String province,
    String area,
  }) {
    if ((branch == null || identical(branch, this.branch)) &&
        (province == null || identical(province, this.province)) &&
        (area == null || identical(area, this.area))) {
      return this;
    }

    return new BankcardAddressData(
      branch: branch ?? this.branch,
      province: province ?? this.province,
      area: area ?? this.area,
    );
  }

  @override
  String toString() {
    return 'BankcardAddressData{branch: $branch, province: $province, area: $area}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankcardAddressData &&
          runtimeType == other.runtimeType &&
          branch == other.branch &&
          province == other.province &&
          area == other.area);

  @override
  int get hashCode => branch.hashCode ^ province.hashCode ^ area.hashCode;
//</editor-fold>

  bool get isValid => branch.isNotEmpty && province.isNotEmpty && area != null;
}

@immutable
class BankcardMobileData {
  final String mobile;
  final String verifyCode;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const BankcardMobileData({
    this.mobile = '',
    this.verifyCode = '',
  });

  BankcardMobileData copyWith({
    String mobile,
    String verifyCode,
  }) {
    if ((mobile == null || identical(mobile, this.mobile)) &&
        (verifyCode == null || identical(verifyCode, this.verifyCode))) {
      return this;
    }

    return new BankcardMobileData(
      mobile: mobile ?? this.mobile,
      verifyCode: verifyCode ?? this.verifyCode,
    );
  }

  @override
  String toString() {
    return 'BankcardMobileData{mobile: $mobile, verifyCode: $verifyCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankcardMobileData &&
          runtimeType == other.runtimeType &&
          mobile == other.mobile &&
          verifyCode == other.verifyCode);

  @override
  int get hashCode => mobile.hashCode ^ verifyCode.hashCode;

  factory BankcardMobileData.fromMap(Map<String, dynamic> map) {
    return new BankcardMobileData(
      mobile: map['mobile'] as String,
      verifyCode: map['verifyCode'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'mobile': this.mobile,
      'verifyCode': this.verifyCode,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  bool get isNumberValid =>
      mobile.isNotEmpty &&
      ValueRangeData(
        value: mobile.length,
        min: InputLimit.PHONE_MIN,
        max: InputLimit.PHONE_MAX,
      ).isInRange;
  bool get hasVerifyCode => verifyCode.isNotEmpty;
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
    if (!data.isCardholderValid) {
      return BankcardFormInputError.CARD_HOLDER;
    } else if (!data.isBankValid) {
      return BankcardFormInputError.CARD_BANK;
    } else if (!data.isCardNumberValid) {
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
    return null;
    // return data.isNumberValid
    //     ? (data.hasVerifyCode)
    //         ? null
    //         : BankcardFormInputError.VERIFY
    //     : BankcardFormInputError.MOBILE;
  }

  Map<String, dynamic> codeRequestJson() => <String, dynamic>{
        'phone': this.value.mobile,
      };

  Map<String, dynamic> verifyRequestJson() => <String, dynamic>{
        'phone': this.value.mobile,
        'code': this.value.verifyCode,
      };
}

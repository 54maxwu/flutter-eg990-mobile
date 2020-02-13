import 'package:email_validator/email_validator.dart';
import 'package:flutter_ty_mobile/features/home/domain/usecase/usecase_export.dart';

extension IntValueExtension on int {
  String valueToString({bool creditSign = false}) =>
      this.toString().trimValue(creditSign: creditSign);
}

extension DoubleValueExtension on double {
  String valueToString({bool floorValue = false, bool creditSign = false}) =>
      this.toString().trimValue(floorValue: floorValue, creditSign: creditSign);
}

extension ValueStringExtension on String {
  int get strToInt {
    try {
      if (this == null) return -1;
      if (contains('.'))
        return double.parse(this.replaceAll('￥', '').trim()).floor();
      else
        return int.parse(this.replaceAll('￥', '').trim());
    } catch (e) {
      MyLogger.warn(msg: 'parse value has exception', tag: 'strToInt');
      return -1;
    }
  }

  double get strToDouble {
    try {
      if (this == null) return double.parse('-1');
      return double.parse(this.replaceAll('￥', '').trim());
    } catch (e) {
      MyLogger.warn(msg: 'parse value has exception', tag: 'strToDouble');
      return double.parse('-1');
    }
  }

  bool isEqual(String secondString) {
    return this.strToDouble - secondString.strToDouble == 0.0;
  }

  String trimValue(
      {bool floorValue = false, bool floorIfInt, bool creditSign = false}) {
    try {
      var value = '';
      if (floorValue) // 50
        value = this.strToInt.toString();
      else if (floorIfInt && contains('.')) {
        // 50
        var endValue = this.split('.')[1];
        if (endValue.strToInt == 0) value = this.strToInt.toString();
      } else // 50.00
        value = this.strToDouble.toStringAsFixed(2);

      if (creditSign)
        return '￥ $value';
      else
        return value;
    } catch (e) {
      MyLogger.warn(msg: 'trim value has exception', tag: 'trimValue');
      return this;
    }
  }

  bool get isUrl => Uri.parse(this).isAbsolute;

  bool get isEmail => EmailValidator.validate(this);
}

import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart' show required;

/// Check if the [value] is bigger than [min], and smaller than [max]
bool rangeCheck({@required num value, @required int min, int max = 0}) {
  if (max != 0)
    return value >= min && value <= max;
  else
    return value >= min;
}

final numFormat = new NumberFormat("###0.00");
final creditFormat = new NumberFormat("￥#,##0.00");

String formatNum(num n, {bool addCreditSign = false, bool floorIfInt = false}) {
  final s = (addCreditSign) ? creditFormat.format(n) : numFormat.format(n);
  return (floorIfInt && s.endsWith('.00')) ? s.substring(0, s.indexOf('.')) : s;
}

String intToStr(int value, {bool creditSign = false}) =>
    formatValue(value, creditSign: creditSign);

String doubleToStr(double value,
        {bool floor = false,
        bool floorIfInt = false,
        bool creditSign = false}) =>
    formatValue(value,
        floor: floor, floorIfInt: floorIfInt, creditSign: creditSign);

int stringToInt(String str) {
  try {
    if (str == null || str.isEmpty) return -1;
    if (str.contains('.'))
      return double.parse(str.replaceAll(RegExp('￥|,'), '').trim()).floor();
    else
      return int.parse(str.replaceAll(RegExp('￥|,'), '').trim());
  } catch (e) {
    MyLogger.warn(msg: 'parse value has exception, str: $str', tag: 'strToInt');
    return -1;
  }
}

double stringToDouble(String str) {
  try {
    if (str == null || str.isEmpty) return double.parse('-1');
    return double.parse(str.replaceAll(RegExp('￥|,'), '').trim());
  } catch (e) {
    MyLogger.warn(msg: 'parse value has exception', tag: 'strToDouble');
    return double.parse('-1');
  }
}

bool valueIsEqual(String first, String second) {
  return stringToDouble(first).compareTo(stringToDouble(second)) == 0;
}

/// [floorValue] floor value to int
/// [floorIfInt] floor value to int if value is not double
/// [creditSign] add a credit sign as string prefix
String formatValue(
  dynamic value, {
  bool floor = false,
  bool floorIfInt = false,
  bool creditSign = false,
}) {
  num formatted = (value is int || value is double)
      ? value
      : double.parse(value.replaceAll(RegExp('￥|,'), '').trim());
  try {
    var result = formatNum(formatted,
        addCreditSign: creditSign, floorIfInt: floorIfInt || floor);
//    print('result: $result');
    return (floor && result.contains('.'))
        ? '${result.substring(0, result.indexOf('.'))}'.trim()
        : result.trim();
  } catch (e) {
    MyLogger.warn(msg: 'trim value has exception', tag: 'trimValue');
    print('trim value exception: $e');
    return '$formatted';
  }
}

extension ValueUtilExtension on String {
  int get strToInt => stringToInt(this);
  double get strToDouble => stringToDouble(this);
  String get basicFormat => formatValue(this);
}

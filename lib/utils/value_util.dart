import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart' show immutable, required;

@immutable
class ValueRangeData {
  final num value;
  final num min;
  final num max;

  const ValueRangeData.empty()
      : this.value = 0,
        this.min = 0,
        this.max = 0;

  const ValueRangeData.min({@required this.value, @required this.min})
      : this.max = 0;

  const ValueRangeData(
      {@required this.value, @required this.min, @required this.max});

  bool get isInRange {
    if (max != 0) {
      return value >= min && value <= max;
    } else {
      return value >= min;
    }
  }
}

/// Check if the [value] is bigger than [min], and smaller than [max]
bool rangeCheck({@required num value, @required num min, num max = 0}) {
  if (max != 0)
    return value >= min && value <= max;
  else
    return value >= min;
}

final String creditSymbol = '￥';
final NumberFormat numFormat = new NumberFormat("###0.00", "en_US");
final NumberFormat creditFormat = new NumberFormat("#,##0.00", "en_US");
final NumberFormat creditSignFormat =
    new NumberFormat("$creditSymbol#,##0.00", "en_US");
final RegExp replaceRegex = RegExp('$creditSymbol|,');

/// [floor] floor value to double
/// [floorToInt] floor value to int
/// [trimIfZero] if value to double is 0, return 0 or 0.00 based on [floorIfInt]
/// [creditSign] add a credit sign as string prefix
String formatValue(
  dynamic value, {
  bool floorToInt = false,
  bool trimIfZero = true,
  bool creditSign = false,
}) {
  try {
    num n;
    // parse dynamic value to num
    if (value is num) {
      n = value;
    } else if (value is String) {
      n = double.parse(value.replaceAll(replaceRegex, '').trim());
    } else {
      return (creditSign) ? '$creditSymbol$value' : '$value';
    }

    // format the num as credit
    final s =
        (creditSign) ? creditSignFormat.format(n) : creditFormat.format(n);
    debugPrint('formatted value: $s');

    // trim the string
    if (n == 0) {
      return (trimIfZero) ? s.substring(0, s.indexOf('.')) : s;
    } else if (floorToInt) {
      return s.substring(0, s.indexOf('.'));
    } else {
      return s;
    }
  } catch (e) {
    MyLogger.warn(msg: 'format value has exception: $e', tag: 'formatValue');
    return '$value';
  }
}

/// [addComma] use credit formatter if true, else use normal number formatter
/// [trimIfZero] if value to double is 0, return 0 or 0.00 based on [floorIfInt]
String formatNum(
  num n, {
  bool addComma = true,
  bool trimIfZero = true,
}) {
  final s = (addComma) ? creditFormat.format(n) : numFormat.format(n);
  if (s.strToDouble == 0) {
    return (trimIfZero) ? '0' : s;
  } else {
    return s;
  }
}

String intToStr(int value, {bool creditSign = false}) =>
    formatValue(value, creditSign: creditSign);

String doubleToStr(
  double value, {
  bool creditSign = false,
}) =>
    formatValue(
      value,
      creditSign: creditSign,
    );

int stringToInt(String str, {bool printErrorStack = true}) {
  try {
    if (str == null || str.isEmpty) return -1;
    if (str.contains('.'))
      return double.parse(str.replaceAll(replaceRegex, '').trim()).floor();
    else
      return int.parse(str.replaceAll(replaceRegex, '').trim());
  } catch (e, s) {
    MyLogger.warn(
        msg: (printErrorStack)
            ? 'parse value to int has exception, str: $str\nstack:\n$s'
            : 'parse value to int has exception, str: $str',
        tag: 'stringToInt');
    return -1;
  }
}

double stringToDouble(String str) {
  try {
    if (str == null || str.isEmpty) return double.parse('-1');
    return double.parse(str.replaceAll(replaceRegex, '').trim());
  } catch (e) {
    MyLogger.warn(
        msg: 'parse value to double has exception', tag: 'stringToDouble');
    return double.parse('-1');
  }
}

bool valueIsEqual(String first, String second) {
  return stringToDouble(first).compareTo(stringToDouble(second)) == 0;
}

extension ValueUtilExtension on String {
  int get strToInt => stringToInt(this);

  int get strToIntNoErrorStack => stringToInt(this, printErrorStack: false);

  double get strToDouble => stringToDouble(this);

  String get basicFormat => formatValue(this);
}

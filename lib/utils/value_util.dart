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
    // debugPrint('$min >= $value <= $max');
    if (max != 0) {
      return value >= min && value <= max;
    } else {
      return value >= min;
    }
  }
}

class ValueUtil {
  static final String creditSymbol = '￥';

  static RegExp get _replaceRegex => RegExp('$creditSymbol|,');

  static NumberFormat get _numFormat => NumberFormat("###0.00", "en_US");

  static NumberFormat get _creditFormat => NumberFormat("#,##0.00", "en_US");

  static NumberFormat get _creditSignFormat =>
      NumberFormat("$creditSymbol#,##0.00", "en_US");

  /// [addCreditSign] add a credit sign as string prefix
  /// [trimIfZero] if value to double is 0, return 0 if true else 0.00
  /// [floorToInt] floor value to int
  static String format(
    dynamic value, {
    bool addCreditSign = false,
    bool formatAsCredit = true,
    bool trimIfZero = true,
    bool floorToInt = false,
  }) {
    try {
      num n;
      // parse dynamic value to num
      if (value is num) {
        n = value;
      } else if (value is String) {
        n = num.parse(value.replaceAll(_replaceRegex, '').trim());
      } else {
        return (addCreditSign) ? '$creditSymbol$value' : '$value';
      }

      if (addCreditSign) {
        return toCreditSignFormat(
          n,
          trimIfZero: trimIfZero,
          floorToInt: floorToInt,
        );
      } else if (formatAsCredit) {
        return toCreditFormat(
          n,
          trimIfZero: trimIfZero,
          floorToInt: floorToInt,
        );
      } else {
        return toValueFormat(
          n,
          trimIfZero: trimIfZero,
          floorToInt: floorToInt,
        );
      }
    } catch (e, s) {
      MyLogger.warn(msg: 'format value has exception: $e', tag: 'ValueUtil');
      debugPrint('format value has exception:$e, value: $value\nstack:\n$s');
      return '$value';
    }
  }

  /// Format a num as credit, ex: 1,000
  /// [trimIfZero] if value to double is 0, return 0 or 0.00 based on [floorIfInt]
  static String toCreditSignFormat(
    num n, {
    bool trimIfZero = true,
    bool floorToInt = false,
  }) {
    final s = _creditSignFormat.format(n);
    if (s.strToDouble == 0) {
      return (trimIfZero) ? '0' : s;
    } else if (floorToInt) {
      return s.substring(0, s.indexOf('.'));
    } else {
      return s;
    }
  }

  /// Format a num as credit, ex: 1,000
  /// [trimIfZero] if value to double is 0, return 0 or 0.00 based on [floorIfInt]
  static String toCreditFormat(
    num n, {
    bool trimIfZero = true,
    bool floorToInt = false,
  }) {
    final s = _creditFormat.format(n);
    if (s.strToDouble == 0) {
      return (trimIfZero) ? '0' : s;
    } else if (floorToInt) {
      return s.substring(0, s.indexOf('.'));
    } else {
      return s;
    }
  }

  /// Format a num to value string, ex: 1000
  /// [trimIfZero] if value to double is 0, return 0 or 0.00 based on [floorIfInt]
  static String toValueFormat(
    num n, {
    bool trimIfZero = true,
    bool floorToInt = false,
  }) {
    final s = _numFormat.format(n);
    if (s.strToDouble == 0) {
      return (trimIfZero) ? '0' : s;
    } else if (floorToInt) {
      return s.substring(0, s.indexOf('.'));
    } else {
      return s;
    }
  }

  static int strToInt(String str, {bool printErrorStack = false}) {
    try {
      if (str == null || str.isEmpty) return -1;
      return num.parse(str.replaceAll(_replaceRegex, '').trim()).floor();
    } catch (e, s) {
      MyLogger.warn(
          msg: (printErrorStack)
              ? 'parse value to int has exception:$e, str: $str\nstack:\n$s'
              : 'parse value to int has exception:$e',
          tag: 'ValueUtil');
      debugPrint('parse value to int has exception:$e, str: $str\nstack:\n$s');
      return -1;
    }
  }

  static double strToDouble(String str, {bool printErrorStack = false}) {
    try {
      if (str == null || str.isEmpty) return -1;
      return double.parse(str.replaceAll(_replaceRegex, '').trim());
    } catch (e, s) {
      MyLogger.warn(
          msg: (printErrorStack)
              ? 'parse value to double has exception:$e, str: $str\nstack:\n$s'
              : 'parse value to double has exception:$e',
          tag: 'ValueUtil');
      debugPrint(
          'parse value to double has exception:$e, str: $str\nstack:\n$s');
      return -1;
    }
  }

  static bool isEqual(String first, String second) {
    debugPrint('comparing value, '
        'first: ${strToDouble(first)}, '
        'second: ${strToDouble(second)}');
    return strToDouble(first).compareTo(strToDouble(second)) == 0;
  }
}

extension ValueUtilExtension on String {
  int get strToIntDebug => ValueUtil.strToInt(this, printErrorStack: true);

  double get strToDoubleDebug =>
      ValueUtil.strToDouble(this, printErrorStack: true);

  int get strToInt => ValueUtil.strToInt(this);

  double get strToDouble => ValueUtil.strToDouble(this);

  String get basicFormat => ValueUtil.format(this);
}

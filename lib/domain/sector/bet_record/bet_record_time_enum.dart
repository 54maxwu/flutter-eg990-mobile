import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

@VnumDefinition
class BetRecordTimeEnum extends Vnum<int> {
  /// Case Definition
  static const BetRecordTimeEnum today = const BetRecordTimeEnum.define(0);
  static const BetRecordTimeEnum yesterday = const BetRecordTimeEnum.define(1);
  static const BetRecordTimeEnum month = const BetRecordTimeEnum.define(2);
  static const BetRecordTimeEnum all = const BetRecordTimeEnum.define(3);
  static const BetRecordTimeEnum custom = const BetRecordTimeEnum.define(4);

  /// Used for defining cases
  const BetRecordTimeEnum.define(int fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory BetRecordTimeEnum(int value) =>
      Vnum.fromValue(value, BetRecordTimeEnum);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(BetRecordTimeEnum);

  static List<BetRecordTimeEnum> get mapAll =>
      listAll.map((v) => v as BetRecordTimeEnum).toList();
}

extension BetRecordTimeEnumExtension on BetRecordTimeEnum {
  String get label {
    switch (value) {
      case 0:
        return localeStr.fieldOptionDateToday;
      case 1:
        return localeStr.fieldOptionDateYesterday;
      case 2:
        return localeStr.fieldOptionDateMonth;
      case 3:
        return localeStr.fieldOptionDateAll;
      case 4:
        return localeStr.fieldOptionDateCustom;
      default:
        return '??';
    }
  }
}

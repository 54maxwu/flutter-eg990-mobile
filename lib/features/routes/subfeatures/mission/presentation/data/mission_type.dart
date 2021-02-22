import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

class MissionType {
  final int id;
  final String listName;
  final String jsonKey;

  const MissionType(this.id, this.listName, this.jsonKey);
}

@VnumDefinition
class MissionTypeEnum extends Vnum<MissionType> implements DataOperator {
  /// Case Definition
  static const MissionTypeEnum daily =
      const MissionTypeEnum.define(MissionType(0, 'daily', 'day'));
  static const MissionTypeEnum weekly =
      const MissionTypeEnum.define(MissionType(1, 'weekly', 'week'));
  static const MissionTypeEnum monthly =
      const MissionTypeEnum.define(MissionType(2, 'monthly', 'month'));
  static const MissionTypeEnum once =
      const MissionTypeEnum.define(MissionType(3, 'once', 'once'));
  static const MissionTypeEnum limit =
      const MissionTypeEnum.define(MissionType(4, 'limit', 'limit'));

  /// Used for defining cases
  const MissionTypeEnum.define(MissionType fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory MissionTypeEnum(MissionType value) =>
      Vnum.fromValue(value, MissionTypeEnum);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<MissionTypeEnum> get mapAll => Vnum.allCasesFor(MissionTypeEnum)
      .map((e) => e as MissionTypeEnum)
      .toList();

  @override
  String operator [](String key) => this.label;

  String get label {
    switch (value.listName) {
      case 'daily':
        return localeStr.missionTabDaily;
      case 'weekly':
        return localeStr.missionTabWeekly;
      case 'monthly':
        return localeStr.missionTabMonthly;
      case 'once':
        return localeStr.missionTabOnce;
      case 'limit':
        return localeStr.missionTabLimit;
      default:
        return '???';
    }
  }
}

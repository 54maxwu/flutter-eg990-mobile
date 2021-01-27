import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

class AgentViewType {
  final int id;
  final String name;

  const AgentViewType(this.id, this.name);
}

@VnumDefinition
class AgentViewTypeEnum extends Vnum<AgentViewType> implements DataOperator {
  /// Case Definition
  static const AgentViewTypeEnum CHART =
      const AgentViewTypeEnum.define(AgentViewType(0, 'chart'));
  static const AgentViewTypeEnum LEDGER =
      const AgentViewTypeEnum.define(AgentViewType(1, 'ledger'));
  static const AgentViewTypeEnum COMMISSION =
      const AgentViewTypeEnum.define(AgentViewType(2, 'commission'));
  static const AgentViewTypeEnum LIST_GRAND =
      const AgentViewTypeEnum.define(AgentViewType(30, 'listGrand'));
  static const AgentViewTypeEnum LIST_MASTER =
      const AgentViewTypeEnum.define(AgentViewType(31, 'listMaster'));
  static const AgentViewTypeEnum LIST_AGENT =
      const AgentViewTypeEnum.define(AgentViewType(32, 'listAgent'));
  static const AgentViewTypeEnum LIST_MEMBER =
      const AgentViewTypeEnum.define(AgentViewType(33, 'listGeneral'));
  static const AgentViewTypeEnum VIEW_CARD =
      const AgentViewTypeEnum.define(AgentViewType(41, 'card'));
  static const AgentViewTypeEnum EDIT_CARD =
      const AgentViewTypeEnum.define(AgentViewType(42, 'edit'));

  /// Used for defining cases
  const AgentViewTypeEnum.define(AgentViewType fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory AgentViewTypeEnum(AgentViewType value) =>
      Vnum.fromValue(value, AgentViewTypeEnum);

  @override
  String operator [](String key) => this.label;

  String get label {
    switch (value.id) {
      case 0:
        return localeStr.agentTabTitleChart;
      case 1:
        return localeStr.agentTabTitleLedger;
      case 2:
        return localeStr.agentTabTitleCommission;
      case 30:
        return localeStr
            .agentTabTitleDownlineList(localeStr.agentAccountLevelGrandMaster);
      case 31:
        return localeStr
            .agentTabTitleDownlineList(localeStr.agentAccountLevelMaster);
      case 32:
        return localeStr
            .agentTabTitleDownlineList(localeStr.agentAccountLevelAgent);
      case 33:
        return localeStr
            .agentTabTitleDownlineList(localeStr.agentAccountLevelMember);
      case 41:
        return localeStr.pageTitleMemberCard;
      case 42:
        return localeStr.agentTabTitleCard;
      default:
        return '???';
    }
  }
}

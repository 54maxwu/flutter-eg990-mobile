import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

@VnumDefinition
class AgentLevel extends Vnum<int> {
  // 1公司  2大總代  3總代  4代理  5會員
  static const AgentLevel COMPANY = const AgentLevel.define(1);
  static const AgentLevel GRAND = const AgentLevel.define(2);
  static const AgentLevel MASTER = const AgentLevel.define(3);
  static const AgentLevel AGENT = const AgentLevel.define(4);
  static const AgentLevel MEMBER = const AgentLevel.define(5);
  static const AgentLevel UNKNOWN = const AgentLevel.define(-1);

  /// Used for defining cases
  const AgentLevel.define(int fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory AgentLevel(int value) => Vnum.fromValue(value, AgentLevel);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(AgentLevel);

  static AgentLevel getLevel(int level) => AgentLevel.listAll.singleWhere(
        (lv) => lv.value == level,
        orElse: () => AgentLevel.UNKNOWN,
      );
}

extension AgentLevelExtension on AgentLevel {
  String get getAccountTitle {
    String title;
    switch (this.value) {
      case 1:
        title = localeStr.agentAccountLevelCompany;
        break;
      case 2:
        title = localeStr.agentAccountLevelGrandMaster;
        break;
      case 3:
        title = localeStr.agentAccountLevelMaster;
        break;
      case 4:
        title = localeStr.agentAccountLevelAgent;
        break;
      case 5:
        title = localeStr.agentAccountLevelMember;
        break;
    }
    return localeStr.agentTitleAccount(title);
  }

  String get getDownlineAddHint {
    switch (this.value) {
      case 1:
        return localeStr.agentAddDownlineHint(
            localeStr.agentAccountLevelCompany,
            localeStr.agentAccountLevelGrandMaster);
      case 2:
        return localeStr.agentAddDownlineHint(
            localeStr.agentAccountLevelGrandMaster,
            localeStr.agentAccountLevelMaster);
      case 3:
        return localeStr.agentAddDownlineHint(localeStr.agentAccountLevelMaster,
            localeStr.agentAccountLevelAgent);
      case 4:
        return localeStr.agentAddDownlineHint(localeStr.agentAccountLevelAgent,
            localeStr.agentAccountLevelMember);
      default:
        return '';
    }
  }

  String get getDownlineTableProportionHeader {
    switch (this.value) {
      case 1:
      case 2:
      case 3:
      case 4:
        return localeStr.agentDownlineHeaderUpdateHint;
      default:
        return localeStr.agentDownlineHeaderUpdate;
    }
  }
}

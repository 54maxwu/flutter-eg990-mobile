import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

class MemberCenterTabData {
  final int id;
  final String category;

  const MemberCenterTabData(this.id, this.category);
}

@VnumDefinition
class MemberCenterTab extends Vnum<MemberCenterTabData>
    implements DataOperator {
  /// Case Definition
  static const MemberCenterTab info =
      const MemberCenterTab.define(MemberCenterTabData(0, 'info'));
  static const MemberCenterTab vip =
      const MemberCenterTab.define(MemberCenterTabData(1, 'vip'));

  /// Used for defining cases
  const MemberCenterTab.define(MemberCenterTabData fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory MemberCenterTab(MemberCenterTabData value) =>
      Vnum.fromValue(value, MemberCenterTab);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(MemberCenterTab);

  static List<MemberCenterTab> get mapAll =>
      listAll.map((v) => v as MemberCenterTab).toList();

  @override
  String operator [](String key) => this.label;

  String get label {
    switch (value.category) {
      case 'info':
        return localeStr.centerTabMemberData;
      case 'vip':
        return localeStr.centerTabVipRank;
      default:
        return '???';
    }
  }
}

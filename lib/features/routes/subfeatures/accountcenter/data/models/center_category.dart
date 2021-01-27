import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

class CenterCategory {
  final int id;
  final String category;

  const CenterCategory(this.id, this.category);
}

@VnumDefinition
class CenterCategoryEnum extends Vnum<CenterCategory> implements DataOperator {
  /// Case Definition
  static const CenterCategoryEnum info =
      const CenterCategoryEnum.define(CenterCategory(0, 'info'));
  static const CenterCategoryEnum vip =
      const CenterCategoryEnum.define(CenterCategory(1, 'vip'));
  static const CenterCategoryEnum lotto =
      const CenterCategoryEnum.define(CenterCategory(1, 'lotto'));

  /// Used for defining cases
  const CenterCategoryEnum.define(CenterCategory fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory CenterCategoryEnum(CenterCategory value) =>
      Vnum.fromValue(value, CenterCategoryEnum);

  @override
  String operator [](String key) => this.label;

  String get label {
    switch (value.category) {
      case 'info':
        return localeStr.centerViewTitleData;
      case 'vip':
        return localeStr.centerViewTitleVip;
      case 'lotto':
        return localeStr.centerViewTitleLotto;
      default:
        return '???';
    }
  }
}

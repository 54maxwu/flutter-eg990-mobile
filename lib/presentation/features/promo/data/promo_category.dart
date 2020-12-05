import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:vnum/vnum.dart';

class PromoCategory {
  final int id;
  final String category;

  const PromoCategory(this.id, this.category);

  @override
  String toString() => 'PromoCategory(id:$id, category:$category)';
}

@VnumDefinition
class PromoCategoryEnum extends Vnum<PromoCategory> implements DataOperator {
  /// Case Definition
  static const PromoCategoryEnum all =
      const PromoCategoryEnum.define(PromoCategory(0, 'All'));
  static const PromoCategoryEnum fish =
      const PromoCategoryEnum.define(PromoCategory(1, 'fish'));
  static const PromoCategoryEnum slot =
      const PromoCategoryEnum.define(PromoCategory(2, 'slot'));
  static const PromoCategoryEnum live =
      const PromoCategoryEnum.define(PromoCategory(3, 'live'));
  static const PromoCategoryEnum sport =
      const PromoCategoryEnum.define(PromoCategory(4, 'sports'));
  static const PromoCategoryEnum lottery =
      const PromoCategoryEnum.define(PromoCategory(5, 'lotto'));
  static const PromoCategoryEnum other =
      const PromoCategoryEnum.define(PromoCategory(6, 'other'));

  /// Used for defining cases
  const PromoCategoryEnum.define(PromoCategory fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory PromoCategoryEnum(PromoCategory value) =>
      Vnum.fromValue(value, PromoCategoryEnum);

  /// Iterating cases
  static Iterable get listAll => Vnum.allCasesFor(PromoCategoryEnum);

  static List<PromoCategoryEnum> filteredList(
      List<String> includeCategoryList) {
    final list = listAll.map((e) => e as PromoCategoryEnum).toList();
    list.removeWhere((element) =>
        !(includeCategoryList.contains(element.value.category)) &&
        element.value.id != 0);
    return list;
  }

  @override
  String operator [](String key) => this.label;

  String get label {
    switch (value.category) {
      case 'All':
        return localeStr.gameCategoryAll;
      case 'fish':
        return localeStr.gameCategoryFish;
      case 'slot':
        return localeStr.gameCategorySlot;
      case 'live':
        return localeStr.gameCategoryCasino;
      case 'sports':
        return localeStr.gameCategorySport;
      case 'lotto':
        return localeStr.gameCategoryLottery;
      case 'other':
        return localeStr.gameCategoryOther;
      default:
        return '???';
    }
  }
}

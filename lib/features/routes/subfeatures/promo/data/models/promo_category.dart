import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:meta/meta.dart';
import 'package:vnum/vnum.dart';

class PromoCategory {
  final int id;
  final String category;
  final String iconUrl;

  const PromoCategory(
      {@required this.id, @required this.category, @required this.iconUrl});
}

@VnumDefinition
class PromoCategoryEnum extends Vnum<PromoCategory> implements DataOperator {
  /// Case Definition
  static const PromoCategoryEnum all =
      const PromoCategoryEnum.define(PromoCategory(
    id: 0,
    category: 'All',
    iconUrl: 'images/index/all.png',
  ));
  static const PromoCategoryEnum fish =
      const PromoCategoryEnum.define(PromoCategory(
    id: 1,
    category: 'fish',
    iconUrl: 'images/index/fish.png',
  ));
  static const PromoCategoryEnum slot =
      const PromoCategoryEnum.define(PromoCategory(
    id: 2,
    category: 'slot',
    iconUrl: 'images/index/slot.png',
  ));
  static const PromoCategoryEnum live =
      const PromoCategoryEnum.define(PromoCategory(
    id: 3,
    category: 'live',
    iconUrl: 'images/index/casino.png',
  ));
  static const PromoCategoryEnum sport =
      const PromoCategoryEnum.define(PromoCategory(
    id: 4,
    category: 'sports',
    iconUrl: 'images/index/sport.png',
  ));
  static const PromoCategoryEnum lottery =
      const PromoCategoryEnum.define(PromoCategory(
    id: 5,
    category: 'lotto',
    iconUrl: 'images/index/lottery.png',
  ));
  static const PromoCategoryEnum other =
      const PromoCategoryEnum.define(PromoCategory(
    id: 6,
    category: 'other',
    iconUrl: 'images/index/icon-other.png',
  ));

  /// Used for defining cases
  const PromoCategoryEnum.define(PromoCategory fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory PromoCategoryEnum(PromoCategory value) =>
      Vnum.fromValue(value, PromoCategoryEnum);

  /// Iterating cases
  Iterable get listAll => Vnum.allCasesFor(PromoCategoryEnum);

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

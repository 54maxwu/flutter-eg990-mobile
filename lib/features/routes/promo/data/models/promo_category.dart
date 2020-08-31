import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

class PromoCategory {
  final int id;
  final String category;
  final String label;
  final String iconUrl;

  const PromoCategory(this.id, this.category, this.label, this.iconUrl);
}

@VnumDefinition
class PromoCategoryEnum extends Vnum<PromoCategory> implements DataOperator {
  /// Case Definition
  static final PromoCategoryEnum all = PromoCategoryEnum.define(PromoCategory(
      0, 'All', localeStr.gameCategoryAll, 'images/index/all.png'));
  static final PromoCategoryEnum fish = PromoCategoryEnum.define(PromoCategory(
      1, 'fish', localeStr.gameCategoryFish, 'images/index/fish.png'));
  static final PromoCategoryEnum slot = PromoCategoryEnum.define(PromoCategory(
      2, 'slot', localeStr.gameCategorySlot, 'images/index/slot.png'));
  static final PromoCategoryEnum live = PromoCategoryEnum.define(PromoCategory(
      3, 'live', localeStr.gameCategoryCasino, 'images/index/casino.png'));
  static final PromoCategoryEnum sport = PromoCategoryEnum.define(PromoCategory(
      4, 'sports', localeStr.gameCategorySport, 'images/index/sport.png'));
  static final PromoCategoryEnum lottery = PromoCategoryEnum.define(
      PromoCategory(5, 'lotto', localeStr.gameCategoryLottery,
          'images/index/lottery.png'));
  static final PromoCategoryEnum other = PromoCategoryEnum.define(PromoCategory(
      6, 'other', localeStr.gameCategoryOther, 'images/index/icon-other.png'));

  /// Used for defining cases
  const PromoCategoryEnum.define(PromoCategory fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory PromoCategoryEnum(PromoCategory value) =>
      Vnum.fromValue(value, PromoCategoryEnum);

  /// Iterating cases
  Iterable get listAll => Vnum.allCasesFor(PromoCategoryEnum);

  @override
  String operator [](String key) {
    throw UnimplementedError();
  }

  /// (optional) Extend your Vnums
  //PromoCategory example() {
  //  switch(value) {
  //    default:
  //      return PromoCategoryEnum.example.value;
  //  };
  //}
}

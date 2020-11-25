import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'promo_entity.freezed.dart';
part 'promo_entity.g.dart';

@freezed
abstract class PromoEntity with _$PromoEntity {
  @HiveType(typeId: 121)
  const factory PromoEntity({
    @HiveField(0) @required int id,
    @HiveField(1) @required String name,
    @HiveField(2) @required String bannerMobile,
    @HiveField(3) @required String textContent,
    @HiveField(4) @required String placeContent,
    @HiveField(5) @required String applyContent,
    @HiveField(6) @required String ruleContent,
    @HiveField(7) @required String top,
    @HiveField(8) @required int sort,
    @HiveField(9) @required int postCategoryId,
    @HiveField(10) @required String categoryStr,
    @HiveField(11) @required String status,
    @HiveField(12) @required String activeDate,
  }) = _PromoEntity;
}

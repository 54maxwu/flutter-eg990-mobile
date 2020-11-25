import 'package:freezed_annotation/freezed_annotation.dart';

import 'promo_entity.dart';

part 'promo_model.freezed.dart';
part 'promo_model.g.dart';

@freezed
abstract class PromoModel with _$PromoModel {
  const factory PromoModel({
    @required int id,
    @JsonKey(name: 'post_category_id') int postCategoryId,
    @required String name,
    @required String banner,
    @JsonKey(name: 'banner_mobile') String bannerMobile,
    @JsonKey(name: 'text_content') String textContent,
    @JsonKey(name: 'place_content') String placeContent,
    @JsonKey(name: 'apply_content') String applyContent,
    @JsonKey(name: 'rule_content') String ruleContent,
    @JsonKey(name: 'act_time') String actTime,
    @JsonKey(name: 'only_table') String onlyTable,
    @required String top,
    @required String status,
    @required int sort,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
    @required String categoryStr,
  }) = _PromoModel;

  factory PromoModel.fromJson(Map<String, dynamic> json) =>
      _$PromoModelFromJson(json);

  static PromoModel jsonToModel(Map<String, dynamic> jsonMap) =>
      PromoModel.fromJson(jsonMap);
}

extension PromoModelExtension on PromoModel {
  PromoEntity get entity => PromoEntity(
        id: id,
        name: name,
        bannerMobile: bannerMobile,
        textContent: textContent,
        placeContent: placeContent,
        applyContent: applyContent,
        ruleContent: ruleContent,
        top: top,
        sort: sort,
        postCategoryId: postCategoryId,
        categoryStr: categoryStr,
        status: status,
        activeDate: actTime,
      );
}

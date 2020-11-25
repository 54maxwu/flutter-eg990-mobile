// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromoModel _$_$_PromoModelFromJson(Map<String, dynamic> json) {
  return _$_PromoModel(
    id: json['id'] as int,
    postCategoryId: json['post_category_id'] as int,
    name: json['name'] as String,
    banner: json['banner'] as String,
    bannerMobile: json['banner_mobile'] as String,
    textContent: json['text_content'] as String,
    placeContent: json['place_content'] as String,
    applyContent: json['apply_content'] as String,
    ruleContent: json['rule_content'] as String,
    actTime: json['act_time'] as String,
    onlyTable: json['only_table'] as String,
    top: json['top'] as String,
    status: json['status'] as String,
    sort: json['sort'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    categoryStr: json['categoryStr'] as String,
  );
}

Map<String, dynamic> _$_$_PromoModelToJson(_$_PromoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_category_id': instance.postCategoryId,
      'name': instance.name,
      'banner': instance.banner,
      'banner_mobile': instance.bannerMobile,
      'text_content': instance.textContent,
      'place_content': instance.placeContent,
      'apply_content': instance.applyContent,
      'rule_content': instance.ruleContent,
      'act_time': instance.actTime,
      'only_table': instance.onlyTable,
      'top': instance.top,
      'status': instance.status,
      'sort': instance.sort,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'categoryStr': instance.categoryStr,
    };

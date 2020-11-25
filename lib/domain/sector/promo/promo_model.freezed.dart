// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'promo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
PromoModel _$PromoModelFromJson(Map<String, dynamic> json) {
  return _PromoModel.fromJson(json);
}

/// @nodoc
class _$PromoModelTearOff {
  const _$PromoModelTearOff();

// ignore: unused_element
  _PromoModel call(
      {@required int id,
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
      @required String categoryStr}) {
    return _PromoModel(
      id: id,
      postCategoryId: postCategoryId,
      name: name,
      banner: banner,
      bannerMobile: bannerMobile,
      textContent: textContent,
      placeContent: placeContent,
      applyContent: applyContent,
      ruleContent: ruleContent,
      actTime: actTime,
      onlyTable: onlyTable,
      top: top,
      status: status,
      sort: sort,
      createdAt: createdAt,
      updatedAt: updatedAt,
      categoryStr: categoryStr,
    );
  }

// ignore: unused_element
  PromoModel fromJson(Map<String, Object> json) {
    return PromoModel.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $PromoModel = _$PromoModelTearOff();

/// @nodoc
mixin _$PromoModel {
  int get id;
  @JsonKey(name: 'post_category_id')
  int get postCategoryId;
  String get name;
  String get banner;
  @JsonKey(name: 'banner_mobile')
  String get bannerMobile;
  @JsonKey(name: 'text_content')
  String get textContent;
  @JsonKey(name: 'place_content')
  String get placeContent;
  @JsonKey(name: 'apply_content')
  String get applyContent;
  @JsonKey(name: 'rule_content')
  String get ruleContent;
  @JsonKey(name: 'act_time')
  String get actTime;
  @JsonKey(name: 'only_table')
  String get onlyTable;
  String get top;
  String get status;
  int get sort;
  @JsonKey(name: 'created_at')
  String get createdAt;
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  String get categoryStr;

  Map<String, dynamic> toJson();
  $PromoModelCopyWith<PromoModel> get copyWith;
}

/// @nodoc
abstract class $PromoModelCopyWith<$Res> {
  factory $PromoModelCopyWith(
          PromoModel value, $Res Function(PromoModel) then) =
      _$PromoModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @JsonKey(name: 'post_category_id') int postCategoryId,
      String name,
      String banner,
      @JsonKey(name: 'banner_mobile') String bannerMobile,
      @JsonKey(name: 'text_content') String textContent,
      @JsonKey(name: 'place_content') String placeContent,
      @JsonKey(name: 'apply_content') String applyContent,
      @JsonKey(name: 'rule_content') String ruleContent,
      @JsonKey(name: 'act_time') String actTime,
      @JsonKey(name: 'only_table') String onlyTable,
      String top,
      String status,
      int sort,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      String categoryStr});
}

/// @nodoc
class _$PromoModelCopyWithImpl<$Res> implements $PromoModelCopyWith<$Res> {
  _$PromoModelCopyWithImpl(this._value, this._then);

  final PromoModel _value;
  // ignore: unused_field
  final $Res Function(PromoModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object postCategoryId = freezed,
    Object name = freezed,
    Object banner = freezed,
    Object bannerMobile = freezed,
    Object textContent = freezed,
    Object placeContent = freezed,
    Object applyContent = freezed,
    Object ruleContent = freezed,
    Object actTime = freezed,
    Object onlyTable = freezed,
    Object top = freezed,
    Object status = freezed,
    Object sort = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object categoryStr = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      postCategoryId: postCategoryId == freezed
          ? _value.postCategoryId
          : postCategoryId as int,
      name: name == freezed ? _value.name : name as String,
      banner: banner == freezed ? _value.banner : banner as String,
      bannerMobile: bannerMobile == freezed
          ? _value.bannerMobile
          : bannerMobile as String,
      textContent:
          textContent == freezed ? _value.textContent : textContent as String,
      placeContent: placeContent == freezed
          ? _value.placeContent
          : placeContent as String,
      applyContent: applyContent == freezed
          ? _value.applyContent
          : applyContent as String,
      ruleContent:
          ruleContent == freezed ? _value.ruleContent : ruleContent as String,
      actTime: actTime == freezed ? _value.actTime : actTime as String,
      onlyTable: onlyTable == freezed ? _value.onlyTable : onlyTable as String,
      top: top == freezed ? _value.top : top as String,
      status: status == freezed ? _value.status : status as String,
      sort: sort == freezed ? _value.sort : sort as int,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      categoryStr:
          categoryStr == freezed ? _value.categoryStr : categoryStr as String,
    ));
  }
}

/// @nodoc
abstract class _$PromoModelCopyWith<$Res> implements $PromoModelCopyWith<$Res> {
  factory _$PromoModelCopyWith(
          _PromoModel value, $Res Function(_PromoModel) then) =
      __$PromoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @JsonKey(name: 'post_category_id') int postCategoryId,
      String name,
      String banner,
      @JsonKey(name: 'banner_mobile') String bannerMobile,
      @JsonKey(name: 'text_content') String textContent,
      @JsonKey(name: 'place_content') String placeContent,
      @JsonKey(name: 'apply_content') String applyContent,
      @JsonKey(name: 'rule_content') String ruleContent,
      @JsonKey(name: 'act_time') String actTime,
      @JsonKey(name: 'only_table') String onlyTable,
      String top,
      String status,
      int sort,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      String categoryStr});
}

/// @nodoc
class __$PromoModelCopyWithImpl<$Res> extends _$PromoModelCopyWithImpl<$Res>
    implements _$PromoModelCopyWith<$Res> {
  __$PromoModelCopyWithImpl(
      _PromoModel _value, $Res Function(_PromoModel) _then)
      : super(_value, (v) => _then(v as _PromoModel));

  @override
  _PromoModel get _value => super._value as _PromoModel;

  @override
  $Res call({
    Object id = freezed,
    Object postCategoryId = freezed,
    Object name = freezed,
    Object banner = freezed,
    Object bannerMobile = freezed,
    Object textContent = freezed,
    Object placeContent = freezed,
    Object applyContent = freezed,
    Object ruleContent = freezed,
    Object actTime = freezed,
    Object onlyTable = freezed,
    Object top = freezed,
    Object status = freezed,
    Object sort = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object categoryStr = freezed,
  }) {
    return _then(_PromoModel(
      id: id == freezed ? _value.id : id as int,
      postCategoryId: postCategoryId == freezed
          ? _value.postCategoryId
          : postCategoryId as int,
      name: name == freezed ? _value.name : name as String,
      banner: banner == freezed ? _value.banner : banner as String,
      bannerMobile: bannerMobile == freezed
          ? _value.bannerMobile
          : bannerMobile as String,
      textContent:
          textContent == freezed ? _value.textContent : textContent as String,
      placeContent: placeContent == freezed
          ? _value.placeContent
          : placeContent as String,
      applyContent: applyContent == freezed
          ? _value.applyContent
          : applyContent as String,
      ruleContent:
          ruleContent == freezed ? _value.ruleContent : ruleContent as String,
      actTime: actTime == freezed ? _value.actTime : actTime as String,
      onlyTable: onlyTable == freezed ? _value.onlyTable : onlyTable as String,
      top: top == freezed ? _value.top : top as String,
      status: status == freezed ? _value.status : status as String,
      sort: sort == freezed ? _value.sort : sort as int,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      categoryStr:
          categoryStr == freezed ? _value.categoryStr : categoryStr as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_PromoModel implements _PromoModel {
  const _$_PromoModel(
      {@required this.id,
      @JsonKey(name: 'post_category_id') this.postCategoryId,
      @required this.name,
      @required this.banner,
      @JsonKey(name: 'banner_mobile') this.bannerMobile,
      @JsonKey(name: 'text_content') this.textContent,
      @JsonKey(name: 'place_content') this.placeContent,
      @JsonKey(name: 'apply_content') this.applyContent,
      @JsonKey(name: 'rule_content') this.ruleContent,
      @JsonKey(name: 'act_time') this.actTime,
      @JsonKey(name: 'only_table') this.onlyTable,
      @required this.top,
      @required this.status,
      @required this.sort,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @required this.categoryStr})
      : assert(id != null),
        assert(name != null),
        assert(banner != null),
        assert(top != null),
        assert(status != null),
        assert(sort != null),
        assert(categoryStr != null);

  factory _$_PromoModel.fromJson(Map<String, dynamic> json) =>
      _$_$_PromoModelFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'post_category_id')
  final int postCategoryId;
  @override
  final String name;
  @override
  final String banner;
  @override
  @JsonKey(name: 'banner_mobile')
  final String bannerMobile;
  @override
  @JsonKey(name: 'text_content')
  final String textContent;
  @override
  @JsonKey(name: 'place_content')
  final String placeContent;
  @override
  @JsonKey(name: 'apply_content')
  final String applyContent;
  @override
  @JsonKey(name: 'rule_content')
  final String ruleContent;
  @override
  @JsonKey(name: 'act_time')
  final String actTime;
  @override
  @JsonKey(name: 'only_table')
  final String onlyTable;
  @override
  final String top;
  @override
  final String status;
  @override
  final int sort;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @override
  final String categoryStr;

  @override
  String toString() {
    return 'PromoModel(id: $id, postCategoryId: $postCategoryId, name: $name, banner: $banner, bannerMobile: $bannerMobile, textContent: $textContent, placeContent: $placeContent, applyContent: $applyContent, ruleContent: $ruleContent, actTime: $actTime, onlyTable: $onlyTable, top: $top, status: $status, sort: $sort, createdAt: $createdAt, updatedAt: $updatedAt, categoryStr: $categoryStr)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PromoModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.postCategoryId, postCategoryId) ||
                const DeepCollectionEquality()
                    .equals(other.postCategoryId, postCategoryId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.banner, banner) ||
                const DeepCollectionEquality().equals(other.banner, banner)) &&
            (identical(other.bannerMobile, bannerMobile) ||
                const DeepCollectionEquality()
                    .equals(other.bannerMobile, bannerMobile)) &&
            (identical(other.textContent, textContent) ||
                const DeepCollectionEquality()
                    .equals(other.textContent, textContent)) &&
            (identical(other.placeContent, placeContent) ||
                const DeepCollectionEquality()
                    .equals(other.placeContent, placeContent)) &&
            (identical(other.applyContent, applyContent) ||
                const DeepCollectionEquality()
                    .equals(other.applyContent, applyContent)) &&
            (identical(other.ruleContent, ruleContent) ||
                const DeepCollectionEquality()
                    .equals(other.ruleContent, ruleContent)) &&
            (identical(other.actTime, actTime) ||
                const DeepCollectionEquality()
                    .equals(other.actTime, actTime)) &&
            (identical(other.onlyTable, onlyTable) ||
                const DeepCollectionEquality()
                    .equals(other.onlyTable, onlyTable)) &&
            (identical(other.top, top) ||
                const DeepCollectionEquality().equals(other.top, top)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.categoryStr, categoryStr) ||
                const DeepCollectionEquality()
                    .equals(other.categoryStr, categoryStr)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(postCategoryId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(banner) ^
      const DeepCollectionEquality().hash(bannerMobile) ^
      const DeepCollectionEquality().hash(textContent) ^
      const DeepCollectionEquality().hash(placeContent) ^
      const DeepCollectionEquality().hash(applyContent) ^
      const DeepCollectionEquality().hash(ruleContent) ^
      const DeepCollectionEquality().hash(actTime) ^
      const DeepCollectionEquality().hash(onlyTable) ^
      const DeepCollectionEquality().hash(top) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(categoryStr);

  @override
  _$PromoModelCopyWith<_PromoModel> get copyWith =>
      __$PromoModelCopyWithImpl<_PromoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PromoModelToJson(this);
  }
}

abstract class _PromoModel implements PromoModel {
  const factory _PromoModel(
      {@required int id,
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
      @required String categoryStr}) = _$_PromoModel;

  factory _PromoModel.fromJson(Map<String, dynamic> json) =
      _$_PromoModel.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'post_category_id')
  int get postCategoryId;
  @override
  String get name;
  @override
  String get banner;
  @override
  @JsonKey(name: 'banner_mobile')
  String get bannerMobile;
  @override
  @JsonKey(name: 'text_content')
  String get textContent;
  @override
  @JsonKey(name: 'place_content')
  String get placeContent;
  @override
  @JsonKey(name: 'apply_content')
  String get applyContent;
  @override
  @JsonKey(name: 'rule_content')
  String get ruleContent;
  @override
  @JsonKey(name: 'act_time')
  String get actTime;
  @override
  @JsonKey(name: 'only_table')
  String get onlyTable;
  @override
  String get top;
  @override
  String get status;
  @override
  int get sort;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override
  String get categoryStr;
  @override
  _$PromoModelCopyWith<_PromoModel> get copyWith;
}

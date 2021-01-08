import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart' show required;

import 'game_category.dart';
import 'game_category_info.dart';
import 'game_category_map.dart';

part 'game_category_entity.freezed.dart';
part 'game_category_entity.g.dart';

@freezed
abstract class GameCategoryEntity
    implements _$GameCategoryEntity, DataOperator {
  const GameCategoryEntity._();

  @HiveType(typeId: 111)
  const factory GameCategoryEntity({
    @HiveField(0) @required String type,
    GameCategory info,
  }) = _GameCategoryEntity;

  @override
  String operator [](String key) => '$type';
}

extension GameCategoryEntityExtension on GameCategoryEntity {
  GameCategory get getCategory => gameCategoryMap[type];

  /// category name on home tab item
  String get label => info.value.label ?? '?';

  GamePageType get pageType => info.value.pageType;

  GameCategoryIconType get iconType => info.value.iconType;

  String get imageUrl => info.value.imageUrl;

  String get assetPath => info.value.assetPath;

  String get selectedAssetPath => info.value.selectedAssetPath;
}

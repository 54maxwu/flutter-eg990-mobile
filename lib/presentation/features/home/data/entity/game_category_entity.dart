import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_category_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart' show required;

import 'game_category.dart';
import 'game_category_info.dart';

part 'game_category_entity.freezed.dart';
part 'game_category_entity.g.dart';

@freezed
abstract class GameCategoryEntity
    implements _$GameCategoryEntity, DataOperator {
  const GameCategoryEntity._();

  @HiveType(typeId: 103)
  const factory GameCategoryEntity({
    @HiveField(0) @required String type,
    GameCategory info,
  }) = _GameCategoryEntity;

  @override
  String operator [](String key) => '$type';
}

extension GameCategoryEntityExtension on GameCategoryEntity {
  GameCategory get getCategory => gameCategoryMap[type];

  String get label => info.value.label ?? '?';

  GamePageType get pageType => info.value.pageType;

  GameCategoryIconType get iconType => info.value.iconType;

  String get imageUrl => info.value.imageUrl;

  String get assetPath => info.value.assetPath;

  String get selectedAssetPath => info.value.selectedAssetPath;
}

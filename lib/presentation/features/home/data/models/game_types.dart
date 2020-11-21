import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_category_entity.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_platform_entity.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_category_model.dart';
import 'game_platform_model.dart';

part 'game_types.freezed.dart';

@freezed
abstract class GameTypes with _$GameTypes {
  const factory GameTypes({
    @JsonKey(name: 'category', fromJson: _decodeGameCategories, defaultValue: [])
        List<GameCategoryEntity> categories,
    @JsonKey(name: 'list', fromJson: _decodeGamePlatforms, defaultValue: [])
        List<GamePlatformEntity> platforms,
  }) = _GameTypes;

  static GameTypes jsonToGameTypes(Map<String, dynamic> jsonMap) =>
      _$_GameTypes(
        categories: jsonMap['category'] != null
            ? _decodeGameCategories(jsonMap['category'])
            : [],
        platforms: jsonMap['list'] != null
            ? _decodeGamePlatforms(jsonMap['list'])
            : [],
      );
}

List<GameCategoryEntity> _decodeGameCategories(dynamic str) =>
    JsonUtil.decodeArrayToModel(
      str,
      (jsonMap) => GameCategoryModel.jsonToModel(jsonMap).entity,
      tag: 'GameCategoryModel',
    );

List<GamePlatformEntity> _decodeGamePlatforms(dynamic str) =>
    JsonUtil.decodeArrayToModel(
      str,
      (jsonMap) => GamePlatformModel.jsonToModel(jsonMap).entity,
      tag: 'GamePlatformModel',
    );

extension GameTypesExtension on GameTypes {
  bool get isValid => categories.isNotEmpty && platforms.isNotEmpty;

  String get debug =>
      'categories=${categories.length} platforms=${platforms.length}';
}

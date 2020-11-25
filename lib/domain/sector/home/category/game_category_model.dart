import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_category.dart';
import 'game_category_entity.dart';
import 'game_category_map.dart';

part 'game_category_model.freezed.dart';

@freezed
abstract class GameCategoryModel implements _$GameCategoryModel, DataOperator {
  const GameCategoryModel._();

  const factory GameCategoryModel({
    @required String ch,
    @required String type,
  }) = _GameCategoryModel;

  static GameCategoryModel jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_GameCategoryModel(
        ch: jsonMap['ch'] as String,
        type: jsonMap['type'] as String,
      );

  @override
  String operator [](String key) {
    return type.toString();
  }
}

extension GameCategoryModelExtension on GameCategoryModel {
  GameCategoryEntity get entity => GameCategoryEntity(
        type: type,
        info: gameCategoryMap[type] ?? GameCategory.undefined,
      );
}

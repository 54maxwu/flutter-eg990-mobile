import 'package:flutter_eg990_mobile/domain/sector/home/category/game_category_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/category/game_category_entity.dart';

class LocalGameCategory {
  ///
  /// Defines [GameCategoryModel] that does not come with json
  /// to add additional tabs in home page
  ///
// final GameCategoryModel cockfightingCategory = GameCategoryModel(
//     type: 'cockfighting', ch: '斗鸡', info: GameCategory.cockfighting);

  static final GameCategoryModel _esportCategoryModel =
      GameCategoryModel(type: 'esport', ch: '电竞');

  /// Entity Getters
  static GameCategoryEntity get esportCategory => _esportCategoryModel.entity;
}

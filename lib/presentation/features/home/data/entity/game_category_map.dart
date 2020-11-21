import 'game_category.dart';

///
/// A Map to get [GameCategory] data by [GameCategoryModel].type
///
final Map<String, GameCategory> gameCategoryMap = {
  'casino': GameCategory.casino,
  'slot': GameCategory.slot,
  'sport': GameCategory.sport,
  'fish': GameCategory.fish,
  'lottery': GameCategory.lottery,
  'card': GameCategory.card,
};

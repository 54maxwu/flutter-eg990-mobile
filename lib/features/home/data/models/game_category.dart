part of 'game_category_model.dart';

class GameCategoryInfo {
  final String iconUrl;
  final String label;

  const GameCategoryInfo(this.iconUrl, this.label);
}

@VnumDefinition
class GameCategory extends Vnum<GameCategoryInfo> {
  /// Case Definition
  static final GameCategory casino = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_casino.png', localeStr.gameCategoryCasinoFull));
  static final GameCategory slot = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_slot.png', localeStr.gameCategorySlotFull));
  static final GameCategory sport = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_sport.png', localeStr.gameCategorySportFull));
  static final GameCategory fish = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_fish.png', localeStr.gameCategoryFishFull));
  static final GameCategory lottery = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_lottery.png', localeStr.gameCategoryLotteryFull));
  static final GameCategory card = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_card.png', localeStr.gameCategoryCardFull));
  static final GameCategory gift = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_gift.png', localeStr.gameCategoryGift));

  static final GameCategory movie = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_movie.png', localeStr.homeUserTabCategoryMovie));
  static final GameCategory egMovie = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_movie.png', localeStr.homeUserTabCategoryEgMovie));
  static final GameCategory newMovie = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_movie.png', localeStr.homeUserTabCategoryNewMovie));

  static final GameCategory recommend = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_recommend.png',
      localeStr.homeUserTabCategoryRecommend));
  static final GameCategory favorite = GameCategory.define(GameCategoryInfo(
      'images/index/tbico_love.png', localeStr.homeUserTabCategoryFavorite));

  /// Used for defining cases
  const GameCategory.define(GameCategoryInfo fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory GameCategory(GameCategoryInfo value) =>
      Vnum.fromValue(value, GameCategory);
}

Map<String, GameCategoryInfo> _categoryMap = {
  'casino': GameCategory.casino.value,
  'slot': GameCategory.slot.value,
  'sport': GameCategory.sport.value,
  'fish': GameCategory.fish.value,
  'lottery': GameCategory.lottery.value,
  'card': GameCategory.card.value,
  'gift': GameCategory.gift.value,
  'movie': GameCategory.movie.value,
  'eg_movie': GameCategory.egMovie.value,
  'new_movie': GameCategory.newMovie.value,
  'recommend': GameCategory.recommend.value,
  'fav': GameCategory.favorite.value,
};

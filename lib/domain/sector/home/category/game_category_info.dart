import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/builders/dataclass/dataclass.dart';
import 'package:meta/meta.dart' show required;

part 'game_category_info.g.dart';

///
/// This is for tab bar to know which child widget it should use
/// Don't forget to add the value to [HomeCategoryEnum]
///
enum GamePageType {
  GAMES,
  UNKNOWN,
}

enum GameCategoryIconType {
  NETWORK,
  ASSET,
  ICON,
}

///
/// IDs in category info.
///
enum GameCategoryEnum {
  CASINO,
  SLOT,
  SPORT,
  FISH,
  LOTTERY,
  CARD,
  UNDEFINE,
}

@dataClass
class GameCategoryInfo extends _$GameCategoryInfo {
  final GameCategoryEnum id;
  final GamePageType pageType;
  final GameCategoryIconType iconType;
  final String imageUrl;
  final String assetPath;
  final String selectedAssetPath;

  ///
  /// icon needs to be constant, define it in [GameCategoryModel]
  /// if [imageUrl] is empty, will try to use icon
  ///
  const GameCategoryInfo({
    @required this.id,
    this.pageType = GamePageType.GAMES,
    @required this.iconType,
    this.imageUrl = '',
    this.assetPath = '',
    this.selectedAssetPath = '',
  });
}

///
/// Use extension method to get label string,
/// so category name will be update when language changed
///
extension GameCategoryExtension on GameCategoryInfo {
  String get label {
    switch (id) {
      case GameCategoryEnum.CASINO:
        return localeStr.gameCategoryCasino;
      case GameCategoryEnum.SLOT:
        return localeStr.gameCategorySlot;
      case GameCategoryEnum.SPORT:
        return localeStr.gameCategorySport;
      case GameCategoryEnum.FISH:
        return localeStr.gameCategoryFish;
      case GameCategoryEnum.LOTTERY:
        return localeStr.gameCategoryLottery;
      case GameCategoryEnum.CARD:
        return localeStr.gameCategoryCard;
      default:
        return '???';
    }
  }
}

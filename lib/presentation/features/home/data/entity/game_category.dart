import 'package:flutter_eg990_mobile/domain/core/exceptions.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:vnum/vnum.dart';

import 'game_category_info.dart';

@VnumDefinition
class GameCategory extends Vnum<GameCategoryInfo> {
  /// GAMES
  static const GameCategory casino = const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.CASINO,
    iconType: GameCategoryIconType.ASSET,
    assetPath: Res.menu_live_u,
    selectedAssetPath: Res.menu_live,
  ));
  static const GameCategory slot = const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.SLOT,
    iconType: GameCategoryIconType.ASSET,
    assetPath: Res.menu_slot_u,
    selectedAssetPath: Res.menu_slot,
  ));
  static const GameCategory sport = const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.SPORT,
    iconType: GameCategoryIconType.ASSET,
    assetPath: Res.menu_sport_u,
    selectedAssetPath: Res.menu_sport,
  ));
  static const GameCategory fish = const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.FISH,
    iconType: GameCategoryIconType.ICON,
  ));
  static const GameCategory lottery =
      const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.LOTTERY,
    iconType: GameCategoryIconType.ASSET,
    assetPath: Res.menu_lottery_u,
    selectedAssetPath: Res.menu_lottery,
  ));
  static const GameCategory card = const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.CARD,
    iconType: GameCategoryIconType.ASSET,
    assetPath: Res.menu_card_u,
    selectedAssetPath: Res.menu_card,
  ));

  /// OTHER
  static const GameCategory undefined =
      const GameCategory.define(GameCategoryInfo(
    id: GameCategoryEnum.UNDEFINE,
    iconType: GameCategoryIconType.ICON,
    pageType: GamePageType.UNKNOWN,
  ));

  /// Used for defining cases
  const GameCategory.define(GameCategoryInfo fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory GameCategory(GameCategoryInfo value) =>
      Vnum.fromValue(value, GameCategory);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(GameCategory);

  static GameCategory findCategoryById(GameCategoryEnum id) =>
      GameCategory.listAll.singleWhere(
        (category) => (category.value as GameCategoryInfo).id == id,
        orElse: () => throw UnknownException(),
      );
}

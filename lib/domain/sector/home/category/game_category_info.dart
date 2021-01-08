import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:meta/meta.dart' show immutable, required;

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
  ESPORT,
}

@immutable
class GameCategoryInfo {
  final GameCategoryEnum id;
  final GamePageType pageType;
  final GameCategoryIconType iconType;
  final String imageUrl;
  final String assetPath;
  final String selectedAssetPath;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

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

  GameCategoryInfo copyWith({
    GameCategoryEnum id,
    GamePageType pageType,
    GameCategoryIconType iconType,
    String imageUrl,
    String assetPath,
    String selectedAssetPath,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (pageType == null || identical(pageType, this.pageType)) &&
        (iconType == null || identical(iconType, this.iconType)) &&
        (imageUrl == null || identical(imageUrl, this.imageUrl)) &&
        (assetPath == null || identical(assetPath, this.assetPath)) &&
        (selectedAssetPath == null ||
            identical(selectedAssetPath, this.selectedAssetPath))) {
      return this;
    }

    return new GameCategoryInfo(
      id: id ?? this.id,
      pageType: pageType ?? this.pageType,
      iconType: iconType ?? this.iconType,
      imageUrl: imageUrl ?? this.imageUrl,
      assetPath: assetPath ?? this.assetPath,
      selectedAssetPath: selectedAssetPath ?? this.selectedAssetPath,
    );
  }

  @override
  String toString() {
    return 'GameCategoryInfo{id: $id, pageType: $pageType, iconType: $iconType, imageUrl: $imageUrl, assetPath: $assetPath, selectedAssetPath: $selectedAssetPath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameCategoryInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pageType == other.pageType &&
          iconType == other.iconType &&
          imageUrl == other.imageUrl &&
          assetPath == other.assetPath &&
          selectedAssetPath == other.selectedAssetPath);

  @override
  int get hashCode =>
      id.hashCode ^
      pageType.hashCode ^
      iconType.hashCode ^
      imageUrl.hashCode ^
      assetPath.hashCode ^
      selectedAssetPath.hashCode;

//</editor-fold>

}

///
/// Use extension method to get label string,
/// so category name will be update when language changed
///
extension GameCategoryExtension on GameCategoryInfo {
  String get label {
    switch (id) {
      case GameCategoryEnum.CASINO:
        return localeStr.textCategoryCasino;
      case GameCategoryEnum.SLOT:
        return localeStr.textCategorySlot;
      case GameCategoryEnum.SPORT:
        return localeStr.textCategorySport;
      case GameCategoryEnum.FISH:
        return localeStr.textCategoryFish;
      case GameCategoryEnum.LOTTERY:
        return localeStr.textCategoryLottery;
      case GameCategoryEnum.CARD:
        return localeStr.textCategoryCard;
      case GameCategoryEnum.ESPORT:
        return localeStr.textCategoryEsport;
      default:
        return '???';
    }
  }
}

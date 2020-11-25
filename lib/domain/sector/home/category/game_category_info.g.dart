// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_category_info.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$GameCategoryInfo {
  const _$GameCategoryInfo();

  GameCategoryEnum get id;
  GamePageType get pageType;
  GameCategoryIconType get iconType;
  String get imageUrl;
  String get assetPath;
  String get selectedAssetPath;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! GameCategoryInfo) return false;
    return true &&
        this.id == other.id &&
        this.pageType == other.pageType &&
        this.iconType == other.iconType &&
        this.imageUrl == other.imageUrl &&
        this.assetPath == other.assetPath &&
        this.selectedAssetPath == other.selectedAssetPath;
  }

  int get hashCode {
    return mapPropsToHashCode(
        [id, pageType, iconType, imageUrl, assetPath, selectedAssetPath]);
  }

  String toString() {
    return 'GameCategoryInfo <\'id\': ${this.id},\'pageType\': ${this.pageType},\'iconType\': ${this.iconType},\'imageUrl\': ${this.imageUrl},\'assetPath\': ${this.assetPath},\'selectedAssetPath\': ${this.selectedAssetPath},>';
  }

  GameCategoryInfo copyWith(
      {GameCategoryEnum id,
      GamePageType pageType,
      GameCategoryIconType iconType,
      String imageUrl,
      String assetPath,
      String selectedAssetPath}) {
    return GameCategoryInfo(
      id: id ?? this.id,
      pageType: pageType ?? this.pageType,
      iconType: iconType ?? this.iconType,
      imageUrl: imageUrl ?? this.imageUrl,
      assetPath: assetPath ?? this.assetPath,
      selectedAssetPath: selectedAssetPath ?? this.selectedAssetPath,
    );
  }
}

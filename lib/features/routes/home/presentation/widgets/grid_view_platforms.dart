import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/models/game_platform.dart';
import 'package:flutter_eg990_mobile/features/themes/font_size.dart';

import 'grid_view_item.dart';

typedef OnPlatformItemTap = void Function(GamePlatformEntity);
typedef OnPlatformItemTapFavor = void Function(GamePlatformEntity, bool);

class GridViewPlatform extends StatelessWidget {
  final double pageMaxWidth;
  final double labelWidthFactor;
  final bool isIos;
  final List<GamePlatformEntity> platforms;
  final OnPlatformItemTap onTap;
  final bool addPlugin;
  final OnPlatformItemTapFavor onFavorTap;

  GridViewPlatform({
    @required this.pageMaxWidth,
    @required this.labelWidthFactor,
    @required this.isIos,
    @required this.platforms,
    @required this.onTap,
    this.addPlugin = false,
    this.onFavorTap,
  });

  final FontSize _basicFontSize = FontSize.SMALLER;
  final int _itemPerRow = 3;
  final int _itemMexWidth = 100;
  final double _verticalEmptySpace = 8.0;

  @override
  Widget build(BuildContext context) {
    int plusOnWidth = _itemMexWidth * (_itemPerRow + 1);
    int plusPerRow = (pageMaxWidth >= plusOnWidth)
        ? (pageMaxWidth / _itemMexWidth).floor() - 3
        : 0;
    debugPrint('platform page width: $pageMaxWidth, '
        'plus per row: ${(pageMaxWidth / _itemMexWidth).floor() - 3}');

    double fontSize = (isIos) ? _basicFontSize.value + 2 : _basicFontSize.value;
    double textHeight = fontSize * 1.75 + _verticalEmptySpace;
    double perItemWidth = pageMaxWidth / (_itemPerRow + plusPerRow);
    double ratio = perItemWidth / (perItemWidth + textHeight);

    debugPrint('platform item size: $perItemWidth, '
        'perRow: ${_itemPerRow + plusPerRow}, '
        'ratio: $ratio');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: _itemPerRow + plusPerRow,
      childAspectRatio: ratio,
      shrinkWrap: true,
      children: platforms
          .map((entity) => _createGridItem(
              platform: entity, imgSize: perItemWidth, textHeight: textHeight))
          .toList(),
    );
  }

  /// Create grid item for data [platform]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(
      {@required GamePlatformEntity platform,
      @required imgSize,
      @required textHeight}) {
    return GestureDetector(
      onTap: () => onTap(platform),
      child: GridViewItem.platform(
        imgUrl: platform.imageUrl,
        label: platform.label,
        imageSize: imgSize,
        fontSize: _basicFontSize,
        labelHeight: textHeight,
        labelMaxWidthFactor: labelWidthFactor,
        verticalSpaceAroundLabel: _verticalEmptySpace,
        isFavorite: platform.favorite == '1',
        pluginTapAction: (addPlugin &&
                onFavorTap != null &&
                platform.imageUrl != null &&
                platform.label != null)
            ? (isFavorite) => onFavorTap(platform, isFavorite)
            : null,
      ),
    );
  }
}

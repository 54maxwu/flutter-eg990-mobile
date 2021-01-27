import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/entity/game_entity.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/models/game_platform.dart';
import 'package:flutter_eg990_mobile/features/themes/font_size.dart';

import 'grid_view_item.dart';

typedef OnMixedItemTap = void Function(dynamic);
typedef OnMixedItemTapFavor = void Function(dynamic, bool);

class GridViewMixed extends StatelessWidget {
  final double pageMaxWidth;
  final double labelWidthFactor;
  final bool isIos;
  final List mixDataList;
  final OnMixedItemTap onTap;
  final bool addPlugin;
  final OnMixedItemTapFavor onFavorTap;

  GridViewMixed({
    @required this.pageMaxWidth,
    @required this.labelWidthFactor,
    @required this.isIos,
    @required this.mixDataList,
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
    debugPrint(
        'mixed page width: $pageMaxWidth, plus per row: ${(pageMaxWidth / _itemMexWidth).floor() - 3}');

    double perItemWidth = pageMaxWidth / (_itemPerRow + plusPerRow);

    double fontSize = (isIos) ? _basicFontSize.value + 2 : _basicFontSize.value;
    double _availableChars = perItemWidth * labelWidthFactor / fontSize;
    bool _twoLines = mixDataList.any((element) {
      if (element is GameEntity)
        return element.isLongText(_availableChars);
      else if (element is GamePlatformEntity)
        return element.isLongText(_availableChars);
      else
        return false;
    });

    debugPrint('mixed chars available: $_availableChars, two line: $_twoLines');

    double textHeight =
        ((!_twoLines) ? fontSize * 1.75 : fontSize * 3) + _verticalEmptySpace;
    double ratio = perItemWidth / (perItemWidth + textHeight);
    debugPrint(
        'mixed item size: $perItemWidth, perRow: ${_itemPerRow + plusPerRow}, ratio: $ratio');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: _itemPerRow + plusPerRow,
      childAspectRatio: ratio,
      shrinkWrap: true,
      children: mixDataList
          .map((entity) => _createGridItem(
              entity: entity,
              imgSize: perItemWidth,
              textHeight: textHeight,
              twoLines: _twoLines))
          .toList(),
    );
  }

  /// Create grid item for data [platform]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(
      {@required dynamic entity,
      @required imgSize,
      @required textHeight,
      @required twoLines}) {
    String label;
    String imageUrl;
    bool favor = false;

    if (entity is GameEntity) {
      label = (Global.lang != 'zh' && entity.ename != '??')
          ? entity.ename
          : entity.cname;
      imageUrl = entity.imageUrl;
      favor = entity.favorite == 1;
    } else if (entity is GamePlatformEntity) {
      label = entity.label;
      imageUrl = entity.imageUrl;
      favor = entity.favorite == '1';
    } else {
      return ConstrainedBox(
          constraints: BoxConstraints.tight(Size(
            imgSize,
            imgSize + textHeight,
          )),
          child: Icon(Icons.warning));
    }

    return GestureDetector(
      onTap: () => onTap(entity),
      child: GridViewItem(
        isPlatform: entity is GamePlatformEntity,
        imgUrl: imageUrl,
        label: label,
        imageSize: imgSize,
        fontSize: _basicFontSize,
        twoLine: twoLines,
        labelHeight: textHeight,
        labelMaxWidthFactor: labelWidthFactor,
        verticalSpaceAroundLabel: _verticalEmptySpace,
        isFavorite: favor,
        pluginTapAction: (addPlugin &&
                onFavorTap != null &&
                entity.imageUrl != null &&
                label != null)
            ? (isFavorite) => onFavorTap(entity, isFavorite)
            : null,
      ),
    );
  }
}

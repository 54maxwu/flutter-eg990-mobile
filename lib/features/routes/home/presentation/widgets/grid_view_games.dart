import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/entity/game_entity.dart';
import 'package:flutter_eg990_mobile/features/themes/font_size.dart';

import 'grid_item_game.dart';

typedef OnGameItemTap = void Function(GameEntity);
typedef OnGameItemTapFavor = void Function(GameEntity, bool);

class GridViewGames extends StatelessWidget {
  final double pageMaxWidth;
  final double labelWidthFactor;
  final bool isIos;
  final List<GameEntity> games;
  final OnGameItemTap onTap;
  final bool addPlugin;
  final OnGameItemTapFavor onFavorTap;

  GridViewGames({
    @required this.pageMaxWidth,
    @required this.labelWidthFactor,
    @required this.isIos,
    @required this.games,
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
        'game page width: $pageMaxWidth, plus per row: ${(pageMaxWidth / _itemMexWidth).floor() - 3}');

    double perItemWidth = pageMaxWidth / (_itemPerRow + plusPerRow);

    double fontSize = (isIos) ? _basicFontSize.value + 2 : _basicFontSize.value;
    int _availableChars = (perItemWidth * labelWidthFactor / fontSize).floor();
    bool _twoLines =
        games.any((element) => element.isLongText(_availableChars));
    debugPrint('game chars available: $_availableChars, two line: $_twoLines');

    double textHeight =
        ((!_twoLines) ? fontSize * 1.75 : fontSize * 3) + _verticalEmptySpace;
    double ratio = perItemWidth / (perItemWidth + textHeight);
    debugPrint(
        'game item size: $perItemWidth, perRow: ${_itemPerRow + plusPerRow}, ratio: $ratio');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: _itemPerRow + plusPerRow,
      childAspectRatio: ratio,
      shrinkWrap: true,
      children: games
          .map((entity) => _createGridItem(
              game: entity,
              imgSize: perItemWidth,
              textHeight: textHeight,
              twoLines: _twoLines))
          .toList(),
    );
  }

  /// Create grid item for data [platform]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(
      {@required GameEntity game,
      @required imgSize,
      @required textHeight,
      @required twoLines}) {
    String label =
        (Global.lang != 'zh' && game.ename != '??') ? game.ename : game.cname;
    return Container(
      constraints: BoxConstraints.tight(Size(
        imgSize,
        imgSize + textHeight,
      )),
      child: GestureDetector(
        onTap: () => onTap(game),
        child: GridItemGames2(
          imgUrl: game.imageUrl,
          label: label,
          imageSize: imgSize,
          fontSize: _basicFontSize,
          twoLine: twoLines,
          labelHeight: textHeight,
          labelMaxWidthFactor: labelWidthFactor - 0.1,
          verticalSpaceAroundLabel: _verticalEmptySpace,
          isFavorite: game.favorite == 1,
          pluginTapAction: (addPlugin &&
                  onFavorTap != null &&
                  game.imageUrl != null &&
                  label != null)
              ? (isFavorite) => onFavorTap(game, isFavorite)
              : null,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/error/exceptions.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../../data/entity/game_entity.dart';
import '../../data/models/game_platform.dart';
import '../state/home_store.dart';
import 'grid_item_mix.dart';
import 'home_store_inherit_widget.dart';

class HomeDisplayTabRecommend extends StatefulWidget {
  final double pageMaxWidth;
  final double textWidthFactor;
  final HomeSearchPlatformClicked onPlatformClicked;
  final bool addFavoritePlugin;

  const HomeDisplayTabRecommend({
    Key key,
    @required this.pageMaxWidth,
    @required this.textWidthFactor,
    @required this.onPlatformClicked,
    this.addFavoritePlugin = true,
  }) : super(key: key);

  @override
  _HomeDisplayTabRecommendState createState() =>
      _HomeDisplayTabRecommendState();
}

class _HomeDisplayTabRecommendState extends State<HomeDisplayTabRecommend> {
  final String tag = 'HomeDisplayTabRecommend';
  final bool _isIos = Global.device.isIos;
  final int _itemsPerRow = 3;
  final int _fixedItemHeight = 128;

  HomeStore _store;
  double _itemSize;
  double _gridRatio;
  double _baseTextSize;
  double _textHeight;
  int _availableCharacters;
  bool _twoLineText = true;
  int _plusGrid = 0;
  Widget _grid;
  List _recommends;

  /// Pass in a [itemData] on grid item tap.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else print warn log and show toast.
  void _onItemTap(dynamic itemData) {
    print('onItemTap recommend: $itemData');
    if (itemData is GamePlatformEntity) {
      widget.onPlatformClicked(itemData);
    } else if (itemData is GameEntity) {
      if (_store == null || _store.hasUser == false) {
        callToastInfo(localeStr.messageErrorNotLogin);
      } else {
        print('opening game: ${itemData.gameUrl}');
        _store.getGameUrl(itemData.gameUrl);
      }
    } else {
      callToastError(localeStr.messageErrorInternal);
      MyLogger.wtf(msg: 'tapped unknown item, data: $itemData', tag: tag);
    }
  }

  void _setFavorite(dynamic entity, bool favor) {
    if (entity is GamePlatformEntity || entity is GameEntity) {
      print('set ${entity.id} favor to $favor');
      _store.postFavorite(entity: entity, favorite: favor);
    }
  }

  @override
  void initState() {
    _plusGrid = (Global.device.widthScale > 2.0)
        ? 2
        : (Global.device.widthScale > 1.5) ? 1 : 0;

    _itemSize = widget.pageMaxWidth / (_itemsPerRow + _plusGrid) * 1.05;
    _gridRatio = _itemSize / _fixedItemHeight / Global.device.widthScale;

    _baseTextSize =
        (_isIos) ? FontSize.NORMAL.value + 2 : FontSize.NORMAL.value;
    _availableCharacters =
        (_itemSize * widget.textWidthFactor / _baseTextSize).floor();
    print(
        'recommend item available characters: ${(_itemSize * widget.textWidthFactor / _baseTextSize)}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message: Failure.internal(FailureCode(type: FailureType.RECOMMENDS))
              .message,
        ),
      );
    }
    return StreamBuilder<List>(
      stream: _store.recommendStream,
      initialData: _store.recommends,
      builder: (_, snapshot) {
        if (snapshot.data == null) _store.getRecommend();
        if (snapshot != null || snapshot.data != _recommends) {
          _recommends = snapshot.data;
          _grid = _createGrid();
        }
        _grid ??= Center(child: CircularProgressIndicator());
        return _grid;
      },
    );
  }

  Widget _createGrid() {
    if (_recommends == null || _recommends.isEmpty) return SizedBox.shrink();
    _twoLineText = _recommends.any(
      (element) {
        if (element is GameEntity)
          return element.isLongText(_availableCharacters);
        else if (element is GamePlatformEntity)
          return element.isLongText(_availableCharacters);
        else
          return false;
      },
    );
    _textHeight = (_twoLineText) ? _baseTextSize * 2.5 : _baseTextSize * 1.75;
    print(
        'recommend grid two line text: $_twoLineText, text height: $_textHeight');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: 3 + _plusGrid,
      childAspectRatio: _gridRatio + (_plusGrid * 0.05),
      mainAxisSpacing: (_plusGrid > 0) ? 6.0 : 4.0,
      shrinkWrap: true,
      children:
          _recommends.map<Widget>((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Create grid item for data [entity]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(dynamic entity) {
    String label;
    String imgUrl;
    bool favor = false;

    if (entity is GameEntity) {
      label = entity.cname;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == 1;
    } else if (entity is GamePlatformEntity) {
      label = entity.label;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == '1';
    } else {
      MyLogger.warn(
          msg: '${UnknownConditionException()}!! Grid item: $entity', tag: tag);
    }

    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(
        _itemSize,
        _itemSize + _textHeight,
      )),
      child: GestureDetector(
        onTap: () => _onItemTap(entity),
        child: GridItemMix(
          isPlatform: entity is GamePlatformEntity,
          imgUrl: imgUrl,
          label: label,
          isFavorite: favor,
          itemSize: _itemSize,
          textHeight: _textHeight,
          textWidthFactor: widget.textWidthFactor,
          pluginTapAction: (widget.addFavoritePlugin)
              ? (isFavorite) => _setFavorite(entity, isFavorite)
              : null,
          isIos: _isIos,
        ),
      ),
    );
  }
}

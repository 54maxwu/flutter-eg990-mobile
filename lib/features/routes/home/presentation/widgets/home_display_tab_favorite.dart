import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/error/exceptions.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../../data/entity/game_entity.dart';
import '../../data/models/game_platform.dart';
import '../state/home_store.dart';
import 'grid_item_mix.dart';
import 'home_store_inherit_widget.dart';

class HomeDisplayTabFavorite extends StatefulWidget {
  final double pageMaxWidth;
  final double textWidthFactor;
  final HomeSearchPlatformClicked onPlatformClicked;

  const HomeDisplayTabFavorite({
    Key key,
    @required this.pageMaxWidth,
    @required this.textWidthFactor,
    @required this.onPlatformClicked,
  }) : super(key: key);

  @override
  _HomeDisplayTabFavoriteState createState() => _HomeDisplayTabFavoriteState();
}

class _HomeDisplayTabFavoriteState extends State<HomeDisplayTabFavorite> {
  final String tag = 'HomeDisplayTabFavorite';
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
  List _favorites;

  /// Pass in a [itemData] on grid item tap.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else print warn log and show toast.
  void _onItemTap(dynamic itemData) {
    print('onItemTap favorite: $itemData');
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

  void _removeFavorite(dynamic entity) {
    if (entity is GamePlatformEntity || entity is GameEntity) {
      print('remove ${entity.id} from favorite');
      _store.postFavorite(entity: entity, favorite: false);
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
        'favorite item available characters: ${(_itemSize * widget.textWidthFactor / _baseTextSize)}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.FAVORITE)).message,
        ),
      );
    }
    return StreamBuilder<List>(
      stream: _store.favoriteStream,
      initialData: _store.favorites,
      builder: (_, snapshot) {
        if (snapshot.data == null) _store.getFavorites();
        if (snapshot != null || snapshot.data != _favorites) {
          _favorites = snapshot.data;
          _grid = _createGrid();
        }
        _grid ??= Center(child: CircularProgressIndicator());
        return _grid;
      },
    );
  }

  Widget _createGrid() {
    if (_favorites == null || _favorites.isEmpty) return SizedBox.shrink();
    _twoLineText = _favorites.any(
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
        'favorite grid two line text: $_twoLineText, text height: $_textHeight');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: 3 + _plusGrid,
      childAspectRatio: _gridRatio + (_plusGrid * 0.05),
      mainAxisSpacing: (_plusGrid > 0) ? 6.0 : 4.0,
      shrinkWrap: true,
      children:
          _favorites.map<Widget>((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Create grid item for data [entity]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(dynamic entity) {
    String label;
    String imgUrl;

    if (entity is GameEntity) {
      label = entity.cname;
      imgUrl = entity.imageUrl;
    } else if (entity is GamePlatformEntity) {
      label = entity.label;
      imgUrl = entity.imageUrl;
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
          isFavorite: true,
          itemSize: _itemSize,
          textHeight: _textHeight,
          textWidthFactor: widget.textWidthFactor,
          pluginTapAction: (imgUrl != null && label != null)
              ? (_) => _removeFavorite(entity)
              : null,
          isIos: _isIos,
        ),
      ),
    );
  }
}

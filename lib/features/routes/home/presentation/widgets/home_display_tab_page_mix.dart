import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../../data/entity/game_entity.dart';
import '../../data/models/game_platform.dart';
import '../state/home_store.dart';
import 'grid_item_mix.dart';
import 'home_store_inherit_widget.dart';

enum TabPageMixType { RECOMMEND, FAVORITE }

class HomeDisplayTabPageMix extends StatefulWidget {
  final TabPageMixType mixType;
  final double pageMaxWidth;
  final double textWidthFactor;
  final HomeSearchPlatformClicked onPlatformClicked;
  final bool addFavoritePlugin;

  HomeDisplayTabPageMix.recommend({
    Key key,
    @required this.pageMaxWidth,
    @required this.textWidthFactor,
    @required this.onPlatformClicked,
    this.addFavoritePlugin = true,
  })  : mixType = TabPageMixType.RECOMMEND,
        super(key: key);

  HomeDisplayTabPageMix.favorite({
    Key key,
    @required this.pageMaxWidth,
    @required this.textWidthFactor,
    @required this.onPlatformClicked,
  })  : mixType = TabPageMixType.FAVORITE,
        addFavoritePlugin = true,
        super(key: key);

  @override
  _HomeDisplayTabPageMixState createState() => _HomeDisplayTabPageMixState();
}

class _HomeDisplayTabPageMixState extends State<HomeDisplayTabPageMix> {
  final String tag = 'HomeDisplayTabPageMix';
  final bool _isIos = Global.device.isIos;
  final int _itemsPerRow = 3;
  final int _fixedItemHeight = 114;

  HomeStore _store;
  List _itemList;

  double _itemSize;
  double _baseTextSize;
  double _textHeight;
  int _availableCharacters;
  bool _twoLineText = true;

  Widget _grid;
  int _plusGrid = 0;
  double _gridRatio;

  /// Pass in a [itemData] on grid item tap.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else print warn log and show toast.
  void _onItemTap(dynamic itemData) {
    debugPrint('onItemTap mix: $itemData');
    if (itemData is GamePlatformEntity) {
      widget.onPlatformClicked(itemData);
    } else if (itemData is GameEntity) {
      if (_store == null || _store.hasUser == false) {
        callToastInfo(localeStr.messageErrorNotLogin);
      } else {
        debugPrint('opening game: ${itemData.gameUrl}');
        _store.getGameUrl(itemData.gameUrl);
      }
    } else {
      callToastError(localeStr.messageErrorInternal);
      MyLogger.wtf(msg: 'tapped unknown item, data: $itemData', tag: tag);
    }
  }

  void _setFavorite(dynamic entity, bool favor) {
    if (entity is GamePlatformEntity || entity is GameEntity) {
      debugPrint('set ${entity.id} favor to $favor');
      _store.postFavorite(entity: entity, favorite: favor);
    }
  }

  void _removeFavorite(dynamic entity) {
    if (entity is GamePlatformEntity || entity is GameEntity) {
      debugPrint('remove ${entity.id} from favorite');
      _store.postFavorite(entity: entity, favorite: false);
    }
  }

  @override
  void initState() {
    _plusGrid = (Global.device.widthScale > 2.0)
        ? 2
        : (Global.device.widthScale > 1.5) ? 1 : 0;
    _itemSize = widget.pageMaxWidth / (_itemsPerRow + _plusGrid) * 1.05;
    _baseTextSize =
        (_isIos) ? FontSize.NORMAL.value + 2 : FontSize.NORMAL.value;
    _availableCharacters =
        (_itemSize * widget.textWidthFactor / _baseTextSize).floor();
    debugPrint(
        'mix grid item available characters: ${(_itemSize * widget.textWidthFactor / _baseTextSize)}');
    super.initState();
  }

  @override
  void didUpdateWidget(HomeDisplayTabPageMix oldWidget) {
    debugPrint('updating tab page mix...');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message: Failure.internal(FailureCode(
                  type: (widget.mixType == TabPageMixType.RECOMMEND)
                      ? FailureType.RECOMMENDS
                      : FailureType.FAVORITE))
              .message,
        ),
      );
    }
    switch (widget.mixType) {
      case TabPageMixType.RECOMMEND:
        return StreamBuilder<List>(
          stream: _store.recommendStream,
          initialData: _store.recommends,
          builder: (_, snapshot) {
            if (snapshot.data == null) _store.getRecommend();
            if (snapshot != null && snapshot.data != _itemList) {
              _itemList = snapshot.data;
              _grid = _createGrid();
            }
            _grid ??= Center(child: CircularProgressIndicator());
            return _grid;
          },
        );
        break;
      case TabPageMixType.FAVORITE:
        return StreamBuilder<List>(
          stream: _store.favoriteStream,
          initialData: _store.favorites,
          builder: (_, snapshot) {
            if (snapshot.data == null) _store.getFavorites();
            if (snapshot != null || snapshot.data != _itemList) {
              _itemList = snapshot.data;
              _grid = _createGrid();
            }
            _grid ??= Center(child: CircularProgressIndicator());
            return _grid;
          },
        );
        break;
      default:
        return Container();
    }
  }

  Widget _createGrid() {
    if (_itemList == null || _itemList.isEmpty) return SizedBox.shrink();
    _twoLineText = _itemList.any(
      (element) {
        if (element is GameEntity)
          return element.isLongText(_availableCharacters);
        else if (element is GamePlatformEntity)
          return element.isLongText(_availableCharacters);
        else
          return false;
      },
    );
    _textHeight = (_twoLineText) ? _baseTextSize * 2.5 : _baseTextSize * 1.25;
    _gridRatio = _itemSize /
        (_fixedItemHeight + (_textHeight - _baseTextSize)) /
        Global.device.widthScale;

    debugPrint(
        '${widget.mixType} grid two line text: $_twoLineText, text height: $_textHeight, grid ratio: $_gridRatio');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: 3 + _plusGrid,
      childAspectRatio: _gridRatio + (_plusGrid * 0.05),
      mainAxisSpacing: (_plusGrid > 0) ? 6.0 : 4.0,
      shrinkWrap: true,
      children:
          _itemList.map<Widget>((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Create grid item for data [entity]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(dynamic entity) {
    String label;
    String imgUrl;
    bool favor = false;

    if (entity is GameEntity) {
      label = (Global.lang == 'zh') ? entity.cname : entity.ename;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == 1;
    } else if (entity is GamePlatformEntity) {
      label = entity.label;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == '1';
    } else {
      MyLogger.warn(msg: 'Unknown grid item: $entity', tag: tag);
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
          isFavorite:
              (widget.mixType == TabPageMixType.FAVORITE) ? true : favor,
          itemSize: _itemSize,
          textHeight: _textHeight,
          textWidthFactor: widget.textWidthFactor,
          pluginTapAction: (widget.mixType == TabPageMixType.FAVORITE)
              ? (imgUrl != null && label != null)
                  ? (_) => _removeFavorite(entity)
                  : null
              : (widget.addFavoritePlugin)
                  ? (isFavorite) => _setFavorite(entity, isFavorite)
                  : null,
          isIos: _isIos,
        ),
      ),
    );
  }
}

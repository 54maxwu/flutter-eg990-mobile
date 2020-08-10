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
  final HomeSearchPlatformClicked onPlatformClicked;

  const HomeDisplayTabFavorite({
    Key key,
    @required this.pageMaxWidth,
    @required this.onPlatformClicked,
  }) : super(key: key);

  @override
  _HomeDisplayTabFavoriteState createState() => _HomeDisplayTabFavoriteState();
}

class _HomeDisplayTabFavoriteState extends State<HomeDisplayTabFavorite> {
  final String tag = 'HomeDisplayTabFavorite';
  final bool _isIos = Global.device.isIos;
//  final bool _isIos = true;

  HomeStore _store;
  double labelHeightFactor;
  double itemSize;
  double gridRatio;
  double baseTextSize;
  int availableCharacters;
  bool twoLineText = true;
  int plusGrid = 0;
  Widget _grid;
  List favorites;

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
    plusGrid = (Global.device.widthScale > 2.0)
        ? 2
        : (Global.device.widthScale > 1.5) ? 1 : 0;

    labelHeightFactor = 1.6;
    if (plusGrid > 0) {
      if (Global.device.widthScale > 2.0) {
        labelHeightFactor = 1.75;
      } else {
        labelHeightFactor = 1.675;
      }
    }

    itemSize = widget.pageMaxWidth / (3 + plusGrid) * 0.95;
    baseTextSize = (_isIos) ? FontSize.NORMAL.value + 1 : FontSize.NORMAL.value;
    availableCharacters = (itemSize * 0.9 / baseTextSize).floor();
    print(
        'favorite item available characters: ${(itemSize * 0.9 / baseTextSize)}');
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
    return Container(
      child: StreamBuilder<List>(
        stream: _store.favoriteStream,
        initialData: _store.favorites,
        builder: (_, snapshot) {
          if (snapshot.data == null) _store.getFavorites();
          if (snapshot != null || snapshot.data != favorites) {
            favorites = snapshot.data;
            _grid = _createGrid();
          }
          _grid ??= Center(child: CircularProgressIndicator());
          return _grid;
        },
      ),
    );
  }

  Widget _createGrid() {
    if (favorites == null || favorites.isEmpty) return SizedBox.shrink();
    twoLineText = favorites.any(
      (element) {
        if (element is GameEntity)
          return element.isLongText(availableCharacters);
        else if (element is GamePlatformEntity)
          return element.isLongText(availableCharacters);
        else
          return false;
      },
    );
    print('favorite grid two line text: $twoLineText');

    if (twoLineText) {
      var expectHeight = 115 + (baseTextSize * 1.5) / 2.25;
      gridRatio = itemSize / expectHeight / Global.device.widthScale;
    } else
      gridRatio = itemSize / 115 / Global.device.widthScale;
    print('favorite item size: $itemSize, ratio: $gridRatio');

    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: 3 + plusGrid,
      childAspectRatio: gridRatio + (plusGrid * 0.05),
      mainAxisSpacing: (plusGrid > 0) ? 6.0 : 0.0,
      shrinkWrap: true,
      children:
          favorites.map<Widget>((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Create grid item for data [entity]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(dynamic entity) {
    String label;
    String imgUrl;
    double textHeight;

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

    if (twoLineText)
      textHeight = baseTextSize * labelHeightFactor * 2.5;
    else
      textHeight = baseTextSize * labelHeightFactor;

    return Container(
      padding: const EdgeInsets.only(top: 6.0),
      constraints: BoxConstraints.tight(Size(
        itemSize,
        itemSize + textHeight,
      )),
      child: GestureDetector(
        onTap: () => _onItemTap(entity),
        child: GridItemMix(
          isPlatform: entity is GamePlatformEntity,
          imgUrl: imgUrl,
          label: label,
          isFavorite: true,
          itemSize: itemSize,
          textHeight: textHeight,
          twoLineText: twoLineText,
          pluginTapAction: (imgUrl != null && label != null)
              ? (_) => _removeFavorite(entity)
              : null,
          isIos: _isIos,
        ),
      ),
    );
  }
}

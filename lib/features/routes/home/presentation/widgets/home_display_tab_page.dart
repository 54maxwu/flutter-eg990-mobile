import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/error/exceptions.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/loading_widget.dart';

import '../../data/entity/game_entity.dart';
import '../../data/form/platform_game_form.dart';
import '../../data/models/game_platform.dart';
import '../state/home_store.dart';
import 'grid_item_game.dart';
import 'grid_item_platform.dart';
import 'home_store_inherit_widget.dart';

///
/// Create Platforms and Games [GridView]
/// @author H.C.CHIANG
/// @version 2020/6/20
///
class HomeDisplayTabPage extends StatefulWidget {
  final String category;
  final double pageMaxWidth;
  final double textWidthFactor;
  final bool addSearchListener;
  final bool addPlugin;

  HomeDisplayTabPage({
    Key key,
    @required this.category,
    @required this.pageMaxWidth,
    @required this.textWidthFactor,
    this.addSearchListener = false,
    this.addPlugin = false,
  }) : super(key: key);

  @override
  HomeDisplayTabPageState createState() => HomeDisplayTabPageState();
}

class HomeDisplayTabPageState extends State<HomeDisplayTabPage>
    with AfterLayoutMixin {
  final String _tag = 'HomeDisplayTabsPage';
  final bool _isIos = Global.device.isIos;
  final int _platformsPerRow = 3;
  final int _fixedPlatformItemHeight = 114;
  final int _gamesPerRow = 3;
  final int _fixedGameItemHeight = 114;
  final FontSize _gFontSize = FontSize.MESSAGE;

  HomeStore _store;
  List<GamePlatformEntity> _platforms;

  Widget _grid;
  Widget _gamesView;
  bool _isGameGrid = false;
  int _plusGrid;
  double _baseTextSize;

  double _platformGridRatio;
  double _platformItemSize;
  double _platformTextHeight;

  double _gameGridRatio;
  double _gameItemSize;
  double _gameTextHeight;
  int _gAvailableCharacters;

  GamePlatformEntity _currentPlatform;
  List<GameEntity> _games;
  bool _twoLineText = true;

  String _searched;
  GamePlatformEntity _searchPlatform;

  String _getMapKey(GamePlatformEntity platform) {
    return '${platform.site}/${platform.category}';
  }

  PlatformGameForm _createForm(GamePlatformEntity platform) {
    _currentPlatform = platform;
    return PlatformGameForm(
      category: platform.category,
      platform: platform.site,
    );
  }

  /// Pass in a [itemData] on grid item tap or back button pressed.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else throw [UnknownConditionException].
  String _onItemTap(dynamic itemData, {bool search = false}) {
    debugPrint('onItemTap page: $itemData');
    if (itemData is GamePlatformEntity) {
      if (search)
        _setGridContent(_buildGamesView(itemData));
      else if (_isGameGrid) {
//        debugPrint('clicked back');
        _setGridContent(_createPlatformGrid());
      } else if (itemData.isGameHall == false) {
//        debugPrint('clicked platform: ${itemData.className}, data: $itemData');
        _setGridContent(_buildGamesView(itemData));
      } else {
        debugPrint('clicked game platform: ${itemData.gameUrl}');
        if (itemData.gameUrl == 'funky/lottery/0')
          _setGridContent(_buildGamesView(itemData));
        else
          return itemData.gameUrl;
      }
    } else if (itemData is GameEntity) {
      debugPrint('clicked game: ${itemData.gameUrl}');
      return itemData.gameUrl;
    } else {
      MyLogger.warn(msg: 'tapped item unknown, data: $itemData', tag: _tag);
    }
    return '';
  }

  void _setGridContent(Widget widget) {
    setState(() {
      _grid = widget;
    });
  }

  void _openGame(String url) {
    if (_store.hasUser == false)
      callToastInfo(localeStr.messageErrorNotLogin);
    else if (_store != null) _store.getGameUrl(url);
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

    _platformItemSize =
        widget.pageMaxWidth / (_platformsPerRow + _plusGrid) * 1.15;
    _platformGridRatio =
        _platformItemSize / _fixedPlatformItemHeight / Global.device.widthScale;
    debugPrint(
        'platform item size: $_platformItemSize, ratio: $_platformGridRatio');
//
    if (_plusGrid > 0)
      _gameItemSize = widget.pageMaxWidth / (_gamesPerRow + _plusGrid) * 0.95;
    else
      _gameItemSize = widget.pageMaxWidth / (_gamesPerRow + _plusGrid) * 1.15;
    _gameGridRatio =
        _gameItemSize / _fixedGameItemHeight / Global.device.widthScale;
    debugPrint('game item size: $_gameItemSize, ratio: $_gameGridRatio');

    _baseTextSize = (_isIos) ? _gFontSize.value + 2 : _gFontSize.value;
    _platformTextHeight = _baseTextSize * 1.25;
    _gAvailableCharacters =
        (_gameItemSize * widget.textWidthFactor / _baseTextSize).floor();
    debugPrint('game item available characters: $_gAvailableCharacters');
    super.initState();
  }

  @override
  void didUpdateWidget(HomeDisplayTabPage oldWidget) {
    debugPrint("update game-page=${widget.category}");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    debugPrint("change game-page=${widget.category}");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.HOME)).message,
        ),
      );
    }

    _platforms ??= _store.homePlatformMap[widget.category] ?? [];
    _grid ??= _createPlatformGrid();
    return _grid;
  }

  /// Main layer to show platforms under category
  Widget _createPlatformGrid() {
    _isGameGrid = false;
//    if (widget.addSearchListener) _store.searchGame(clear: true);
    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: _platformsPerRow + _plusGrid,
      childAspectRatio: _platformGridRatio + (_plusGrid * 0.075),
      mainAxisSpacing: 0.0,
      shrinkWrap: true,
      children: _platforms.map((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Second Layer to show games under platform
  Widget _buildGamesView(GamePlatformEntity platform) {
    _isGameGrid = true;
    if (platform != _currentPlatform) {
      _gamesView = _createGameListListener(
        _createForm(platform),
        _getMapKey(platform),
      );
    }
//    debugPrint('test platform icon: ${platform.iconUrl}');
    return Stack(
      children: [
        // game grid view
        _gamesView,
        // action button to show platform grid
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.black54,
            mini: true,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(Icons.arrow_back),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
                    child: Text(localeStr.btnBack),
                  ),
                ],
              ),
            ),
            onPressed: () {
              _setGridContent(_createPlatformGrid());
            },
          ),
        ),
      ],
    );
  }

  Widget _createGameListListener(PlatformGameForm form, String mapKey) {
    return StreamBuilder<String>(
      stream: _store.gamesStream,
      initialData: '',
      builder: (_, snapshot) {
        if (snapshot.data == mapKey || _store.hasPlatformGames(mapKey)) {
          return _createGamesGrid(_store.getPlatformGames(mapKey));
        } else {
          _store.getGames(form, mapKey);
          return LoadingWidget(heightFactor: 3);
        }
      },
    );
  }

  Widget _createGamesGrid(List<GameEntity> list) {
    _games = List.from(list);
    _twoLineText =
        _games.any((element) => element.isLongText(_gAvailableCharacters));
    _gameTextHeight =
        (_twoLineText) ? _baseTextSize * 2.5 : _baseTextSize * 1.25;
    debugPrint(
        '${_currentPlatform.className} game grid two line text: $_twoLineText');
//    if (widget.addSearchListener) {
//      return Column(
//        children: [
//          HomeSearchWidget(onSearch: (input) {
//            _store.searchGame(searchKey: input);
//          }),
//          StreamBuilder<String>(
//              stream: _store.searchGameStream,
//              initialData: '',
//              builder: (context, snapshot) {
//                String searchKey = snapshot?.data ?? '';
//                return GridView.count(
//                  physics: BouncingScrollPhysics(),
//                  padding: const EdgeInsets.only(bottom: 2.0),
//                  crossAxisCount: _gamesPerRow + _plusGrid,
//                  childAspectRatio: _gameGridRatio + (_plusGrid * 0.075),
//                  mainAxisSpacing: 0.0,
//                  shrinkWrap: true,
//                  children: (searchKey.isEmpty)
//                      ? _games.map((entity) => _createGridItem(entity)).toList()
//                      : _games
//                          .where((entity) => entity.cname
//                              .toLowerCase()
//                              .contains(searchKey.toLowerCase()))
//                          .map((entity) => _createGridItem(entity))
//                          .toList(),
//                );
//              }),
//        ],
//      );
//    } else {
    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2.0),
      crossAxisCount: _gamesPerRow + _plusGrid,
      childAspectRatio: _gameGridRatio + (_plusGrid * 0.075),
      mainAxisSpacing: 0.0,
      shrinkWrap: true,
      children: _games.map((entity) => _createGridItem(entity)).toList(),
    );
//    }
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
//      debugPrint('game: $label, img:$imgUrl');
    } else if (entity is GamePlatformEntity) {
      label = entity.label;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == '1';
//      debugPrint('platform: $label, img:$imgUrl');
    } else {
      MyLogger.warn(msg: 'Unknown Grid item: $entity', tag: _tag);
      return SizedBox.shrink();
    }

    return Container(
      constraints: (!_isGameGrid)
          ? BoxConstraints.tight(Size(
              _platformItemSize,
              _platformItemSize + _platformTextHeight,
            ))
          : BoxConstraints.tight(Size(
              _gameItemSize,
              _gameItemSize + _gameTextHeight,
            )),
      child: GestureDetector(
        onTap: () {
          String url = _onItemTap(entity);
          if (url.isNotEmpty) _openGame(url);
        },
        child: (!_isGameGrid)
            ? GridItemPlatform(
                imgUrl: imgUrl,
                label: label,
                isFavorite: favor,
                itemSize: _platformItemSize,
                isIos: _isIos,
                textHeight: _platformTextHeight,
                pluginTapAction:
                    (widget.addPlugin && imgUrl != null && label != null)
                        ? (isFavorite) => _setFavorite(entity, isFavorite)
                        : null,
              )
            : GridItemGame(
                imgUrl: imgUrl,
                label: label,
                isFavorite: favor,
                itemSize: _gameItemSize,
                isIos: _isIos,
                textHeight: _gameTextHeight,
                textWidthFactor: widget.textWidthFactor,
                pluginTapAction:
                    (widget.addPlugin && imgUrl != null && label != null)
                        ? (isFavorite) => _setFavorite(entity, isFavorite)
                        : null,
              ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.addSearchListener) {
      if (_searched == null) {
        _searched = _store.searchPlatform;
        if (_searched != null) findPlatform();
      }
      _store.showPlatformStream.listen((event) {
        if (event.contains(widget.category) == false) return;
        debugPrint('page ${widget.category} received search $event');
        _searched = event;
        findPlatform();
      });
    }
  }

  void findPlatform() {
    _searchPlatform = _platforms.singleWhere(
      (element) => element.className == _searched,
      orElse: () => null,
    );
    debugPrint('search platform: $_searchPlatform');
    if (_searchPlatform != null) {
      _onItemTap(_searchPlatform, search: true);
      _store.clearPlatformSearch();
    }
  }
}

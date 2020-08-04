import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_expansion_tile.dart';
import 'package:flutter_ty_mobile/mylogger.dart';

import '../../data/models/movie_category_model.dart';
import '../data/movie_category_enum.dart';
import 'movie_category_grid_item.dart';

typedef ChangeMovieCategory = void Function(int);

class MovieDisplayCategoryGrid extends StatefulWidget {
  final Size headerSize;
  final List<MovieCategoryModel> categories;
  final ChangeMovieCategory onClickCategory;

  MovieDisplayCategoryGrid({
    Key key,
    @required this.headerSize,
    @required this.categories,
    @required this.onClickCategory,
  }) : super(key: key);

  @override
  MovieDisplayCategoryGridState createState() =>
      MovieDisplayCategoryGridState();
}

class MovieDisplayCategoryGridState extends State<MovieDisplayCategoryGrid> {
  final GlobalKey<CustomizeExpansionTileState> _tileKey =
      new GlobalKey<CustomizeExpansionTileState>(debugLabel: 'tile');

  Map<int, List> _itemMap;
  List<int> _headers;
  List<int> _exHeaders;
  List<int> _exContent;

  double _itemRatio;
  Widget _grid;
  bool isExpanding = false;
  bool _retryOnce = true;
  int _lastHighlight;

  bool get isCollectOrOwn => _lastHighlight < 0;

  void setHighlight(int mapKey) {
    MyLogger.print(
        msg: 'set movie display highlight from $_lastHighlight to $mapKey');
    try {
      // disable last category highlight
      if (_lastHighlight != null)
        _highlightItem(_itemMap[_lastHighlight][0], light: false);
      // rearrange header
      if (mapKey >= 0) _moveCategoryToHeader(key: mapKey);
      // delay 100ms to wait for widget move
      Future.delayed(Duration(milliseconds: 200), () {
        _highlightItem(_itemMap[widget.categories.first.tid][0], light: false);
        if (_highlightItem(_itemMap[mapKey][0])) _lastHighlight = mapKey;
      });
    } catch (e) {
      MyLogger.error(msg: 'movie category highlight exception: $e');
      if (_retryOnce) {
        _retryOnce = false;
        Future.delayed(Duration(milliseconds: 250), () {
          if (mounted) {
            MyLogger.debug(msg: 'retrying highlight $mapKey...');
            setHighlight(mapKey);
          }
        });
      }
    }
  }

  void _onTapItem(int id) {
    print('tap category: $id, last: $_lastHighlight');
    try {
      if (_lastHighlight != id) {
        _highlightItem(_itemMap[_lastHighlight][0], light: false);
        if (_highlightItem(_itemMap[id][0])) _lastHighlight = id;
      }
      widget.onClickCategory(id);
    } catch (e) {
      MyLogger.error(msg: 'movie category tap exception: $e');
    }
  }

  bool _highlightItem(Key key, {bool light = true}) {
//    print('highlight widget: $key');
    try {
      (key as GlobalKey<MovieCategoryGridItemState>)
          .currentState
          ?.setHighlight = light;
      return true;
    } catch (e) {
      print('highlight failed!! key: $key\n$e');
      return false;
    }
  }

  @override
  void initState() {
    double gridItemWidth = (widget.headerSize.width - 5 * 2) / 5;
    _itemRatio = gridItemWidth / 80;
//    print('header item width: $gridItemWidth, headerItemRatio: $itemRatio');
    _initIdList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('change category grid');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MovieDisplayCategoryGrid oldWidget) {
    print('update category grid: $_lastHighlight');
    _retryOnce = true;
    super.didUpdateWidget(oldWidget);
  }

  void _initIdList() {
    var firstTwo =
        List.of(widget.categories.take(2).map((e) => e.tid).toList());
    _headers = [-1, -2, -3]..insertAll(2, firstTwo);
    _exHeaders = [-1, -2, -4]..insertAll(2, firstTwo);
    _exContent =
        List.of(widget.categories.sublist(2).map((e) => e.tid).toList());
//    print('init id:');
//    print('headers: $_headers');
//    print('ex headers: $_exHeaders');
//    print('ex content: $_exContent');
  }

  void _moveCategoryToHeader({int key}) {
    int target = key ?? _lastHighlight;
    if (_headers.contains(target)) return;
    var firstTwo = [target, widget.categories.first.tid];
    _headers = [-1, -2, -3]..insertAll(2, firstTwo);
    _exHeaders = [-1, -2, -4]..insertAll(2, firstTwo);
    _exContent = List.of(widget.categories.map((e) => e.tid).toList())
      ..retainWhere((element) => firstTwo.contains(element) == false);
//    print('new headers: $_headers');
//    print('new ex headers: $_exHeaders');
//    print('new ex content: $_exContent');
    setState(() {
      _grid = _buildExpandGrid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: (_itemMap == null)
          ? compute(_createGridItemMap, widget.categories)
          : Future.value(_itemMap),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _itemMap = snapshot.data;
          if (_grid == null) {
            _lastHighlight = _headers[2];
            // highlight first movie category
            Future.delayed(
              Duration(milliseconds: 200),
              () => _highlightItem(_itemMap[_lastHighlight][0]),
            );
          }
          _grid = _buildExpandGrid();
        }
        return _grid ?? SizedBox(height: widget.headerSize.height);
      },
    );
  }

  Widget _buildExpandGrid() {
    return CustomizeExpansionTile(
      key: _tileKey,
      onExpansionChanged: (expand) {
        isExpanding = expand;
        if (!expand) _moveCategoryToHeader();
      },
      header: ConstrainedBox(
        constraints: BoxConstraints.tight(widget.headerSize),
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          childAspectRatio: _itemRatio,
          crossAxisCount: 5,
          shrinkWrap: true,
          children: _mapGridItems(_headers),
        ),
      ),
      headerExpanded: ConstrainedBox(
        constraints: BoxConstraints.tight(widget.headerSize),
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          childAspectRatio: _itemRatio,
          crossAxisCount: 5,
          shrinkWrap: true,
          children: _mapGridItems(_exHeaders),
        ),
      ),
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: widget.headerSize.height * 2 + 6.0,
            maxWidth: widget.headerSize.width,
          ),
          child: GridView.count(
            primary: true,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 2.0),
            childAspectRatio: _itemRatio,
            crossAxisCount: 5,
            mainAxisSpacing: 6.0,
            shrinkWrap: true,
            children: _mapGridItems(_exContent),
          ),
        ),
      ],
    );
  }

  List<Widget> _mapGridItems(List list) =>
      list.map((id) => _addDetector(id, _itemMap[id][1] as Widget)).toList();

  Widget _addDetector(int id, Widget child) {
    return GestureDetector(
      onTap: (id < -2)
          ? () => _tileKey.currentState.handleTap()
          : () => _onTapItem(id),
      child: child,
    );
  }
}

Map<int, List> _createGridItemMap(List categories) {
  Map<int, List> map = new Map();
  List list = List.of(categories)
    ..insertAll(0, [
      MovieCategoryEnum.COLLECT,
      MovieCategoryEnum.BUY,
      MovieCategoryEnum.EXPAND,
      MovieCategoryEnum.FOLD
    ]);

  for (int i = 0; i < list.length; i++) {
    int id;
    String idLabel;
    Widget widget;
    var item = list[i];
    if (item is MovieCategoryEnum) {
      id = item.value;
      idLabel = 'c${item.value}';
    } else if (item is MovieCategoryModel) {
      id = item.tid;
      idLabel = 'tid${item.tid}';
    } else
      continue;

    final GlobalKey<MovieCategoryGridItemState> widgetKey =
        new GlobalKey(debugLabel: idLabel);

    if (item is MovieCategoryEnum)
      widget = new MovieCategoryGridItem(
        widgetKey,
        categoryEnum: item,
        id: idLabel,
      );
    else
      widget = new MovieCategoryGridItem(
        widgetKey,
        category: item,
        id: idLabel,
      );

    map[id] = [widgetKey, widget];
  }
//  print('widget map:\n$map');
  return map;
}

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_expansion_tile.dart';
import 'package:flutter_ty_mobile/features/movie/presentation/widgets/movie_display_grid_item.dart';

import '../../data/models/movie_category_model.dart';
import '../data/movie_category_enum.dart';

typedef ChangeMovieCategory = void Function(int);

class MovieTabCategoryGrid extends StatefulWidget {
  final List<MovieCategoryModel> categories;
  final Size headerSize;
  final ChangeMovieCategory onCategoryChange;

  MovieTabCategoryGrid({
    @required this.categories,
    @required this.headerSize,
    @required this.onCategoryChange,
  });

  @override
  _MovieTabCategoryGridState createState() => _MovieTabCategoryGridState();
}

class _MovieTabCategoryGridState extends State<MovieTabCategoryGrid> {
  final GlobalKey<CustomizeExpansionTileState> _tileKey =
      new GlobalKey<CustomizeExpansionTileState>(debugLabel: 'tile');

  Map<int, List> _itemMap;
  List<int> _headers;
  List<int> _exHeaders;
  List<int> _exContent;

  double _itemRatio;
  Widget _grid;
  bool isExpanding = false;
  int _lastHighlight;

  void _onTapItem(int id) {
//    print('tap widget: $id');
    if (_lastHighlight != id) {
      _highlightItem(_itemMap[_lastHighlight][0], light: false);
      if (_highlightItem(_itemMap[id][0])) _lastHighlight = id;
    }
    widget.onCategoryChange(id);
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
    double gridItemWidth = (widget.headerSize.width - 4 * 2) / 4;
    _itemRatio = gridItemWidth / 80;
//    print('header item width: $gridItemWidth, headerItemRatio: $itemRatio');
    _initIdList();
    super.initState();
  }

  void _initIdList() {
    int first = widget.categories.first.tid;
    _headers = [-1, -2, -3]..insert(2, first);
    _exHeaders = [-1, -2, -4]..insert(2, first);
    _exContent =
        List.of(widget.categories.sublist(1).map((e) => e.tid).toList());
//    print('init id:');
//    print('headers: $_headers');
//    print('ex headers: $_exHeaders');
//    print('ex content: $_exContent');
  }

  void _moveCategoryToHeader() {
    if (_headers.contains(_lastHighlight)) return;
    _headers = [-1, -2, -3]..insert(2, _lastHighlight);
    _exHeaders = [-1, -2, -4]..insert(2, _lastHighlight);
    _exContent = List.of(widget.categories.map((e) => e.tid).toList())
      ..retainWhere((element) => element != _lastHighlight);
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
          _lastHighlight = _headers[2];
          if (_grid == null) {
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
          crossAxisCount: 4,
          shrinkWrap: true,
          children: _mapGridItems(_headers),
        ),
      ),
      headerExpanded: ConstrainedBox(
        constraints: BoxConstraints.tight(widget.headerSize),
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          childAspectRatio: _itemRatio,
          crossAxisCount: 4,
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
            crossAxisCount: 4,
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

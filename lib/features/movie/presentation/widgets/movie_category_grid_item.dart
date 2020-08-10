import 'dart:async' show StreamController;

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../../data/models/movie_category_model.dart';
import '../data/movie_category_enum.dart';

class MovieCategoryGridItem extends StatefulWidget {
  /// Grid item type, default is [MovieCategoryEnum.CATEGORY]
  final MovieCategoryEnum categoryEnum;

  /// Grid item data, null if enum is not [MovieCategoryEnum.CATEGORY]
  final MovieCategoryModel category;

  /// Widget id as object identifier, and for debug use
  final String id;

  MovieCategoryGridItem(
    Key key, {
    this.categoryEnum = MovieCategoryEnum.CATEGORY,
    this.category,
    this.id,
  })  : assert((categoryEnum == MovieCategoryEnum.CATEGORY)
            ? category != null
            : categoryEnum != null),
        super(key: key);

  @override
  MovieCategoryGridItemState createState() => MovieCategoryGridItemState();
}

class MovieCategoryGridItemState extends State<MovieCategoryGridItem> {
  final StreamController<bool> _highlightController =
      new StreamController<bool>();
  String _itemId;
  String _label;
  Widget _itemWidget;
  Widget _image;

  bool _isHighlight = false;

  set setHighlight(bool value) {
    _highlightController.sink.add(value);
  }

  @override
  void initState() {
    _itemId = widget.id ?? '${widget.categoryEnum.value}';
    if (widget.category != null)
      _label = widget.category.name;
    else if (widget.categoryEnum == MovieCategoryEnum.COLLECT)
      _label = localeStr.movieCategoryLabelCollect;
    else if (widget.categoryEnum == MovieCategoryEnum.BUY)
      _label = localeStr.movieCategoryLabelBuy;
    else if (widget.categoryEnum == MovieCategoryEnum.EXPAND)
      _label = localeStr.movieCategoryLabelExpand;
    else if (widget.categoryEnum == MovieCategoryEnum.FOLD)
      _label = localeStr.movieCategoryLabelFold;
    super.initState();
  }

  @override
  void didChangeDependencies() {
//    print('----'
//        'change movie category item $_itemId, '
//        'highlight: $_isHighlight');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    try {
      _highlightController.close();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _image ??= _createImage();
    _itemWidget ??= _buildItem();
    return StreamBuilder<bool>(
        stream: _highlightController.stream,
        initialData: _isHighlight,
        builder: (context, snapshot) {
          if (_isHighlight != snapshot.data) {
            _isHighlight = snapshot.data;
            _image = _createImage();
            _itemWidget = _buildItem();
          }
          return _itemWidget;
        });
  }

  Widget _buildItem() {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        constraints: BoxConstraints.tight(Size(60, 80)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints.tight(Size(54, 54)),
              alignment: Alignment.center,
              child: _image,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _label,
                  style: TextStyle(
                    fontSize: FontSize.SMALL.value,
                    color: (widget.categoryEnum == MovieCategoryEnum.EXPAND ||
                            widget.categoryEnum == MovieCategoryEnum.FOLD)
                        ? Themes.defaultAccentColor
                        : (_isHighlight)
                            ? Themes.secondaryTextColor1
                            : Themes.secondaryTextColor2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createImage() {
    String path = (_isHighlight) ? Res.movie_new_base : Res.movie_new_dark_base;
    if (widget.categoryEnum.value < 0) {
      if (widget.categoryEnum == MovieCategoryEnum.COLLECT)
        path += 'collect.png';
      else if (widget.categoryEnum == MovieCategoryEnum.BUY)
        path += 'buy.png';
      else if (widget.categoryEnum == MovieCategoryEnum.EXPAND)
        path = Res.movie_category_action_expand;
      else if (widget.categoryEnum == MovieCategoryEnum.FOLD)
        path = Res.movie_category_action_fold;
    } else {
      path += '${widget.category.tid}.png';
    }
//    print('$_itemId image: $path');
    return Image.asset(path);
  }
}

import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/models/movie_model.dart';
import '../widgets/movie_list_footer.dart';

typedef OnClickedMovie = void Function(int, int);

class MovieTabList extends StatefulWidget {
  final Size viewSize;
  final List<MovieModel> movies;
  final Function onNextPage;
  final OnClickedMovie onClickMovie;

  MovieTabList(
    Key key, {
    @required this.movies,
    @required this.viewSize,
    @required this.onNextPage,
    @required this.onClickMovie,
  }) : super(key: key);

  @override
  MovieTabListState createState() => MovieTabListState();
}

class MovieTabListState extends State<MovieTabList> {
  double maxWidth;
  double itemSize;
  double gridItemRatio;

  EasyRefreshController _controller;
  ScrollController _scrollController;
  Timer _requestTimeout;
  bool hasMore;
  bool isLoading = false;

  List<MovieModel> movieList;
  int _currentLength;
  double baseTextSize;
  int availableCharacters;
  bool _twoLine;

  void setList({List<MovieModel> list, bool more = true}) {
    if (mounted) {
      final bool noMore = list == null || list.isEmpty;
      _controller.resetLoadState();
      _controller.finishLoad(noMore: noMore);
      setState(() {
        if (list != movieList) movieList = list ?? widget.movies;
        _currentLength = movieList.length;
        hasMore = !noMore && more;
        isLoading = false;
        debugPrint('load more movie complete, has more = $hasMore');
        checkItemText();
      });
    }
  }

  void checkItemText() {
    baseTextSize ??= (Global.device.isIos)
        ? FontSize.SMALLER.value + 1
        : FontSize.SMALLER.value;
    availableCharacters ??= (itemSize * 0.95 / baseTextSize).round();
    _twoLine =
        movieList.any((movie) => movie.title.countLength > availableCharacters);
    debugPrint('available = $availableCharacters, two line text = $_twoLine');
  }

  Future<void> _loadMore() async {
    debugPrint('triggered load more movies, is loading: $isLoading');
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    _requestTimeout?.cancel();
    _requestTimeout = new Timer(Duration(seconds: 5), () {
      // set loading to false if the [onNextPage] does not
      // triggered [setList] to update the data
      setState(() {
        isLoading = false;
      });
      _controller.resetLoadState();
      _controller.finishLoad(success: false);
    });

    // requesting next page
    widget.onNextPage();
  }

  @override
  void initState() {
    debugPrint('init movie list');
    movieList = widget.movies;
    _currentLength = movieList?.length ?? 0;
    hasMore = _currentLength > 0;

    maxWidth = widget.viewSize.width;
    itemSize = (maxWidth - 2 * 6) / 2;
    gridItemRatio = itemSize / (itemSize + FontSize.NORMAL.value * 3);
//    debugPrint('movie pic size: $itemSize, '
//        'base height: ${itemSize + FontSize.NORMAL.value * 3}');
//    debugPrint('gridItemRatio: $gridItemRatio');
    checkItemText();

    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    debugPrint('change movie list: ${widget.movies.length}');
    if (mounted) {
      _controller.resetLoadState();
      _controller.finishLoad(noMore: !hasMore);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MovieTabList oldWidget) {
    debugPrint('update movie list');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (movieList.isEmpty) return SizedBox.shrink();
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: widget.viewSize.height,
      ),
      child: Stack(
        children: [
          EasyRefresh.custom(
            controller: _controller,
            scrollController: _scrollController,
            enableControlFinishLoad: true,
            shrinkWrap: true,
            slivers: [
              SliverGrid.count(
                childAspectRatio: gridItemRatio,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: (_twoLine) ? 0.0 : 8.0,
                children: movieList.map((movie) => _createItem(movie)).toList(),
              ),
            ],
            footer: MovieListFooter(
              extent: 40.0,
              textColor: themeColor.defaultAccentColor,
            ),
            onLoad: (hasMore) ? () => _loadMore() : null,
          ),
          if (hasMore && !isLoading)
            Positioned(
              bottom: 0,
              child: Container(
                width: maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black12,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.expand_more,
                  size: 30.0,
                  color: themeColor.defaultAccentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _createItem(MovieModel movie) {
    return GestureDetector(
      onTap: () => widget.onClickMovie(movie.tid, movie.mid),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints.tight(Size(itemSize, itemSize)),
            color: Colors.black,
            child: networkImageBuilder(movie.pic),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2.0, bottom: 3.0),
            height: (_twoLine)
                ? FontSize.SMALLER.value * 2.75
                : FontSize.SMALLER.value * 1.2,
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: FontSize.SMALLER.value),
            ),
          ),
        ],
      ),
    );
  }
}

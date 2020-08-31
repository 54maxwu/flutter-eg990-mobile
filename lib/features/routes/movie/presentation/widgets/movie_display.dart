import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../../data/models/movie_hot_model.dart';
import '../../data/models/movie_post_model.dart';
import '../data/movie_category_enum.dart';
import '../data/movie_route_form.dart';
import '../state/movie_store.dart';
import '../widgets/movie_list_footer.dart';
import 'movie_display_category_grid.dart';
import 'movie_display_list.dart';
import 'movie_display_post.dart';
import 'movie_store_inherit_widget.dart';

class MovieDisplay extends StatefulWidget {
  @override
  _MovieDisplayState createState() => _MovieDisplayState();
}

class _MovieDisplayState extends State<MovieDisplay> {
  final GlobalKey<MovieDisplayCategoryGridState> _gridKey =
      new GlobalKey(debugLabel: 'hotgrid');

  MovieStore _store;
  MoviePostData postData;
  Widget postWidget;

  EasyRefreshController _controller;
  ScrollController _scrollController;
  Timer _loadingTimeout;
  bool _isLoading = false;
  bool _canLoadMore = true;
  bool _waitForNewList = false;

  Future _loadMore() async {
    print('triggered load more hot movies, is loading: $_isLoading');
    if (_isLoading || _waitForNewList) return;
    _waitForNewList = true;
    _isLoading = true;

    _loadingTimeout?.cancel();
    _loadingTimeout = new Timer(Duration(seconds: 5), () {
      // set loading to false if the [onNextPage] does not
      // triggered [setList] to update the data
      if (_isLoading) {
        _isLoading = false;
        _controller.resetLoadState();
        _controller.finishLoad(success: false);
      }
    });

    // requesting more hot movies
    _store.getEgHotMovies();
  }

  void updatePostWidgetState() {
    print('check tid before update highlight: ${_store.hotMovieTid}');
    // triggered on post data update
    // set category highlight and load action
    switch (_store.hotMovieTid) {
      case 'love':
        _gridKey.currentState?.setHighlight(MovieCategoryEnum.COLLECT.value);
        setState(() {
          _canLoadMore = false;
        });
        break;
      case 'buy':
        _gridKey.currentState?.setHighlight(MovieCategoryEnum.BUY.value);
        setState(() {
          _canLoadMore = false;
        });
        break;
      default:
        _gridKey.currentState?.setHighlight(_store.moviePost.tid);
        setState(() {
          _canLoadMore = true;
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _store?.resetHotVariable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= MovieStoreInheritedWidget.of(context)?.store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Global.device.width,
          maxHeight: Global.device.featureContentHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Movie Post
            StreamBuilder<MoviePostData>(
              stream: _store.moviePostStream,
              initialData: _store.moviePost,
              builder: (_, snapshot) {
                if (snapshot == null || snapshot.data == null)
                  postWidget = SizedBox(height: 144.0);
                else if (postData != snapshot.data) {
                  postData = snapshot.data.copyWith();
                  postWidget = MovieDisplayPost(movie: postData);
                  Future.delayed(Duration(milliseconds: 1000), () {
                    updatePostWidgetState();
                  });
                }
                postWidget ??= SizedBox(height: 144.0);
                return postWidget;
              },
            ),
            Divider(
              color: Themes.defaultAccentColor,
              thickness: 2.0,
              height: 8.0,
            ),
            Expanded(
              child: EasyRefresh.custom(
                controller: _controller,
                scrollController: _scrollController,
                enableControlFinishLoad: true,
                slivers: [
                  /// Movie Category
                  SliverToBoxAdapter(
                    child: MovieDisplayCategoryGrid(
                      key: _gridKey,
                      categories: _store.categories,
                      headerSize: Size(Global.device.width - 12.0, 80.0),
                      onClickCategory: (tid) async {
                        print('received movie category change to $tid');
                        // set category highlight and load action
                        if (tid == MovieCategoryEnum.COLLECT.value) {
                          _store.getEgHotMovies(tid: 'love');
                        } else if (tid == MovieCategoryEnum.BUY.value) {
                          _store.getEgHotMovies(tid: 'buy');
                        } else {
                          _store.getEgHotMovies(tid: tid);
                        }
                      },
                    ),
                  ),

                  /// Separator
                  SliverToBoxAdapter(
                    child: Container(
                      height: FontSize.NORMAL.value * 2,
                      color: Themes.defaultAccentColor,
                      margin: const EdgeInsets.only(bottom: 2.0, top: 4.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            const IconData(0xf06d, fontFamily: 'FontAwesome'),
                            size: 16.0,
                            color: Themes.buttonTextPrimaryColor,
                          ),
                          Text(
                            localeStr.movieSeparatorTextHot,
                            style:
                                TextStyle(color: Themes.buttonTextPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Movie List
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
                      child: StreamBuilder<List<MovieHotModel>>(
                          stream: _store.hotMoviesStream,
                          initialData: _store.hotMovies,
                          builder: (_, snapshot) {
                            if (snapshot == null || snapshot.data == null)
                              return SizedBox(height: 144.0);
                            else {
                              print(
                                  'streamed hot movies: ${snapshot.data.length}');
                              _isLoading = false;
                              _loadingTimeout?.cancel();

                              /// lock or unlock load more action
                              if (_store.hotMovieTid is String &&
                                  _canLoadMore) {
                                Future.delayed(Duration(milliseconds: 200),
                                    () => setState(() => _canLoadMore = false));
                              } else if (_store.hotMovieTid is int &&
                                  !_canLoadMore) {
                                Future.delayed(Duration(milliseconds: 200),
                                    () => setState(() => _canLoadMore = true));
                              }

                              return MovieDisplayList(
                                movies: List.of(snapshot.data),
                                onUpdateComplete: () {
                                  _controller.resetLoadState();
                                  _controller.finishLoad(noMore: !_canLoadMore);
                                  _waitForNewList = false;
                                },
                                onClickMovie: (tid, mid) {
                                  print('clicked movie: $tid - $mid');
                                  if (_store.waitForMoviePost) return;
                                  _store.getEgMoviePost(
                                      MovieRouteForm(tid: tid, mid: mid));
                                },
                              );
                            }
                          }),
                    ),
                  ),
                ],
                footer: MovieListFooter(
                  extent: 40.0,
                  textColor: Themes.defaultAccentColor,
                ),
                onLoad: (_canLoadMore) ? () => _loadMore() : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

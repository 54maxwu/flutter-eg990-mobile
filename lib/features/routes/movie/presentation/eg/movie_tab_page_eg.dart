import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart' show Observer;

import '../data/movie_category_enum.dart';
import '../widgets/movie_store_inherit_widget.dart';
import 'movie_tab_category_grid.dart';
import 'movie_tab_list.dart';

///
/// EG Movie Display in Home page
/// @version 2020/7/16
///
class MovieTabPageEg extends StatefulWidget {
  @override
  _MovieTabPageEgState createState() => _MovieTabPageEgState();
}

class _MovieTabPageEgState extends State<MovieTabPageEg> {
  final GlobalKey<MovieTabListState> _listKey =
      new GlobalKey<MovieTabListState>(debugLabel: 'list');

  bool _waitForUpdate = false;
  bool _canLoadMore = true;

  @override
  Widget build(BuildContext context) {
    final viewState = MovieStoreInheritedWidget.of(context);
    if (viewState.store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.MOVIE)).message,
        ),
      );
    }
    return SingleChildScrollView(
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MovieTabCategoryGrid(
            categories: viewState.store.categories,
            headerSize: Size(viewState.size.width, 80.0),
            onCategoryChange: (tid) async {
              debugPrint('received movie category change to $tid');
              _canLoadMore = (tid != MovieCategoryEnum.COLLECT.value &&
                  tid != MovieCategoryEnum.BUY.value);
              if (tid == MovieCategoryEnum.COLLECT.value)
                viewState.store.getEgMovies(tid: 'love');
              else if (tid == MovieCategoryEnum.BUY.value)
                viewState.store.getEgMovies(tid: 'buy');
              else if (tid == viewState.store.categories.first.tid)
                viewState.store.getEgMovies(tid: tid);
              else {
//                int mid = await viewState.store.getEgMovies(tid: tid);
//                if (mid > 0)
//                  RouterNavigate.navigateToPage(
//                    RoutePage.movieEg,
//                    arg: MovieRouteArguments(
//                      form: MovieRouteForm(tid: tid, mid: mid),
//                    ),
//                  );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Divider(
              color: themeColor.defaultAccentColor,
              thickness: 2.0,
              height: 8.0,
            ),
          ),
          Observer(builder: (_) {
            /// update movie list if the category does not change
            if (viewState.store.waitForMovieData) {
              _waitForUpdate = true;
              debugPrint('waiting for update...');
            } else if (viewState.store.waitForMovieData == false &&
                _waitForUpdate) {
              Future.delayed(Duration(milliseconds: 200), () {
                bool isMounted = _listKey?.currentState?.mounted ?? false;
                if (isMounted)
                  _listKey.currentState.setList(
                    list: viewState.store.movies,
                    more: _canLoadMore,
                  );
              });
              _waitForUpdate = false;
            }
            return SizedBox.shrink();
          }),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Observer(builder: (_) {
              /// show page loading when changing category
              /// when finish, create a display list
              /// or notify widget [didChangeDependencies]
              return (viewState.store.changeCategory &&
                      viewState.store.waitForMovieData)
                  ? Container(
                      height: viewState.size.height - 60.0,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : MovieTabList(
                      _listKey,
                      viewSize: Size(
                        viewState.size.width,
                        viewState.size.height - 60.0,
                      ),
                      movies: viewState.store.movies,
                      onNextPage: () {
                        viewState.store.getEgMovies();
                      },
                      onClickMovie: (tid, mid) {
                        debugPrint('clicked movie: $tid - $mid');
//                        RouterNavigate.navigateToPage(
//                          RoutePage.movieEg,
//                          arg: MovieRouteArguments(
//                              form: MovieRouteForm(
//                            tid: tid,
//                            mid: mid,
//                            highlight: viewState.store.tabPageMovieTid,
//                          )),
//                        );
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}

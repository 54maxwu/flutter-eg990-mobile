import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';

import '../../data/models/movie_hot_model.dart';

typedef OnClickedMovie = void Function(int, int);

class MovieDisplayList extends StatefulWidget {
  final List<MovieHotModel> movies;
  final OnClickedMovie onClickMovie;
  final Function onUpdateComplete;

  MovieDisplayList({
    @required this.movies,
    @required this.onUpdateComplete,
    @required this.onClickMovie,
  });

  @override
  _MovieDisplayListState createState() => _MovieDisplayListState();
}

class _MovieDisplayListState extends State<MovieDisplayList> {
  double maxWidth;
  double itemSize;
  double gridItemRatio;
  List<MovieHotModel> movieList;

  @override
  void initState() {
    maxWidth = Global.device.width - 32.0;
    itemSize = (maxWidth - 2 * 6) / 2;
    gridItemRatio = itemSize / (itemSize + FontSize.NORMAL.value * 3 + 20.0);
//    print('movie pic size: $itemSize, '
//        'base height: ${itemSize + FontSize.NORMAL.value * 3}');
//    print('gridItemRatio: $gridItemRatio');
    movieList = widget.movies;
    super.initState();
  }

  @override
  void didUpdateWidget(MovieDisplayList oldWidget) {
    print('update hot movies');
    movieList = widget.movies;
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) widget.onUpdateComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (movieList.isEmpty) return SizedBox.shrink();
    return GridView.count(
      primary: false,
      physics: BouncingScrollPhysics(),
      childAspectRatio: gridItemRatio,
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 12.0,
      shrinkWrap: true,
      children: movieList.map((movie) => _createItem(movie)).toList(),
    );
  }

  Widget _createItem(MovieHotModel movie) {
    return GestureDetector(
      onTap: () => widget.onClickMovie(movie.tid, movie.mid),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            constraints: BoxConstraints.tight(Size(itemSize, itemSize)),
            color: Colors.black,
            child: networkImageBuilder(movie.pic),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Row(
              children: [
                Icon(
                  const IconData(0xf087, fontFamily: 'FontAwesome'),
                  size: 16.0,
                  color: themeColor.defaultWidgetColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    '${movie.goodCount}',
                    style: TextStyle(
                      color: themeColor.defaultWidgetColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              movie.title,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

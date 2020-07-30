import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/utils/regex_util.dart';

import '../../data/models/movie_post_model.dart';
import '../data/movie_rate.dart';
import '../state/movie_store.dart';
import 'movie_dialog_mobile.dart';
import 'movie_dialog_pay.dart';
import 'movie_display_player.dart';
import 'movie_plugin_rate.dart';
import 'movie_store_inherit_widget.dart';

class MovieDisplayPost extends StatefulWidget {
  final MoviePostData movie;

  MovieDisplayPost({@required this.movie});

  @override
  _MovieDisplayPostState createState() => _MovieDisplayPostState();
}

class _MovieDisplayPostState extends State<MovieDisplayPost> {
  final GlobalKey<MoviePluginRateState> _favKey =
      new GlobalKey(debugLabel: 'ratefav');
  final GlobalKey<MoviePluginRateState> _goodKey =
      new GlobalKey(debugLabel: 'rategood');
  final GlobalKey<MoviePluginRateState> _badKey =
      new GlobalKey(debugLabel: 'ratebad');

  MovieStore _store;
  String _movieUrl;
  String _tempUrl;

  bool _canWatch;
  bool _rateFavor;
  bool _rateGood;
  bool _rateBad;
  bool _skipRate = false;

  bool _justFree = false;
  bool _justBuy = false;

  @override
  void initState() {
    _canWatch = widget.movie.isPurchased ||
        widget.movie.isFreeToWatch ||
        _justFree ||
        _justBuy;
    _movieUrl = widget.movie.playUrl;
    _rateFavor = widget.movie.clickedFavorite;
    _rateGood = widget.movie.clickedGood;
    _rateBad = widget.movie.clickedBad;
    super.initState();
  }

  @override
  void didUpdateWidget(MovieDisplayPost oldWidget) {
    print('update movie post');
    _canWatch = widget.movie.isPurchased || widget.movie.isFreeToWatch;
    _movieUrl = widget.movie.playUrl;
    _rateFavor = widget.movie.clickedFavorite;
    _rateGood = widget.movie.clickedGood;
    _rateBad = widget.movie.clickedBad;
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration(milliseconds: 300), () {
      // update rate plugins since the widget will be
      // rebuild and lose click state
      if (mounted) {
        if (_rateFavor) _favKey.currentState?.clicked(value: _rateFavor);
        if (_rateGood)
          _goodKey.currentState?.clicked(value: _rateGood);
        else if (_rateBad) _badKey.currentState?.clicked(value: _rateBad);
      }
    });
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StreamBuilder<String>(
          stream: _store.movieUrlStream,
          initialData: '',
          builder: (_, snapshot) {
            if (snapshot != null &&
                snapshot.data.isNotEmpty &&
                snapshot.data.isUrl &&
                _tempUrl != snapshot.data) {
              _tempUrl = snapshot.data;
              Future.delayed(Duration(milliseconds: 200), () {
                if (mounted) {
                  setState(() {
                    _movieUrl = _tempUrl;
                    _canWatch = true;
                  });
                  Future.delayed(Duration(milliseconds: 200), () {
                    // update rate plugins since the widget will be
                    // rebuild and lose click state
                    if (mounted) {
                      if (_rateFavor)
                        _favKey.currentState?.clicked(value: _rateFavor);
                      if (_rateGood)
                        _goodKey.currentState?.clicked(value: _rateGood);
                      else if (_rateBad)
                        _badKey.currentState?.clicked(value: _rateBad);
                    }
                  });
                }
              });
            }
            return SizedBox.shrink();
          },
        ),

        /// Pic & Player Area
        Container(
          constraints: BoxConstraints.tight(Size(
            Global.device.width,
            (_canWatch)
                ? (Global.device.width * Global.device.ratio + 32.0)
                : 144.0,
          )),
          color: Colors.black87,
          padding: const EdgeInsets.all(8.0),

          ///TODO change to official video_player
          child: (_canWatch)
              ? MovieDisplayPlayer(_movieUrl)
              : Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      foregroundDecoration: BoxDecoration(
                        color: Colors.black54,
                      ),
                      child: networkImageBuilder(
                        widget.movie.pic,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        child: Text(
                          localeStr.movieTextBuyNow,
                          style: TextStyle(fontSize: FontSize.MESSAGE.value),
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => MovieDialogPay(
                            movie: widget.movie,
                            onClickedAction: (mid, watchFree) async {
                              if (mid == null || mid < 0) return;

                              bool showMobileDialog;
                              if (watchFree) {
                                showMobileDialog =
                                    await _store.watchFreeMovie(mid);
                                if (!_canWatch && showMobileDialog == false)
                                  setState(() => _justFree = true);
                              } else {
                                showMobileDialog = await _store.buyMovie(mid);
                                if (!_canWatch && showMobileDialog == false)
                                  setState(() => _justBuy = true);
                              }
                              print('show mobile dialog: $showMobileDialog');

                              /// do nothing if null
                              if (showMobileDialog == null) return;

                              /// show mobile dialog if true, close buy dialog if false
                              /// TODO check favor plugin after show player
                              if (showMobileDialog)
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => MovieDialogMobile(
                                    store: _store,
                                    mobile: widget.movie.phone.substring(
                                        0, widget.movie.phone.indexOf('(')),
                                  ),
                                );
                              else
                                Future.delayed(Duration(milliseconds: 500), () {
                                  Navigator.of(context).pop();
                                });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),

        /// Title Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  text: TextSpan(
                    children: <TextSpan>[
                      if (widget.movie.vodkey != null)
                        TextSpan(
                          text: '${widget.movie.vodkey}  ',
                          style: TextStyle(
                            fontSize: FontSize.MESSAGE.value,
                          ),
                        ),
                      TextSpan(
                        text: widget.movie.title,
                        style: TextStyle(
                          fontSize: FontSize.MESSAGE.value,
                          color: Themes.defaultAccentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: FontSize.SMALLER.value * 4.5,
                ),
                padding: const EdgeInsets.only(left: 6.0, top: 5.0),
                child: (widget.movie.isPurchased || _justBuy)
                    ? Text(
                        localeStr.movieHintTextPurchased,
                        style: TextStyle(
                          fontSize: FontSize.SMALLER.value,
                          color: Themes.defaultTextColor,
                        ),
                      )
                    : (widget.movie.isFreeToWatch || _justFree)
                        ? Text(
                            localeStr.movieHintTextFree,
                            style: TextStyle(
                              fontSize: FontSize.SMALLER.value,
                              color: Themes.iconColorGreen,
                            ),
                          )
                        : Text(
                            localeStr.movieHintTextNotPurchased,
                            style: TextStyle(
                              fontSize: FontSize.SMALLER.value,
                              color: Themes.hintHighlightRed,
                            ),
                          ),
              ),
            ],
          ),
        ),

        /// Widget Area
        Container(
          height: 32.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MoviePluginRate(
                key: _favKey,
                movieId: widget.movie.mid,
                type: MoviePluginType.FAVORITE,
                rateCount: 0,
                isClicked: widget.movie.clickedFavorite,
                onClicked: (mid, favor) {
                  _rateFavor = favor;
                  return _store.setFavoriteMovie(mid, favor);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MoviePluginRate(
                  key: _goodKey,
                  movieId: widget.movie.mid,
                  type: MoviePluginType.GOOD,
                  rateCount: widget.movie.goodCount,
                  isClicked: widget.movie.clickedGood,
                  onClicked: (mid, clicked) {
                    _rateGood = clicked;
                    Future<bool> result = Future.value(false);
                    if (!_skipRate) {
                      result = _store.setMovieRate(
                          mid, (clicked) ? MovieRate.GOOD : MovieRate.CANCEL);
                    } else {
                      _skipRate = false;
                      return result;
                    }
                    if (_rateGood && _rateBad) {
                      _skipRate = true;
                      _badKey.currentState?.clicked();
                    }
                    return result;
                  },
                ),
              ),
              MoviePluginRate(
                key: _badKey,
                movieId: widget.movie.mid,
                type: MoviePluginType.BAD,
                rateCount: widget.movie.badCount,
                isClicked: widget.movie.clickedBad,
                onClicked: (mid, clicked) async {
                  _rateGood = clicked;
                  Future<bool> result = Future.value(false);
                  if (!_skipRate) {
                    result = _store.setMovieRate(
                        mid, (clicked) ? MovieRate.BAD : MovieRate.CANCEL);
                  } else {
                    _skipRate = false;
                    return result;
                  }
                  if (_rateGood && _rateBad) {
                    _skipRate = true;
                    _badKey.currentState?.clicked();
                  }
                  return result;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

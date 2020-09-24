import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

typedef OnClickedRate = Future<bool> Function(int, bool);

enum MoviePluginType { GOOD, BAD, FAVORITE }

class MoviePluginRate extends StatefulWidget {
  final int movieId;
  final int rateCount;
  final bool isClicked;
  final MoviePluginType type;
  final OnClickedRate onClicked;

  MoviePluginRate({
    Key key,
    @required this.movieId,
    @required this.rateCount,
    @required this.isClicked,
    @required this.type,
    @required this.onClicked,
  }) : super(key: key);

  @override
  MoviePluginRateState createState() => MoviePluginRateState();
}

class MoviePluginRateState extends State<MoviePluginRate> {
  bool _clicked;
  bool _locked = false;

  void clicked({bool value}) {
    setState(() {
      _clicked = value ?? !_clicked;
    });
    print('${widget.movieId} plugin ${widget.type} set clicked: $_clicked');
  }

  int _getRateCount() {
    bool rated = widget.isClicked;
    if (rated)
      return widget.rateCount - 1;
    else
      return widget.rateCount;
  }

  @override
  void initState() {
    _clicked = widget.isClicked;
    super.initState();
  }

  @override
  void didUpdateWidget(MoviePluginRate oldWidget) {
//    print('update ${widget.movieId} plugin ${widget.type}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_locked) {
          callToast(localeStr.messageActionTooFrequent);
          return;
        }
        _locked = true;
        Future.delayed(Duration(milliseconds: 500), () {
          _locked = false;
        });
        bool success = await widget.onClicked(widget.movieId, !_clicked);
        print('${widget.type} action success = $success');
        // wait for server result
        if (success)
          clicked();
        else
          callToast(localeStr.messageActionFailed);
      },
      child: Row(
        children: [
          Icon(
            (widget.type == MoviePluginType.FAVORITE)
                ? const IconData(0xf006, fontFamily: 'FontAwesome')
                : (widget.type == MoviePluginType.GOOD)
                    ? const IconData(0xf087, fontFamily: 'FontAwesome')
                    : const IconData(0xf088, fontFamily: 'FontAwesome'),
            size: 16.0,
            color: (_clicked)
                ? themeColor.secondaryTextColor1
                : themeColor.iconSubColor2,
          ),
          SizedBox(width: 4.0),
          if (widget.type != MoviePluginType.FAVORITE)
            Text(
              '${(_clicked) ? _getRateCount() + 1 : _getRateCount()}',
              style: TextStyle(
                color: (_clicked)
                    ? themeColor.secondaryTextColor1
                    : themeColor.iconSubColor2,
              ),
            ),
          if (widget.type == MoviePluginType.FAVORITE)
            Text(
              localeStr.movieCategoryLabelCollect,
              style: TextStyle(
                color: (_clicked)
                    ? themeColor.secondaryTextColor1
                    : themeColor.iconSubColor2,
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/movie/data/models/movie_post_model.dart';

typedef OnClickedAction = void Function(int, bool);

class MovieDialogPay extends StatelessWidget {
  final MoviePostData movie;
  final OnClickedAction onClickedAction;

  MovieDialogPay({
    @required this.movie,
    @required this.onClickedAction,
  });

  final double horPadding = Global.device.width / 4;
  final int requirePoints = 30;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      maxHeight: 212.0,
      customBg: Themes.dialogBgColor1,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localeStr.movieDialogTitlePay,
                    style: TextStyle(
                      color: Themes.defaultAccentColor,
                      fontSize: FontSize.MESSAGE.value,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horPadding / 1.5),
                child: Divider(
                  height: 24.0,
                  color: Themes.defaultTextColor,
                  thickness: 1.0,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${localeStr.movieDialogTextFreeTimes}${movie.free}'),
                ],
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${localeStr.movieDialogTextStorePoints}${movie.point}'),
                ],
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horPadding),
                child: RaisedButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(localeStr.movieDialogButtonWatchFree),
                  onPressed: (movie.free > 0)
                      ? () => onClickedAction(movie.mid, true)
                      : null,
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horPadding),
                child: RaisedButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child:
                      Text(localeStr.movieDialogButtonPayPoint(requirePoints)),
                  onPressed: (movie.point >= requirePoints)
                      ? () => onClickedAction(movie.mid, false)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

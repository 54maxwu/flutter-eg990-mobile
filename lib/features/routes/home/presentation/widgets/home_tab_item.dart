import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/models/game_category_model.dart';

const _homeTabSelectedLinearColor1 = Color(0xff76685f);
const _homeTabSelectedLinearColor2 = Color(0xffa8998f);
const _homeTabLinearColor1 = Color(0xfffdeddd);
const _homeTabLinearColor2 = Color(0xffdcc4ac);

class HomeTabItem extends StatefulWidget {
  final GameCategoryModel category;

  HomeTabItem({Key key, @required this.category}) : super(key: key);

  @override
  HomeTabItemState createState() => HomeTabItemState();
}

class HomeTabItemState extends State<HomeTabItem> {
  bool _isSelected = false;

  set setSelected(bool selected) {
    if (selected != _isSelected) {
      setState(() {
        _isSelected = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (_isSelected)
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  _homeTabSelectedLinearColor1,
                  _homeTabSelectedLinearColor2,
                  _homeTabSelectedLinearColor1,
                ],
                stops: [0.1, 0.4, 1.0],
                tileMode: TileMode.clamp,
              ),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: (_isSelected)
                  ? null
                  : BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Themes.homeTabIconBgColor,
                          Themes.homeTabBgColor
                        ],
                        stops: [0.6, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: 24.0,
                height: 20.0,
                child: (widget.category.iconUrl.isNotEmpty)
                    ? networkImageBuilder(
                        widget.category.iconUrl,
                        imgColor: Themes.homeTabIconColor,
                      )
                    : (widget.category.iconCode != null)
                        ? Icon(
                            widget.category.iconCode,
                            color: Themes.homeTabIconColor,
                          )
                        : Icon(
                            Icons.add,
                            color: Themes.homeTabIconColor,
                          ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: (_isSelected)
                  ? null
                  : BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _homeTabLinearColor1,
                          _homeTabLinearColor2,
                          _homeTabLinearColor1,
                        ],
                        stops: [0.1, 0.4, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  widget.category.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

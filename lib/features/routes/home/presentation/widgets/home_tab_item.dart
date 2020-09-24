import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/models/game_category_model.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

class HomeTabItem extends StatefulWidget {
  final GameCategoryModel category;
  final double iconSize;
  final bool isFirst;

  HomeTabItem(
      {Key key, @required this.category, this.iconSize = 24.0, this.isFirst})
      : super(key: key);

  @override
  HomeTabItemState createState() => HomeTabItemState();
}

class HomeTabItemState extends State<HomeTabItem> {
  bool _isSelected;
  Widget imageWidget;

  set setSelected(bool selected) {
    if (selected != _isSelected) {
      _isSelected = selected;
      setState(() {
        imageWidget = _buildImage();
      });
    }
  }

  @override
  void initState() {
    _isSelected = widget.isFirst;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageWidget ??= _buildImage();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(width: 24.0, height: 20.0, child: imageWidget),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(widget.category.label,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return (widget.category.iconUrl.isNotEmpty)
        ? networkImageBuilder(
            widget.category.iconUrl,
            imgColor: (_isSelected)
                ? themeColor.defaultAccentColor
                : themeColor.defaultTabUnselectedColor,
          )
        : Icon((widget.category.iconCode != null)
            ? widget.category.iconCode
            : Icons.add);
  }
}

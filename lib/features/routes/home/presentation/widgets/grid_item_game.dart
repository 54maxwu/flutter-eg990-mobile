import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';
import 'package:relative_layout/relative_layout.dart';

import 'grid_plugin_favorite.dart';

class GridItemGame extends StatelessWidget {
  final String imgUrl;
  final String label;
  final bool isFavorite;
  final double itemSize;
  final double textHeight;
  final double textWidthFactor;
  final PluginTapAction pluginTapAction;
  final bool isIos;

  GridItemGame({
    @required this.imgUrl,
    @required this.label,
    @required this.isFavorite,
    @required this.itemSize,
    @required this.textHeight,
    @required this.textWidthFactor,
    @required this.pluginTapAction,
    @required this.isIos,
  });

  @override
  Widget build(BuildContext context) {
    return RelativeLayout(
      children: <Widget>[
        LayoutId(
          id: RelativeId('img', alignment: Alignment.topCenter),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            constraints: BoxConstraints.tight(
                Size(itemSize - textHeight / 1.5, itemSize - textHeight / 1.5)),
            child: (imgUrl != null)
                ? networkImageBuilder(imgUrl, addPendingIconOnError: true)
                : Center(child: Icon(Icons.broken_image)),
          ),
        ),
        LayoutId(
          id: RelativeId(
            'lb',
            below: 'img',
            alignment: Alignment.center,
          ),
          child: Container(
            constraints: BoxConstraints.tightFor(
                width: itemSize * textWidthFactor, height: textHeight),
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: label ?? '?',
                style: TextStyle(
                  color: themeColor.defaultGridTextColor,
                  fontSize: FontSize.SMALLER.value,
                ),
              ),
            ),
          ),
        ),
        if (pluginTapAction != null)
          LayoutId(
            id: RelativeId('fav', alignment: Alignment.topLeft),
            child: GridPluginFavorite(
              initValue: isFavorite,
              onTap: (checked) => pluginTapAction(checked),
              padding: const EdgeInsets.only(left: 4.0, top: 2.0),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/font_size.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:relative_layout/relative_layout.dart';

import 'grid_plugin_favorite.dart';

class GridItemGame extends StatelessWidget {
  final String imgUrl;
  final String label;
  final bool isFavorite;
  final double itemSize;
  final double textHeight;
  final bool twoLineText;
  final PluginTapAction pluginTapAction;
  final bool isIos;

  GridItemGame({
    @required this.imgUrl,
    @required this.label,
    @required this.isFavorite,
    @required this.itemSize,
    @required this.textHeight,
    @required this.twoLineText,
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
//            margin: const EdgeInsets.only(bottom: 12.0),
            constraints: BoxConstraints.tight(Size(itemSize, itemSize)),
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
            margin: const EdgeInsets.only(bottom: 14.0),
            padding: (twoLineText)
                ? (isIos)
                    ? const EdgeInsets.only(bottom: 4.0)
                    : const EdgeInsets.only(bottom: 6.0)
                : EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(
              width: itemSize * 0.9,
              height: textHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        label ?? '?',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: (twoLineText) ? 2 : 1,
                        style: TextStyle(
                          fontSize: FontSize.NORMAL.value,
                          color: Themes.defaultGridTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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

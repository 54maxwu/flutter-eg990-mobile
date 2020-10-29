import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

import 'grid_plugin_favorite.dart';

class GridItemMix extends StatelessWidget {
  final String imgUrl;
  final String label;
  final bool isFavorite;
  final double itemSize;
  final double textHeight;
  final double textWidthFactor;
  final bool isPlatform;
  final PluginTapAction pluginTapAction;
  final bool isIos;

  GridItemMix({
    @required this.isPlatform,
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
    return SizedBox(
      width: itemSize,
      height: itemSize + textHeight,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(itemSize, itemSize)),
            child: (imgUrl != null)
                ? Transform.scale(
                    scale: (isPlatform) ? 0.95 : 0.8,
                    child: networkImageBuilder(imgUrl,
                        addPendingIconOnError: true),
                  )
                : Center(child: Icon(Icons.broken_image)),
          ),
          Positioned(
            top: itemSize * 0.95,
            left: ((itemSize * (1 - textWidthFactor)) / 3).floorToDouble(),
            child: SizedBox(
              width: itemSize * textWidthFactor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AutoSizeText.rich(
                      TextSpan(
                        text: label ?? '?',
                        style: TextStyle(
                          color: themeColor.defaultGridTextColor,
                        ),
                      ),
                      maxLines:
                          (textHeight > FontSize.NORMAL.value * 2) ? 2 : 1,
                      minFontSize: FontSize.SMALL.value - 4,
                      maxFontSize: FontSize.NORMAL.value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (pluginTapAction != null)
            Positioned(
              left: 0,
              top: 0,
              child: GridPluginFavorite(
                initValue: isFavorite,
                onTap: (checked) => pluginTapAction(checked),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

import '../data/member_grid_item_v2.dart';

typedef onMemberGridItemV2Tap = void Function(MemberGridItemV2);

class MemberGridItemWidgetV2 extends StatelessWidget {
  final MemberGridItemV2 item;
  final double iconSize;
  final double textSize;
  final double textHeight;
  final onMemberGridItemV2Tap onItemTap;

  MemberGridItemWidgetV2(
      {@required this.item,
      @required this.iconSize,
      @required this.textSize,
      @required this.textHeight,
      @required this.onItemTap});

  RouteListItem get itemData => item.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTap(item),
      child: Container(
        constraints:
            BoxConstraints.tightFor(height: iconSize + textHeight + 20.0),
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: themeColor.defaultGridColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
                  child: networkImageBuilder(
                    itemData.imageName,
                    imgColor: themeColor.memberIconColor,
                  )),
            ),
            Container(
              height: textHeight,
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      itemData.title ?? itemData.route?.pageTitle ?? '?',
                      style: TextStyle(
                          fontSize: FontSize.SUBTITLE.value - 1,
                          color: themeColor.iconTextColor),
                      maxLines: 2,
                      maxFontSize: FontSize.SUBTITLE.value - 1,
                      minFontSize: FontSize.SMALL.value - 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

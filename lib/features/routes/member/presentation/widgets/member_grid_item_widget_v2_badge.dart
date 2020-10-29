import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_eg990_mobile/features/general/ext/badge/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

import '../data/member_grid_item_v2.dart';
import '../state/member_credit_store.dart';

typedef onMemberGridItemV2Tap = void Function(MemberGridItemV2);

enum MemberGridItemV2BadgeType { NEW_MESSAGE }

class MemberGridItemWidgetV2Badge extends StatefulWidget {
  final MemberGridItemV2 item;
  final double iconSize;
  final double textSize;
  final double textHeight;
  final onMemberGridItemV2Tap onItemTap;
  final MemberCreditStore store;
  final MemberGridItemV2BadgeType type;

  MemberGridItemWidgetV2Badge({
    @required this.item,
    @required this.iconSize,
    @required this.textSize,
    @required this.textHeight,
    @required this.onItemTap,
    @required this.store,
    @required this.type,
  });

  @override
  _MemberGridItemWidgetV2BadgeState createState() =>
      _MemberGridItemWidgetV2BadgeState();
}

class _MemberGridItemWidgetV2BadgeState
    extends State<MemberGridItemWidgetV2Badge> {
  RouteListItem get itemData => widget.item.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onItemTap(widget.item),
      child: Container(
        constraints: BoxConstraints.tightFor(
            height: widget.iconSize + widget.textHeight + 20.0),
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
            Container(
              constraints:
                  BoxConstraints.tight(Size(widget.iconSize, widget.iconSize)),
              child: Observer(
                builder: (_) => Badge(
                  showBadge: widget.store.hasNewMessage,
                  badgeColor: themeColor.hintHighlightRed,
                  badgeContent: Container(
                    margin: const EdgeInsets.all(1.0),
                    child: Icon(
                      const IconData(0xf129, fontFamily: 'FontAwesome'),
                      color: Colors.white,
                      size: 10.0,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  position: BadgePosition.topEnd(top: -2, end: -6),
                  child: networkImageBuilder(
                    itemData.imageName,
                    imgColor: themeColor.memberIconColor,
                  ),
                ),
              ),
            ),
            Container(
              height: widget.textHeight,
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

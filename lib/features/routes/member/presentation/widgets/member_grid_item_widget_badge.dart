import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/ext/badge/badge.dart';
import 'package:flutter_eg990_mobile/features/routes/member/presentation/state/member_credit_store.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../data/member_grid_item.dart';
import '../data/member_grid_item_data.dart';

typedef onMemberGridItemBadgeTap = void Function(MemberGridItem);

enum _MemberGridItemType { BASIC, LINEAR }

class MemberGridItemWidgetBadge extends StatefulWidget {
  final MemberCreditStore store;
  final MemberGridItem item;
  final onMemberGridItemBadgeTap onItemTap;
  final _MemberGridItemType type;

  MemberGridItemWidgetBadge({
    @required this.item,
    @required this.onItemTap,
    @required this.store,
  }) : this.type = _MemberGridItemType.BASIC;

  MemberGridItemWidgetBadge.linearCircle({
    @required this.item,
    @required this.onItemTap,
    @required this.store,
  }) : this.type = _MemberGridItemType.LINEAR;

  @override
  _MemberGridItemWidgetBadgeState createState() =>
      _MemberGridItemWidgetBadgeState();
}

class _MemberGridItemWidgetBadgeState extends State<MemberGridItemWidgetBadge> {
  final _maxFontSize = FontSize.SUBTITLE.value;

  final _minFontSize = FontSize.SMALL.value;

  MemberGridItemData get itemData => widget.item.value;

  @override
  Widget build(BuildContext context) {
    Widget _title = _buildTitle();
    Widget _image = _buildImage();
    Widget _child;
    switch (widget.type) {
      case _MemberGridItemType.BASIC:
        _child = _buildBasicItem(
          titleWidget: _title,
          imageWidget: _image,
        );
        break;
      case _MemberGridItemType.LINEAR:
        _child = _buildLinearItem(
          titleWidget: _title,
          imageWidget: _image,
        );
        break;
    }
    return GestureDetector(
      onTap: () => widget.onItemTap(widget.item),
      child: _child,
    );
  }

  Widget _buildTitle() {
    return Expanded(
      flex: (widget.type.index == 0) ? 1 : 4,
      child: Container(
        height: _maxFontSize * 2.25,
        padding: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 0.0),
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            Expanded(
              child: AutoSizeText(
                '${itemData.title ?? itemData.route?.pageTitle ?? '?'}',
                style: TextStyle(
                  fontSize: FontSize.NORMAL.value,
                  color: themeColor.iconTextColor,
                ),
                maxLines: 2,
                maxFontSize: _maxFontSize,
                minFontSize: _minFontSize,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    switch (itemData.imageType) {
      case MemberGridItemImage.IMAGE:
        return networkImageBuilder(
          itemData.imageUrl,
          imgColor: themeColor.memberIconColor,
        );
      case MemberGridItemImage.ASSET:
        return Image.asset(
          itemData.assetPath,
          color: themeColor.memberIconColor,
        );
      default:
        if (widget.type.index == 0) {
          return Icon(
            itemData.iconData,
            color: themeColor.memberIconColor,
            size: 30.0 * Global.device.widthScale,
          );
        } else {
          return Icon(
            itemData.iconData,
            color: themeColor.memberIconColor,
            size: 20.0 * Global.device.widthScale,
          );
        }
        break;
    }
  }

  Widget _buildBasicItem({
    @required Widget titleWidget,
    Widget imageWidget,
  }) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: themeColor.defaultGridColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.bottomCenter,
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
                  position: BadgePosition.topEnd(top: 2, end: 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: imageWidget,
                  ),
                ),
              ),
            ),
          ),
          titleWidget,
        ],
      ),
    );
  }

  Widget _buildLinearItem({
    @required Widget titleWidget,
    Widget imageWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.bottomCenter,
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
                  position: BadgePosition.topEnd(top: 2, end: 4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: itemData.createLinearGradient(),
                        shape: BoxShape.circle,
                      ),
                      child: imageWidget,
                    ),
                  ),
                ),
              ),
            ),
          ),
          titleWidget,
        ],
      ),
    );
  }
}

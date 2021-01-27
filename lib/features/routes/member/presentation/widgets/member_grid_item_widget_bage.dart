import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/font_size.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/features/routes/home/presentation/widgets/corner_clipper.dart';
import 'package:flutter_eg990_mobile/features/routes/member/presentation/state/member_credit_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../data/member_grid_data.dart';
import '../data/member_grid_item.dart';

typedef onMemberGridItemTap = void Function(MemberGridItem);

enum MemberGridItemBadgeType { NEW_MESSAGE }

const LinearGradient _itemLinearGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Themes.memberLinearColor3,
    Themes.memberLinearColor2,
    Themes.memberLinearColor1,
  ],
  stops: [0.1, 0.5, 1.0],
  tileMode: TileMode.clamp,
);

class MemberGridItemBadgeWidget extends StatelessWidget {
  final MemberCreditStore store;
  final MemberGridItemBadgeType type;
  final MemberGridItem item;
  final onMemberGridItemTap onItemTap;
  final double iconSize;
  final double textHeight;

  MemberGridItemBadgeWidget({
    @required this.item,
    @required this.onItemTap,
    @required this.store,
    @required this.type,
    this.iconSize,
    this.textHeight,
  });

  MemberGridData get itemData => item.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTap(item),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            gradient: _itemLinearGradient,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: itemData.iconDecorColor ?? Themes.memberIconColor,
                    ),
                    child: Observer(
                      builder: (_) => Badge(
                        showBadge: store.hasNewMessage,
                        badgeColor: Themes.hintHighlightRed,
                        badgeContent: Container(
                            margin: const EdgeInsets.all(1.0),
                            child: Icon(
                                const IconData(0xf129,
                                    fontFamily: 'FontAwesome'),
                                color: Colors.white,
                                size: 10.0)),
                        padding: EdgeInsets.zero,
                        position: BadgePosition.topRight(top: -2, right: -4),
                        child: DecoratedBox(
                            decoration: Themes.roundIconDecorLight,
                            child: Icon(itemData.iconData,
                                size: iconSize ?? 24.0)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 8.0),
                    height: textHeight,
                    child: Text(
                      itemData.label,
                      style: TextStyle(fontSize: FontSize.SUBTITLE.value - 1),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: ClipPath(
                  clipper: new CornerClipper(),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    width: iconSize ?? 24.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(4.0)),
                      color: cornerColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

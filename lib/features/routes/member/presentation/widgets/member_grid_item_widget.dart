import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/routes/home/presentation/widgets/corner_clipper.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

import '../data/member_grid_data.dart';
import '../data/member_grid_item.dart';

typedef onMemberGridItemTap = void Function(MemberGridItem);

LinearGradient _itemLinearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    themeColor.memberLinearColor3,
    themeColor.memberLinearColor2,
    themeColor.memberLinearColor1,
  ],
  stops: [0.1, 0.5, 1.0],
  tileMode: TileMode.clamp,
);

class MemberGridItemWidget extends StatelessWidget {
  final MemberGridItem item;
  final onMemberGridItemTap onItemTap;
  final double iconSize;
  final double textHeight;

  MemberGridItemWidget(
      {@required this.item,
      @required this.onItemTap,
      this.iconSize,
      this.textHeight});

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
                      color:
                          itemData.iconDecorColor ?? themeColor.memberIconColor,
                    ),
                    child: DecoratedBox(
                        decoration: ThemeInterface.roundIconDecorLight,
                        child: Icon(itemData.iconData, size: iconSize ?? 24.0)),
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

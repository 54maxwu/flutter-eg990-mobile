import 'package:custom_rounded_rectangle_border/custom_rounded_rectangle_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';

typedef OnTypeGridTap = void Function(int, dynamic);

//const LinearGradient _itemLinearColor = const LinearGradient(
//  begin: Alignment.bottomLeft,
//  end: Alignment.topRight,
//  colors: [
//    Color.fromRGBO(255, 255, 255, 0.56),
//    Color.fromRGBO(255, 255, 255, 0.58),
//    Color.fromRGBO(197, 171, 139, 0.7),
//    Color.fromRGBO(255, 255, 255, 0.54),
//  ],
//  stops: [0.0, 0.14, 0.48, 0.98],
//  tileMode: TileMode.clamp,
//);

/// Grid View for [PaymentEnum]
///@author H.C.CHIANG
///@version 2020/3/26
class TypesGridWidget<T extends DataOperator> extends StatefulWidget {
  final List<T> types;
  final String titleKey;
  final OnTypeGridTap onTypeGridTap;
  final int tabsPerRow;
  final double itemSpace;
  final double expectTabHeight;
  final double horizontalInset;

  TypesGridWidget({
    Key key,
    @required this.types,
    @required this.titleKey,
    @required this.onTypeGridTap,
    this.tabsPerRow = 2,
    this.itemSpace = 8.0,
    this.expectTabHeight = 42.0,
    this.horizontalInset = 48.0,
  }) : super(key: key);

  @override
  _TypesGridWidgetState createState() => _TypesGridWidgetState();
}

class _TypesGridWidgetState extends State<TypesGridWidget> {
  int _clicked = 0;
  double _gridRatio;

  final BorderSide borderSide = BorderSide(color: Themes.defaultBorderColor);
  final BorderSide borderSideTrans = BorderSide(color: Colors.transparent);

  @override
  void initState() {
    // screen width - widget padding - cross space = available width
    double itemWidth = (Global.device.width -
            widget.horizontalInset -
            widget.itemSpace * (widget.tabsPerRow + 2)) /
        widget.tabsPerRow;
    _gridRatio = itemWidth / widget.expectTabHeight;
    debugPrint('grid item width: $itemWidth, gridRatio: $_gridRatio');
    if (_gridRatio > 4.16) _gridRatio = 4.16;
    super.initState();
  }

  @override
  void didUpdateWidget(TypesGridWidget oldWidget) {
    var selected = widget.types[_clicked];
    super.didUpdateWidget(oldWidget);
    setState(() {
      _clicked = widget.types.indexWhere((element) => element == selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.types == null || widget.types.isEmpty) return SizedBox.shrink();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.tabsPerRow,
        crossAxisSpacing: widget.itemSpace,
        mainAxisSpacing: widget.itemSpace * 2,
        childAspectRatio: _gridRatio,
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.types.length,
      itemBuilder: (_, index) {
        final type = widget.types[index];
        return GestureDetector(
          onTap: () {
            if (_clicked == index) return;
            setState(() {
              _clicked = index;
            });
            widget.onTypeGridTap(index, type);
          },
          child: Container(
            decoration: ShapeDecoration(
                color: (_clicked == index)
                    ? Themes.defaultTabSelectedColor
                    : Themes.defaultTabUnselectedColor,
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2.15,
                    blurRadius: 3.0,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
                shape: CustomRoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(6.0)),
                  leftSide: borderSide,
                  topLeftCornerSide: borderSide,
                  bottomLeftCornerSide: borderSide,
                  rightSide: borderSide,
                  topRightCornerSide: borderSide,
                  bottomRightCornerSide: borderSide,
                  topSide: borderSide,
                  bottomSide: borderSideTrans,
                )),
            margin: (index > 0 && (index + 1) % widget.tabsPerRow == 0)
                ? const EdgeInsets.only(right: 5.0)
                : EdgeInsets.zero,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                type[widget.titleKey],
                style: TextStyle(
                  color: (_clicked == index)
                      ? Themes.defaultTabSelectedTextColor
                      : Themes.buttonTextPrimaryColor,
                  fontSize: FontSize.SUBTITLE.value,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}

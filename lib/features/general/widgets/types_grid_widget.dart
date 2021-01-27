import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

typedef OnTypeGridTap = void Function(int, dynamic);

/// Grid View for [PaymentEnum]
///@author H.C.CHIANG
///@version 2020/3/26
class TypesGridWidget<T extends DataOperator> extends StatefulWidget {
  final List<T> types;
  final String titleKey;
  final OnTypeGridTap onTypeGridTap;
  final int tabsPerRow;
  final double itemSpace;
  final double itemSpaceHorFactor;
  final double expectTabHeight;
  final double horizontalInset;
  final bool round;

  TypesGridWidget({
    Key key,
    @required this.types,
    @required this.titleKey,
    @required this.onTypeGridTap,
    this.tabsPerRow = 3,
    this.itemSpace = 8.0,
    this.itemSpaceHorFactor = 2.0,
    this.expectTabHeight = 36.0,
    this.horizontalInset = 48.0,
    this.round = false,
  }) : super(key: key);

  @override
  _TypesGridWidgetState createState() => _TypesGridWidgetState();
}

class _TypesGridWidgetState extends State<TypesGridWidget>
    with AutomaticKeepAliveClientMixin {
  int _clicked = 0;
  double _gridRatio;

  final BorderSide borderSide =
      BorderSide(color: themeColor.defaultBorderColor);
  final BorderSide borderSideTrans = BorderSide(color: Colors.transparent);

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    if (widget.types == null || widget.types.isEmpty) return SizedBox.shrink();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.tabsPerRow,
        crossAxisSpacing: widget.itemSpace,
        mainAxisSpacing: widget.itemSpace * widget.itemSpaceHorFactor,
        childAspectRatio: _gridRatio,
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.types.length,
      itemBuilder: (_, index) {
        final type = widget.types[index];
        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: Global.device.comfortButtonHeight,
          ),
          child: RaisedButton(
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius:
                  new BorderRadius.circular((widget.round) ? 24.0 : 4.0),
            ),
            color: (_clicked == index)
                ? themeColor.buttonPrimaryColor
                : themeColor.buttonSecondaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                type[widget.titleKey],
                style: TextStyle(
                  color: (_clicked == index)
                      ? themeColor.buttonTextPrimaryColor
                      : themeColor.buttonTextSubColor,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              if (_clicked == index) return;
              setState(() {
                _clicked = index;
              });
              widget.onTypeGridTap(index, type);
            },
          ),
        );
      },
    );
  }
}

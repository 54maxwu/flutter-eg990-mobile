import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/features/subfeatures/deposit/data/entity/payment_enum.dart';

/// Grid View for [PaymentEnum]
///@author H.C.CHIANG
///@version 2020/3/26
class DepositDisplayGrid extends StatefulWidget {
  final List<PaymentEnum> types;
  final Function pressedCallback;

  DepositDisplayGrid({key, this.types, this.pressedCallback}) : super(key: key);

  @override
  _DepositDisplayGridState createState() => _DepositDisplayGridState();
}

class _DepositDisplayGridState extends State<DepositDisplayGrid> {
  int _clicked = 0;
  double gridRatio;

  @override
  void initState() {
    double gridItemWidth = (Global.device.width - 6 * 5 - 12) / 3;
    gridRatio = gridItemWidth / 36;
    print('grid item width: $gridItemWidth, gridRatio: $gridRatio');
    if (gridRatio > 4.16) gridRatio = 4.16;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        childAspectRatio: gridRatio,
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.types.length,
      itemBuilder: (context, index) {
        PaymentEnum type = widget.types[index];
        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: Global.device.comfortButtonHeight,
          ),
          child: RaisedButton(
            visualDensity: VisualDensity.compact,
            color: (_clicked == index)
                ? Themes.buttonPrimaryColor
                : Themes.buttonSecondaryColor,
            textColor: (_clicked == index)
                ? Themes.buttonTextPrimaryColor
                : Themes.defaultTextColor,
            child: Text(type.title),
            onPressed: () {
              if (_clicked == index) return;
              setState(() {
                _clicked = index;
              });
              widget.pressedCallback(type);
            },
          ),
        );
      },
    );
  }
}

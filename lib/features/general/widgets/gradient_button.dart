import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';

const LinearGradient _buttonLinearColor = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Themes.buttonLinearColor2,
    Themes.buttonLinearColor1,
    Themes.buttonLinearColor2,
  ],
  stops: [0.1, 0.5, 1.0],
  tileMode: TileMode.clamp,
);

const LinearGradient _buttonLinearLightColor = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Themes.buttonLinearLightColor2,
    Themes.buttonLinearLightColor1,
    Themes.buttonLinearLightColor2,
  ],
  stops: [0.1, 0.5, 1.0],
  tileMode: TileMode.clamp,
);

const LinearGradient _buttonLinearGoldColor = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    const Color(0xffa27b5e),
    const Color(0xfff8dfb2),
    const Color(0xffcf8952),
  ],
  stops: [0.1, 0.36, 1.0],
  tileMode: TileMode.clamp,
);

const LinearGradient _buttonLinearGoldDiagonalColor = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [
    const Color(0xffa27b5e),
    const Color(0xfff8dfb2),
    const Color(0xffcf8952),
  ],
  stops: [0.0, 0.48, 1.0],
  tileMode: TileMode.clamp,
);

enum GradientButtonColor { NORMAL, LIGHT, GOLD, GOLD_DIAG }

class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double height;
  final double lrPadding;
  final double cornerRadius;
  final bool addShadow;
  final bool expand;
  final GradientButtonColor colorType;
  final Function onPressed;

  const GradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.height,
    this.lrPadding = 8.0,
    this.cornerRadius = 4.0,
    this.addShadow = false,
    this.expand = false,
    this.colorType = GradientButtonColor.NORMAL,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient gradient;
    switch (colorType) {
      case GradientButtonColor.NORMAL:
        gradient = _buttonLinearColor;
        break;
      case GradientButtonColor.LIGHT:
        gradient = _buttonLinearLightColor;
        break;
      case GradientButtonColor.GOLD:
        gradient = _buttonLinearGoldColor;
        break;
      case GradientButtonColor.GOLD_DIAG:
        gradient = _buttonLinearGoldDiagonalColor;
        break;
    }
    final Widget button = Container(
      height: height ?? Global.device.comfortButtonHeight,
      padding: EdgeInsets.symmetric(horizontal: lrPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        gradient: gradient,
        boxShadow: (addShadow)
            ? [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 8.0),
                child: child,
              ),
            )),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        (expand) ? Expanded(child: button) : Center(child: button),
      ],
    );
  }
}

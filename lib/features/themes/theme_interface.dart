import 'package:flutter/painting.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';

import 'theme_color_interface.dart';
import 'theme_settings.dart';

export 'font_size.dart';
export 'hex_color.dart';
export 'theme_color_interface.dart';

ThemeColorInterface get themeColor => ThemeInterface.theme.interface;

abstract class ThemeInterface {
  static ThemeSettings theme = sl.get<ThemeSettings>();

  /*******************************************************************
   * Variables                                                       *
   *******************************************************************/
  /// Input Field Settings
  static const double fieldHeight = 53.6;
  static const double fieldIconSize = 24.0;
  static const double prefixTextWidthFactor = 0.35;
  static const double prefixTextSpacing = 5.0;
  static const double prefixIconWidthFactor = 0.166;
  static const double suffixWidthFactor = 0.314;
  static const double horizontalInset = 32.0;
  static const double minusSize = 8.0;

  /*******************************************************************
   * Decoration                                                      *
   *******************************************************************/
  /// Container Decor
  static BoxDecoration get layerShadowDecorRound => BoxDecoration(
      color: themeColor.defaultLayeredBackgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      boxShadow: ThemeInterface.layerShadow);

  static BoxDecoration get layerShadowDecorRoundTop => BoxDecoration(
      color: themeColor.defaultLayeredBackgroundColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      boxShadow: ThemeInterface.layerShadowLight);

  static BoxDecoration get layerShadowDecorRoundBottom => BoxDecoration(
      color: themeColor.defaultLayeredBackgroundColor,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
      boxShadow: ThemeInterface.layerShadowLight);

  static BoxDecoration get gridItemShadowDecor => BoxDecoration(
      color: themeColor.defaultLayeredBackgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      boxShadow: ThemeInterface.gridItemShadow);

  static BoxDecoration get roundIconDecor => BoxDecoration(
      shape: BoxShape.circle, boxShadow: ThemeInterface.roundIconShadowDark);

  static BoxDecoration get roundIconDecorLight => BoxDecoration(
      shape: BoxShape.circle, boxShadow: ThemeInterface.roundIconShadowLight);

  /// Container Shadow
  static List<BoxShadow> layerShadow = <BoxShadow>[
    BoxShadow(
      color: Color(0x61000000),
      spreadRadius: 2.15,
      blurRadius: 3.0,
      offset: Offset(3, 2), // changes position of shadow
    ),
  ];

  static List<BoxShadow> layerShadowLight = <BoxShadow>[
    BoxShadow(
      color: Color(0x42000000),
      spreadRadius: 2.15,
      blurRadius: 3.0,
      offset: Offset(3, 3), // changes position of shadow
    ),
  ];

  static List<BoxShadow> gridItemShadow = <BoxShadow>[
    BoxShadow(
      color: Color(0x1f000000),
      spreadRadius: 1.15,
      blurRadius: 2.0,
      offset: Offset(2, 2), // changes position of shadow
    ),
  ];

  static List<BoxShadow> roundIconShadow = <BoxShadow>[
    BoxShadow(
        color: Color(0x42000000),
        spreadRadius: 1.15,
        blurRadius: 2.0,
        offset: Offset(1, 2))
  ];

  static List<BoxShadow> roundIconShadowDark = <BoxShadow>[
    BoxShadow(
        color: Color(0x73000000),
        spreadRadius: 2.25,
        blurRadius: 7.0,
        offset: Offset(2, 6))
  ];

  static List<BoxShadow> roundIconShadowLight = <BoxShadow>[
    BoxShadow(
        color: Color(0x42000000),
        spreadRadius: 1.15,
        blurRadius: 5.0,
        offset: Offset(2, 5))
  ];
}

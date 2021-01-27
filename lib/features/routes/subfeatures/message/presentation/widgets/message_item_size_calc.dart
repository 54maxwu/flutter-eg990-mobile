import 'package:flutter_eg990_mobile/core/internal/font_size.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';

class MessageItemSizeCalc {
  double headerTextSize;
  double maxHeight;
  double maxHeaderHeight;
  double headerInset;
  double maxWidth;
  double iconSize;

  MessageItemSizeCalc() {
    headerTextSize = FontSize.TITLE.value;
    maxHeight = headerTextSize * 3.5;
    maxHeaderHeight = headerTextSize * 2.75;
    headerInset = (maxHeight - maxHeaderHeight) / 2 - 4.0;

    maxWidth = Global.device.width - 80.0;
    iconSize = 24.0 * Global.device.widthScale;
  }
}

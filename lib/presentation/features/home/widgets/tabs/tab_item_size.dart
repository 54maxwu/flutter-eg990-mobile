import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/font_size.dart';

class TabItemSize {
  TabItemSize() {
    if (Global.device.widthScale > 1.0) {
      _selectedImageSize = const Size(36.0, 36.0) * Global.device.widthScale;
      _imageSize = const Size(30.0, 30.0) * Global.device.widthScale;
    } else {
      double shrinkScale = (1.0 - Global.device.widthScale) / 2;
      _selectedImageSize = const Size(36.0, 36.0) * (1.0 - shrinkScale);
      _imageSize = const Size(30.0, 30.0) * (1.0 - shrinkScale);
    }
    _tabConstraint = BoxConstraints.tight(Size(
      _selectedImageSize.width + FontSize.SUBTITLE.value * 3.5,
      _selectedImageSize.height + 12.0,
    ));
  }

  BoxConstraints _tabConstraint;
  Size _selectedImageSize;
  Size _imageSize;

  BoxConstraints get getTabConstraint => _tabConstraint;
  Size get getSelectedImageSize => _selectedImageSize;
  Size get getImageSize => _imageSize;
}

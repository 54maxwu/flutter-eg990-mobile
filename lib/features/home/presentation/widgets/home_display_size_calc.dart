import 'package:flutter_ty_mobile/core/internal/global.dart';

class HomeDisplaySizeCalc {
  final double bannerImageScale = 600.0 / Global.device.width;
  final double marqueeHeight = 36.0;
  final double shortcutTitleHeight = 36.0;
  final double shortcutMaxHeight = 120.0;
  final double shortcutMinHeight = 108.0;

  double _barMinWidth = Global.device.width / 3 - 16;
  double _barMaxWidth = Global.device.width / 3 - 8;

  double _bannerHeight;

  double _tabWidthFactor;
  double _barMaxHeight;
  double _barMinHeight;

  double _tabPageMinWidth;
  double _tabPageMaxWidth;

  double _tabPageMaxHeight;

  HomeDisplaySizeCalc() {
    _bannerHeight = 231 / bannerImageScale;

    if (_barMaxWidth > 160) _barMaxWidth = 160;
    if (_barMinWidth > _barMaxWidth) _barMinWidth = _barMaxWidth;

    double availableWidth = Global.device.width - _barMaxWidth;
    _tabWidthFactor = (Global.device.widthScale > 1.5) ? 1.5 : 1.0;

    double availableHeight = Global.device.featureContentHeight -
        bannerHeight -
        shortcutMaxHeight -
        8;
    _tabPageMaxHeight = availableHeight;
    if (Global.device.isIos) _tabPageMaxHeight -= 36;

    _barMaxHeight = _tabPageMaxHeight + 12.0;

    _tabPageMinWidth = Global.device.width * 0.6;
    _tabPageMaxWidth = availableWidth - 24;
    if (_tabPageMaxWidth < _tabPageMinWidth)
      _tabPageMaxWidth = _tabPageMinWidth;
  }

  double get bannerHeight => _bannerHeight;

  double get barMaxWidth => _barMaxWidth;
  double get barMinWidth => _barMinWidth;
  double get barMaxHeight => _barMaxHeight;

  double get pageMaxWidth => _tabPageMaxWidth;
  double get pageMinWidth => _tabPageMinWidth;

  double get pageMaxHeight => _tabPageMaxHeight;

  // 36 = shortcut widget height variation
  double get userPageMaxHeight => _tabPageMaxHeight + 36.0;

  double get widthFactor => _tabWidthFactor;
}

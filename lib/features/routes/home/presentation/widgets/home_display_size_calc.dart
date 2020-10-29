import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/features/themes/font_size.dart';

class HomeDisplaySizeCalc {
  final double _bannerImageScale = 600.0 / Global.device.width;
  final double _expectBannerHeight = 231.0;
  final double marqueeHeight = 36.0;
  final double shortcutTitleHeight = 36.0;
  final double shortcutMaxIconSize = 28.0;
  final double shortcutMinIconSize = 24.0;
  final double _barItemInset = 8.0;
  final double barItemIconSize = 28.0;
  final double textWidthFactor = 0.85;

  double _bannerHeight;
  double _expandedBannerHeight;

  double _shortcutMaxHeight;
  double _shortcutMinHeight;
  double _shortcutMinTextHeight;
  double _shortcutMaxTextHeight;

  double _barMinWidth;
  double _barMaxWidth;
  double _barItemWidth;
  double _barItemHeight;
  double _tabWidthFactor;

  double _tabPageMinWidth;
  double _tabPageMaxWidth;
  double _tabPageMaxHeight;

  HomeDisplaySizeCalc() {
    debugPrint('--------HomeDisplaySizeCalc--------');
    double availableWidth =
        Global.device.width - Global.device.safeHorizontalPadding;
    _barMaxWidth = (availableWidth * 0.35).floorToDouble();
    _barMinWidth = _barMaxWidth - _barItemInset;
    if (_barMinWidth < 120) {
      double diff = 120 - _barMinWidth;
      _barMinWidth = 120;
      _barMaxWidth += diff;
    }
    _tabWidthFactor = (Global.device.widthScale > 1.5) ? 1.5 : 1.0;
    debugPrint('available width: $availableWidth');
    debugPrint('tab bar width: $_barMinWidth~$_barMaxWidth');

    if (_barMaxWidth > 180) _barMaxWidth = 180;
    if (_barMinWidth > _barMaxWidth) _barMinWidth = _barMaxWidth - 16;
    debugPrint('adjusted tab bar width: $_barMinWidth~$_barMaxWidth');
    _barItemHeight = (barItemIconSize * 1.5 + 4.0) * Global.device.widthScale;
    if (Global.lang != 'zh') _barItemHeight = _barItemHeight * 1.25;
    _barItemWidth = _barMinWidth - _barItemInset;

    _shortcutMinTextHeight = (Global.lang != 'zh' && Global.lang != 'th')
        ? FontSize.NORMAL.value * 2.75
        : FontSize.NORMAL.value * 1.75;
    _shortcutMaxTextHeight = (Global.lang != 'zh' && Global.lang != 'th')
        ? FontSize.NORMAL.value * 3.5
        : FontSize.NORMAL.value * 2.75;
    _shortcutMaxHeight = _shortcutMaxTextHeight +
        shortcutMaxIconSize +
        shortcutTitleHeight +
//        10.0 +
        16.0;
    _shortcutMinHeight = _shortcutMaxHeight - 16.0;
    debugPrint('----');
    double expandBannerHeight =
        _expectBannerHeight * 1.6 * Global.device.heightScale;
    _bannerHeight = _expectBannerHeight / _bannerImageScale;
    _expandedBannerHeight =
        (expandBannerHeight + shortcutMaxHeight) / _bannerImageScale;
    if (_expandedBannerHeight > 400) {
      _expandedBannerHeight = 400;
    }
    debugPrint(
        'banner height: $_bannerHeight, expanded: $_expandedBannerHeight');
    debugPrint('shortcut box height: $_shortcutMinHeight~$_shortcutMaxHeight');
    debugPrint('shortcut box title height: $shortcutTitleHeight');

    double availableHeight =
        Global.device.featureContentHeight - _bannerHeight - _shortcutMaxHeight;
//    double availableHeight =
//        Global.device.featureContentHeight - _expandedBannerHeight;
    debugPrint('----');
    debugPrint('content available height: $availableHeight');

    _tabPageMaxHeight = availableHeight;
    debugPrint('tab page height: $_barMinWidth~$_barMaxWidth');

    _tabPageMinWidth = Global.device.width * 0.5;
    _tabPageMaxWidth = availableWidth - _barMaxWidth - 24;
    debugPrint('tab page width: $_tabPageMinWidth~$_tabPageMaxWidth');
    if (_tabPageMaxWidth < _tabPageMinWidth)
      _tabPageMinWidth = _tabPageMaxWidth;
    debugPrint('adjusted tab page width: $_tabPageMinWidth~$_tabPageMaxWidth');
    debugPrint('-----------------------------------');
  }

  void updatePageHeight(bool expandBanner) {
    double availableHeight = (expandBanner)
        ? Global.device.featureContentHeight - _expandedBannerHeight
        : Global.device.featureContentHeight - _bannerHeight;
    debugPrint('----');
    debugPrint('content available height: $availableHeight');

    _tabPageMaxHeight = availableHeight;
    debugPrint('tab page height: $_barMinWidth~$_barMaxWidth');
  }

  double get bannerHeight => _bannerHeight;
  double get expandedBannerHeight => _expandedBannerHeight;

  double get shortcutMaxHeight => _shortcutMaxHeight;
  double get shortcutMaxHeightUser => _shortcutMaxHeight - shortcutTitleHeight;
  double get shortcutMinHeight => _shortcutMinHeight;

  double get barMaxWidth => _barMaxWidth;
  double get barMinWidth => _barMinWidth;
  double get barMaxHeight => _tabPageMaxHeight;
  double get barItemWidth => _barItemWidth;
  double get barItemHeight => _barItemHeight;

  double get pageMaxWidth => _tabPageMaxWidth;
  double get pageMinWidth => _tabPageMinWidth;
  double get pageMaxHeight => _tabPageMaxHeight;

  double get userPageMaxHeight => _tabPageMaxHeight + shortcutTitleHeight;

  double get widthFactor => _tabWidthFactor;
}

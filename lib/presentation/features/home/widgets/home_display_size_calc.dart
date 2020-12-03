import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/font_size.dart';

class HomeDisplaySizeCalc {
  final double _bannerImageScale = 600.0 / Global.device.width;
  final double marqueeHeight = 36.0;
  final double shortcutIconSize = 28.0;
  final double shortcutTextHeight = FontSize.NORMAL.value * 2.75;
  final double _barItemInset = 8.0;

  double _bannerHeight;

  double _shortcutMaxHeight;

  double _barWidth;
  double _barItemWidth;

  double _tabPageMinWidth;
  double _tabPageMaxWidth;
  double _tabPageMaxHeight;

  HomeDisplaySizeCalc() {
    debugPrint('--------HomeDisplaySizeCalc--------');
    double availableWidth =
        Global.device.width - Global.device.safeHorizontalPadding;

    /// Tab Bar
    _barWidth = 90 * Global.device.widthScale;
    // debugPrint('available width: $availableWidth');
    // debugPrint('tab bar width: $_barMaxWidth');

    if (_barWidth > 100) _barWidth = 100;
    _barItemWidth = _barWidth - _barItemInset;
    debugPrint('adjusted tab bar width: $_barWidth, item: $barItemWidth');
    debugPrint('----');

    /// Shortcut
    _shortcutMaxHeight = shortcutIconSize + shortcutTextHeight + 16.0;
    debugPrint('shortcut box height: $_shortcutMaxHeight');
    debugPrint('----');

    /// Banners
    // for normal height banners
    _bannerHeight = 231 / _bannerImageScale;
    debugPrint('banner height: $_bannerHeight');

    /// Tab Page
    double availableHeight =
        Global.device.featureContentHeight - _bannerHeight - _shortcutMaxHeight;
    _tabPageMaxHeight = availableHeight;
    debugPrint('tab page height: $_tabPageMaxHeight');

    _tabPageMinWidth = Global.device.width * 0.5;
    _tabPageMaxWidth = availableWidth - _barWidth - 16;
    if (_tabPageMaxWidth < _tabPageMinWidth) {
      _tabPageMinWidth = _tabPageMaxWidth;
    }
    debugPrint('tab page width: $_tabPageMinWidth~$_tabPageMaxWidth');
    debugPrint('-----------------------------------');
  }

  void updateBarWidth(double barWidth) {
    double oldWidth = _barWidth;

    /// Tab Bar
    _barWidth = barWidth + _barItemInset;
    if (_barWidth > 100) _barWidth = 100;
    _barItemWidth = _barWidth - _barItemInset;
    debugPrint('updated tab bar width: $_barWidth, item: $barItemWidth');

    /// Tab Page
    _tabPageMaxWidth -= _barWidth - oldWidth;
    if (_tabPageMaxWidth < _tabPageMinWidth) {
      _tabPageMinWidth = _tabPageMaxWidth;
    }
    debugPrint('updated tab page width: $_tabPageMinWidth~$_tabPageMaxWidth');
  }

  double get bannerHeight => _bannerHeight;

  double get shortcutMaxHeight => _shortcutMaxHeight;

  double get barMaxWidth => _barWidth;

  double get barItemWidth => _barItemWidth;

  double get pageMaxWidth => _tabPageMaxWidth;

  double get pageMinWidth => _tabPageMinWidth;

  double get pageMaxHeight => _tabPageMaxHeight;
}

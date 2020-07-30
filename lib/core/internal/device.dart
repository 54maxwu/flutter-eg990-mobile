import 'dart:core';

import 'package:flutter/material.dart' show MediaQueryData, Orientation;
import 'package:flutter_ty_mobile/core/internal/global.dart';

class Device {
  final bool isIos;
  final MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;
  // device status bar
  double _screenTopPadding;
  // device virtual key
  double _screenBottomInset;
  // screen width compare with test device
  double _screenWidthScale;
  // screen height compare with test device
  double _screenHeightScale;
  // computed button height
  double _screenButtonHeight;

  Device(this._mediaQueryData, this.isIos) {
    _screenWidth = double.parse(_mediaQueryData.size.width.toStringAsFixed(2));
    _screenHeight =
        double.parse(_mediaQueryData.size.height.toStringAsFixed(2));
    _screenWidthScale = _screenWidth / Global.TEST_DEVICE_WIDTH;
    _screenHeightScale = _screenHeight / Global.TEST_DEVICE_HEIGHT;
    _screenTopPadding = _mediaQueryData.viewPadding.top;
    _screenBottomInset = _mediaQueryData.viewInsets.bottom;
    _screenButtonHeight = (_screenHeightScale > 1)
        ? (36 * _screenHeightScale).ceilToDouble()
        : 36.0;
    print('Device Inset: ${_mediaQueryData.viewInsets}');
    print('Device Padding: ${_mediaQueryData.viewPadding}');
  }

  @override
  String toString() {
    return 'width=$_screenWidth\n'
        'width scale=$_screenWidthScale\n'
        'height=$_screenHeight\n'
        'height scale=$_screenHeightScale\n'
        'inset=$_screenBottomInset\n'
        'button=$_screenButtonHeight';
  }

  /// device's current orientation
  Orientation get orientation => _mediaQueryData.orientation;

  /// screen's ratio = width / height
  double get ratio => _mediaQueryData.size.aspectRatio;

  /// screen's ratio = height / width
  double get ratioHor => _mediaQueryData.size.flipped.aspectRatio;

  /// device's width
  double get width => _screenWidth;

  /// device's height
  double get height => _screenHeight;

  /// device's width scale
  double get widthScale => _screenWidthScale;

  /// device's height
  double get heightScale => _screenHeightScale;

  double get safePadding =>
      _mediaQueryData.padding.left + _mediaQueryData.padding.right;

  /// device's relative button height
  double get comfortButtonHeight => _screenButtonHeight;

  double get featureContentHeight =>
      _screenHeight -
      Global.APP_TOOLS_HEIGHT -
      _screenBottomInset -
      _screenTopPadding;
}

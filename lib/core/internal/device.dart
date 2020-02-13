import 'dart:core';

import 'package:flutter/material.dart';

class Device {
  MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;

  Device(this._mediaQueryData, this._screenWidth, this._screenHeight);

  @override
  String toString() {
    return 'width=$_screenWidth height=$_screenHeight';
  }

  dynamic get width => _screenWidth;
  dynamic get height => _screenHeight;
}

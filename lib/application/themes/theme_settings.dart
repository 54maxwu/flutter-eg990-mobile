import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart' show ThemeData;
import 'package:flutter_eg990_mobile/application/data/app_cache.dart';
import 'package:flutter_eg990_mobile/presentation/screens/streams/app_preference_streams.dart';

import 'theme_color_enum.dart';
import 'theme_color_interface.dart';
import 'theme_interface.dart' show ThemeInterface;

class ThemeSettings implements ThemeInterface {
  final ThemeColorEnum _default = ThemeColorEnum.DEFAULT;

  ThemeColorEnum _themeEnum;
  ThemeData _data;
  ThemeColorInterface _interface;

  ThemeColorEnum get colorEnum => _themeEnum;

  ThemeData get data => _data;

  ThemeColorInterface get interface => _interface;

  bool get isDefaultColor => ThemeColorEnum.DEFAULT.label == _themeEnum.label;

  ThemeSettings() {
    _themeEnum = _default;
    _interface = _default.interface;
    _data = _interface.data;
  }

  bool setTheme(ThemeColorEnum themeEnum, {bool notify = true}) {
    if (_themeEnum == themeEnum) return null;
    try {
      _themeEnum = themeEnum;
      _interface = themeEnum.interface;
      _data = _interface.data;
      debugPrint('change app theme to ${themeEnum.value}');
      return true;
    } catch (e) {
      debugPrint('change app theme error: $e');
      return false;
    } finally {
      if (notify) {
        appPreference.notifyThemeChange(_themeEnum);
        AppCache.saveAppTheme(themeEnum);
      }
    }
  }
}

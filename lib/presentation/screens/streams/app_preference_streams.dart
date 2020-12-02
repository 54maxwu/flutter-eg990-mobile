import 'dart:async' show StreamController, Stream;

import 'package:flutter_eg990_mobile/application/themes/theme_color_enum.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';

AppPreferenceStreams get appPreference => sl.get<AppPreferenceStreams>();

///
/// Stream user [LoginStatus] through out the app to control UI state
///
class AppPreferenceStreams {
  static final tag = 'AppPreferenceStreams';

  final StreamController<String> _languageControl =
      StreamController<String>.broadcast();

  final StreamController<ThemeColorEnum> _themeControl =
      StreamController<ThemeColorEnum>.broadcast();

  /// App Relative
  Stream<String> get languageStream => _languageControl.stream;

  Stream<ThemeColorEnum> get themeStream => _themeControl.stream;

  setLanguage(String lang) {
    _languageControl.sink.add(lang);
  }

  notifyThemeChange(ThemeColorEnum color) {
    _themeControl.sink.add(color);
  }

  dispose() {
    MyLogger.warn(msg: 'disposing app streams!!', tag: tag);
    _languageControl.close();
    _themeControl.close();
  }
}

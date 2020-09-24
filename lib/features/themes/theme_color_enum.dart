import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_dark.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_light.dart';
import 'package:vnum/vnum.dart';

@VnumDefinition
class ThemeColorEnum extends Vnum<String> {
  static const ThemeColorEnum DEFAULT = const ThemeColorEnum.define('default');

  static const ThemeColorEnum LIGHT = const ThemeColorEnum.define('light');

  static const ThemeColorEnum DARK = const ThemeColorEnum.define('dark');

  /// Used for defining cases
  const ThemeColorEnum.define(String fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory ThemeColorEnum(String value) => Vnum.fromValue(value, ThemeColorEnum);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(ThemeColorEnum);

  String get label {
    switch (value) {
      case 'dark':
        return localeStr.themeColorDark;
      case 'light':
        return localeStr.themeColorLight;
      default:
        return localeStr.themeColorDefault;
    }
  }

  ThemeColorInterface get interface {
    switch (value) {
      case 'dark':
        return ThemeDark();
      case 'light':
        return ThemeLight();
      default:
        return ThemeDark();
    }
  }
}

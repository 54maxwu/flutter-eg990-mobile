import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

@VnumDefinition
class RegisterChannelEnum extends Vnum<int> {
  /// Case Definition
  static const RegisterChannelEnum facebook =
      const RegisterChannelEnum.define(1);
  static const RegisterChannelEnum google = const RegisterChannelEnum.define(2);
  static const RegisterChannelEnum line = const RegisterChannelEnum.define(3);
  static const RegisterChannelEnum ads = const RegisterChannelEnum.define(4);
  static const RegisterChannelEnum friend = const RegisterChannelEnum.define(5);
  static const RegisterChannelEnum other = const RegisterChannelEnum.define(6);

  /// Used for defining cases
  const RegisterChannelEnum.define(int fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory RegisterChannelEnum(int value) =>
      Vnum.fromValue(value, RegisterChannelEnum);

  /// (optional) Extend your Vnums
  static List<RegisterChannelEnum> get mapAll =>
      Vnum.allCasesFor(RegisterChannelEnum)
          .map((e) => e as RegisterChannelEnum)
          .toList();
}

extension RegisterChannelEnumExtension on RegisterChannelEnum {
  String get label {
    switch (value) {
      case 1:
        return localeStr.registerChannelOptionFb;
      case 2:
        return localeStr.registerChannelOptionGoogle;
      case 3:
        return localeStr.registerChannelOptionLine;
      case 4:
        return localeStr.registerChannelOptionAd;
      case 5:
        return localeStr.registerChannelOptionRef;
      case 6:
        return localeStr.registerChannelOptionOther;
      default:
        return '??';
    }
  }
}

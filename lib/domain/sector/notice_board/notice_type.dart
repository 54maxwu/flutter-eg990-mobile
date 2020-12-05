import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:vnum/vnum.dart';

@VnumDefinition
class NoticeType extends Vnum<String> {
  /// Case Definition
  static const NoticeType general = const NoticeType.define('marquee');
  static const NoticeType maintenance = const NoticeType.define('maintenance');
  static const NoticeType undefined = const NoticeType.define('unknown');

  /// Used for defining cases
  const NoticeType.define(String fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory NoticeType(String value) =>
      Vnum.fromValue(value, NoticeType) ?? NoticeType.undefined;

  static List<NoticeType> get basicTabs => [
        NoticeType.general,
        NoticeType.maintenance,
      ];

  String get label {
    switch (value) {
      case 'marquee':
        return localeStr.noticeTabGeneral;
      case 'maintenance':
        return localeStr.noticeTabMaintenance;
      default:
        return '???';
    }
  }

  int get id {
    switch (value) {
      case 'marquee':
        return 0;
      case 'maintenance':
        return 1;
      default:
        return -1;
    }
  }
}

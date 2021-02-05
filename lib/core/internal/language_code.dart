import 'package:meta/meta.dart';
import 'package:vnum/vnum.dart';

final LanguageCode defaultLocale = LanguageCode.th;

@VnumDefinition
class LanguageCode extends Vnum<LanguageData> {
  /// Case Definition
  static const LanguageCode zh = const LanguageCode.define(const LanguageData(
    code: 'zh',
    optionString: 'CH',
    contentKey: 'content_cn',
    imageUrl: '/images/lang_chn.jpg',
    webCode: 'zh-cn',
  ));

  static const LanguageCode en = const LanguageCode.define(const LanguageData(
    code: 'en',
    optionString: 'EN',
    contentKey: 'content_us',
    imageUrl: '/images/lang_eng.jpg',
    webCode: 'en-us',
  ));

  static const LanguageCode vn = const LanguageCode.define(const LanguageData(
    code: 'vi',
    optionString: 'VN',
    contentKey: 'content_vn',
    imageUrl: '/images/lang_vnm.jpg',
    webCode: 'vn-us',
  ));

  static const LanguageCode th = const LanguageCode.define(const LanguageData(
    code: 'th',
    optionString: 'TH',
    contentKey: 'content_th',
    imageUrl: '/images/lang_thai.jpg',
    webCode: 'thai',
  ));

  /// Used for defining cases
  const LanguageCode.define(LanguageData fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory LanguageCode(LanguageData value) =>
      Vnum.fromValue(value, LanguageCode);

  /// Iterating cases
  static List<LanguageCode> get listAll =>
      Vnum.allCasesFor(LanguageCode).map((e) => e as LanguageCode).toList();

  static LanguageCode getByCode(String code) => listAll.singleWhere(
        (data) => data.value.code == code,
        orElse: () => defaultLocale,
      );
}

class LanguageData {
  final String code;
  final String optionString;
  final String contentKey;
  final String imageUrl;
  final String webCode;

  const LanguageData({
    @required this.code,
    @required this.optionString,
    @required this.contentKey,
    @required this.imageUrl,
    @required this.webCode,
  });
}

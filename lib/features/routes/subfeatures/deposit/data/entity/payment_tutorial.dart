import 'package:flutter_eg990_mobile/builders/dataclass/dataclass.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/deposit/data/entity/payment_enum_data.dart';
import 'package:meta/meta.dart' show required;
import 'package:vnum/vnum.dart';

part 'payment_tutorial.g.dart';

@dataClass
class PaymentTutorialData {
  final String typeKey;
  final String key;
  final String tutorialButtonText;
  final String tutorialLinkDesc;
  final List<PaymentTutorialItem> tutorials;

  const PaymentTutorialData({
    @required this.typeKey,
    @required this.key,
    this.tutorialButtonText,
    this.tutorialLinkDesc,
    this.tutorials,
  });
}

@VnumDefinition
class PaymentTutorial extends Vnum<PaymentTutorialData> {
  /// Case Definition
  static PaymentTutorial wechat = PaymentTutorial.define(PaymentTutorialData(
    typeKey: '2',
    key: 'wechatpay',
    tutorialButtonText: localeStr.depositNewbieWechat0,
    tutorials: [
      PaymentTutorialItem(
        sortId: 30,
        value: localeStr.depositNewbieWechat1,
        type: TutorialItemType.Desc,
      ),
      PaymentTutorialItem(
        sortId: 31,
        value: localeStr.depositNewbieWechat2,
        type: TutorialItemType.Desc,
      ),
      PaymentTutorialItem(
        sortId: 32,
        value: 'images/user/wch_teaching.gif',
        type: TutorialItemType.Image,
      ),
    ],
  ));

  static PaymentTutorial quickPay = PaymentTutorial.define(PaymentTutorialData(
    typeKey: '2',
    key: 'quickpay',
    tutorialButtonText: localeStr.depositNewbieQuick0,
    tutorials: List.generate(
      5,
      (index) => PaymentTutorialItem(
        sortId: 41 + index,
        value: 'images/newbie/KuaiJie_jjk_0${index + 1}.png',
        type: TutorialItemType.Image,
      ),
    ),
  ));

  static PaymentTutorial aliPay = PaymentTutorial.define(PaymentTutorialData(
    typeKey: '2',
    key: 'alipay',
    tutorialButtonText: localeStr.depositNewbieAli0,
    tutorials: (List.generate(
          5,
          (index) => PaymentTutorialItem(
            sortId: 42 + index * 2,
            value: 'images/newbie/gfbehk_mo0${index + 1}.png',
            type: TutorialItemType.Image,
          ),
        ) +
        [
          PaymentTutorialItem(
            sortId: 41,
            value: localeStr.depositNewbieAli1,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 43,
            value: localeStr.depositNewbieAli2,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 45,
            value: localeStr.depositNewbieAli3,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 47,
            value: localeStr.depositNewbieAli4,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 49,
            value: localeStr.depositNewbieAli5,
            type: TutorialItemType.Desc,
          ),
        ])
      ..sort((a, b) => a.sortId.compareTo(b.sortId)),
  ));

  static PaymentTutorial jdcom = PaymentTutorial.define(PaymentTutorialData(
    typeKey: '2',
    key: 'jdcom',
    tutorialButtonText: localeStr.depositNewbieJd0,
    tutorials: (List.generate(
          5,
          (index) => PaymentTutorialItem(
            sortId: 52 + index * 2,
            value: 'images/newbie/jdpay_0${index + 1}.jpg',
            type: TutorialItemType.Image,
          ),
        ) +
        [
          PaymentTutorialItem(
            sortId: 51,
            value: localeStr.depositNewbieJd1,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 53,
            value: localeStr.depositNewbieJd2,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 55,
            value: localeStr.depositNewbieJd3,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 57,
            value: localeStr.depositNewbieJd4,
            type: TutorialItemType.Desc,
          ),
        ])
      ..sort((a, b) => a.sortId.compareTo(b.sortId)),
  ));

  static PaymentTutorial union = PaymentTutorial.define(PaymentTutorialData(
    typeKey: '2',
    key: 'unionpay',
    tutorialButtonText: localeStr.depositNewbieUnion0,
    tutorials: (List.generate(
          4,
          (index) => PaymentTutorialItem(
            sortId: 72 + index * 2,
            value: 'images/newbie/elpayth_0${index + 1}.png?v2',
            type: TutorialItemType.Image,
          ),
        ) +
        [
          PaymentTutorialItem(
            sortId: 71,
            value: localeStr.depositNewbieUnion1,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 73,
            value: localeStr.depositNewbieUnion2,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 75,
            value: localeStr.depositNewbieUnion3,
            type: TutorialItemType.Desc,
          ),
          PaymentTutorialItem(
            sortId: 77,
            value: localeStr.depositNewbieUnion4,
            type: TutorialItemType.Desc,
          ),
        ])
      ..sort((a, b) => a.sortId.compareTo(b.sortId)),
  ));

  static PaymentTutorial cgPay = PaymentTutorial.define(PaymentTutorialData(
    typeKey: '2',
    key: 'cgp',
    tutorialButtonText: localeStr.depositNewbieCgp0,
    tutorials: [
      PaymentTutorialItem(
        sortId: 81,
        value: 'images/download/GOBO_QR.png',
        link: 'https://www.gamewallet.asia/version.php?fn=gp_a&latest',
        type: TutorialItemType.Image,
      ),
      PaymentTutorialItem(
        sortId: 82,
        value: localeStr.depositNewbieButtonCgp2,
        link: 'https://www.vip66729.com/pdf/cpw.pdf',
        type: TutorialItemType.Button,
      ),
    ],
  ));

  /// Used for defining cases
  const PaymentTutorial.define(PaymentTutorialData fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory PaymentTutorial(PaymentTutorialData value) =>
      Vnum.fromValue(value, PaymentTutorial);
}

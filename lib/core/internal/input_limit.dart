///
/// Field input length limit
/// remember to check the locale strings
///
class InputLimit {
  static const int PASSWORD_MIN_OLD = 6;
  static const int PASSWORD_MIN = 8;
  static const int PASSWORD_MAX = 20;

  static const int ACCOUNT_MIN = 6;
  static const int ACCOUNT_MAX = 12;

  static const int AGENT_ACCOUNT_MIN = 3;
  static const int AGENT_ACCOUNT_MAX = 12;

  static const int PHONE_MIN = 10;
  static const int PHONE_MAX = 14;

  static const int NAME_MIN = 2;
  static const int NAME_MAX = 12;

  static const int POSTCODE_MAX = 8;
  static const int SHORT_ADDRESS_MAX = 50;
  static const int ADDRESS_MAX = 100;
  static const int NOTE_MAX = 30;

  static const int CARD_MIN = 6;
  static const int CARD_MAX = 19; // vn365, vw:6~19   85bet kk:6~18   bkk:16~19

  static const int RECOMMEND = 6;
  static const int VERIFY = 8;
  static const int DATE = 10;
  static const int AMOUNT = 12;

  static const int WECHAT_MIN = 2;
  static const int WECHAT_MAX = 20;
}

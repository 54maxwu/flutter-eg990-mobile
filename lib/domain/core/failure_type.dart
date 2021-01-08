import 'package:vnum/vnum.dart';

@VnumDefinition
class FailureType extends Vnum<int> {
  /// Case Definition
  static const FailureType INJECTOR = const FailureType.define(0);
  static const FailureType PROVIDER = const FailureType.define(10);
  static const FailureType INHERIT = const FailureType.define(20);
  static const FailureType TASK = const FailureType.define(40);
  static const FailureType JSON = const FailureType.define(50);
  static const FailureType NAVIGATOR = const FailureType.define(70);
  static const FailureType TOKEN = const FailureType.define(80);

  static const FailureType UPDATE = const FailureType.define(100);
  static const FailureType EVENT = const FailureType.define(200);
  static const FailureType USER = const FailureType.define(300);
  static const FailureType WEB = const FailureType.define(400);
  static const FailureType SERVICE = const FailureType.define(900);

  static const FailureType HOME = const FailureType.define(1000);
  static const FailureType BANNER = const FailureType.define(1100);
  static const FailureType MARQUEE = const FailureType.define(1200);
  static const FailureType GAMES = const FailureType.define(1300);
  static const FailureType GAME_URL = const FailureType.define(1400);

  static const FailureType PROMO = const FailureType.define(2000);
  static const FailureType NOTICE = const FailureType.define(2100);
  static const FailureType VIP = const FailureType.define(2400);
  static const FailureType STORE = const FailureType.define(2700);
  static const FailureType TUTORIAL = const FailureType.define(2900);

  static const FailureType MEMBER = const FailureType.define(3000);
  static const FailureType BANKCARD = const FailureType.define(3100);
  static const FailureType DEPOSIT = const FailureType.define(3200);
  static const FailureType TRANSFER = const FailureType.define(3300);
  static const FailureType WITHDRAW = const FailureType.define(3400);
  static const FailureType WALLET = const FailureType.define(3500);
  static const FailureType BALANCE = const FailureType.define(3600);

  static const FailureType TRANSACTIONS = const FailureType.define(4000);
  static const FailureType BETS = const FailureType.define(4100);
  static const FailureType DEALS = const FailureType.define(4200);

  static const FailureType AGENT = const FailureType.define(6000);

  static const FailureType NOT_DEFINED = const FailureType.define(9000);

  /// Used for defining cases
  const FailureType.define(int fromValue) : super.define(fromValue);
}

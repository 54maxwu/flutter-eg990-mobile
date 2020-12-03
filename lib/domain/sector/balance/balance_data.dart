import 'package:flutter_eg990_mobile/builders/dataclass/dataclass.dart';
import 'package:meta/meta.dart';

part 'balance_data.g.dart';

@dataClass
class BalanceData extends _$BalanceData {
  final String platform;
  final String amount;
  final String error;

  const BalanceData(
      {@required this.platform, @required this.amount, this.error});
}

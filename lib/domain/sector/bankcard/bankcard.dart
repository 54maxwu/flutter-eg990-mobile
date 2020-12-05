import 'package:flutter_eg990_mobile/builders/dataclass/dataclass.dart';
import 'package:meta/meta.dart' show required;

part 'bankcard.g.dart';

@dataClass
class Bankcard extends _$Bankcard {
  final bool hasCard;
  final String bankName;
  final String bankAccount;
  final String accountName;

  const Bankcard.empty({
    this.bankName = '',
    this.bankAccount = '',
    this.accountName = '',
  }) : this.hasCard = false;

  const Bankcard({
    @required this.bankName,
    @required this.bankAccount,
    @required this.accountName,
  }) : this.hasCard = true;
}

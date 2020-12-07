import 'package:meta/meta.dart' show immutable, required;

@immutable
class Bankcard {
  final bool hasCard;
  final String bankName;
  final String bankAccount;
  final String accountName;

  const Bankcard.empty({
    this.bankName = '',
    this.bankAccount = '',
    this.accountName = '',
  }) : this.hasCard = false;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Bankcard({
    @required this.bankName,
    @required this.bankAccount,
    @required this.accountName,
    this.hasCard = true,
  });

  Bankcard copyWith({
    bool hasCard,
    String bankName,
    String bankAccount,
    String accountName,
  }) {
    if ((hasCard == null || identical(hasCard, this.hasCard)) &&
        (bankName == null || identical(bankName, this.bankName)) &&
        (bankAccount == null || identical(bankAccount, this.bankAccount)) &&
        (accountName == null || identical(accountName, this.accountName))) {
      return this;
    }

    return new Bankcard(
      hasCard: hasCard ?? this.hasCard,
      bankName: bankName ?? this.bankName,
      bankAccount: bankAccount ?? this.bankAccount,
      accountName: accountName ?? this.accountName,
    );
  }

  @override
  String toString() {
    return 'Bankcard{hasCard: $hasCard, bankName: $bankName, bankAccount: $bankAccount, accountName: $accountName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bankcard &&
          runtimeType == other.runtimeType &&
          hasCard == other.hasCard &&
          bankName == other.bankName &&
          bankAccount == other.bankAccount &&
          accountName == other.accountName);

  @override
  int get hashCode =>
      hasCard.hashCode ^
      bankName.hashCode ^
      bankAccount.hashCode ^
      accountName.hashCode;

//</editor-fold>

}
